# frozen_string_literal: true

require "dekorator/version"
require "delegate"

# :nodoc
module Dekorator
  # @api private
  module Generators; end

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
        return object_or_collection if decorable_object?(object_or_collection)

        with ||= self if with != :__guess__ && self != Dekorator::Base
        with = _guess_decorator(object_or_collection) if with.nil? || with == :__guess__

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
      #   class UserDecorator < Dekorator::Base
      #     decorates_association :posts
      #   end
      #
      #   # A decorator could be precise
      #   class UserDecorator < Dekorator::Base
      #     decorates_association :posts, PostDecorator
      #   end
      def decorates_association(relation_name, with: :__guess__)
        relation_name = relation_name.to_sym

        define_method(relation_name) do
          @decorated_associations[relation_name] ||= decorate(__getobj__.public_send(relation_name), with: with)
        end
      end

      # Guess and returns the decorated object class.
      #
      # @return [Class] the decorated object class.
      def base_class
        _safe_constantize(name.gsub("Decorator", ""))
      end

      private

      def _decorate(object_or_enumerable, with:)
        if !object_or_enumerable.is_a? Enumerable
          with.new(object_or_enumerable)
        else
          object_or_enumerable.lazy.map { |object| _decorate(object, with: with) }
        end
      end

      def _guess_decorator(object_or_enumerable)
        object_or_enumerable = object_or_enumerable.first if object_or_enumerable.is_a? Enumerable

        _safe_constantize("#{object_or_enumerable.class}Decorator") \
          || raise(DecoratorNotFound, "Can't guess decorator for #{object_or_enumerable.class.name} object")
      end

      def decorable_object?(object_or_collection)
        (object_or_collection.respond_to?(:empty?) && object_or_collection.empty?) \
          || !object_or_collection \
          || object_or_collection.is_a?(Dekorator::Base) \
      end

      def _safe_constantize(class_name)
        Object.const_get(class_name)
      rescue NameError => _e
        nil
      end
    end

    # :nodoc
    def initialize(object)
      @decorated_associations = {}

      super(object)
    end

    # :nodoc
    def decorate(object_or_collection, with: :__guess__)
      self.class.decorate(object_or_collection, with: with)
    end

    # Returns the decorated object.
    #
    # @return [Object] the decorated object.
    def object
      __getobj__
    end
  end
end

require "dekorator/railtie" if defined?(Rails)
