# frozen_string_literal: true

require "dekorator/version"
require "active_support/core_ext/object/blank"
require "active_support/core_ext/module/delegation"

module Dekorator
  class DecoratorNotFound < ArgumentError; end

  # Base decorator.
  class Base < SimpleDelegator
    class << self
      # Decorate an object with a decorator.
      #
      # @param object_or_collection [Object, Enumerable] the object or collection to decorate.
      # @option opts [Class] :with the decorator class to use. If empty a decorator will be guessed.
      #
      # @return [Dekorator::Base, ActiveRecord::Relation, Enumerable] the obect or collection decorated.
      #
      # @raise [DecoratorNotFound] if decorator is not found.
      def decorate(object_or_collection, with: nil)
        return object_or_collection if object_or_collection.blank?

        with = _guess_decorator(object_or_collection) if with.nil? && object_or_collection.present?

        raise DecoratorNotFound, "Can't guess decorator for #{object_or_collection.class.name} object" if with.nil?

        object_or_collection = _decorate(object_or_collection, with: with)

        if block_given?
          yield object_or_collection
        else
          object_or_collection
        end
      end

      # Define that an association must be decorated.
      #
      # @param relation_name [String, Symbol] the association name to decorate.
      # @option opts [Class] :with the decorator class to use. If empty a decorator will be guessed.
      #
      # @example Define an association to decorate
      #   class UserDecorator < ApplicationDecorator
      #     decorates_association :posts
      #   end
      #
      #   # A decorator could be precise
      #   class UserDecorator < ApplicationDecorator
      #     decorates_association :posts, PostDecorator
      #   end
      def decorates_association(relation_name, with: nil)
        relation_name = relation_name.to_sym

        define_method(relation_name) do
          association = __getobj__.public_send(relation_name)

          @decorated_associations[relation_name] ||= decorate(association, with: with)
        end
      end

      def base_class
        name.gsub("Decorator", "").safe_constantize
      end

      private

      def _decorate(object_or_enumerable, with: nil)
        if defined?(ActiveRecord::Relation) && object_or_enumerable.is_a?(ActiveRecord::Relation)
          DecoratedEnumerableProxy.new(object_or_enumerable, with)
        elsif object_or_enumerable.is_a? Enumerable
          object_or_enumerable.map { |object| with.new(object) }
        else
          with.new(object_or_enumerable)
        end
      end

      def _guess_decorator(object_or_enumerable)
        object_or_enumerable = object_or_enumerable.first if object_or_enumerable.is_a? Enumerable

        "#{object_or_enumerable.class}Decorator".safe_constantize if object_or_enumerable.present?
      end
    end

    delegate :decorate, to: :class

    def initialize(object)
      @decorated_associations = {}

      super(object)
    end

    def object
      __getobj__
    end
  end

  if defined?(ActiveRecord::Relation)
    class DecoratedEnumerableProxy < DelegateClass(ActiveRecord::Relation)
      include Enumerable

      delegate :as_json, :collect, :map, :each, :[], :all?, :include?,
               :first, :last, :shift, to: :decorated_collection
      delegate :each, to: :to_ary

      def initialize(collection, decorator_class)
        super(collection)

        @decorator_class = decorator_class
      end

      def wrapped_collection
        __getobj__
      end

      def decorated_collection
        @decorated_collection ||= wrapped_collection.collect { |member| @decorator_class.decorate(member) }
      end
      alias to_ary decorated_collection
    end
  end
end

require "dekorator/railtie" if defined?(Rails)
