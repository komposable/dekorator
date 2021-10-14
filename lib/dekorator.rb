# frozen_string_literal: true

require "dekorator/version"
require "delegate"

# :nodoc
module Dekorator
  # @api private
  module Generators; end

  # :nodoc:
  class DecoratorNotFound < ArgumentError; end

  # Base decorator.
  class Base < SimpleDelegator
    class << self
      # Decorate an object with a decorator.
      #
      # @param object_or_enumerable [Object, Enumerable] the object or Enumerable to decorate.
      # @param with [Class] the decorator class to use. If empty a decorator will be guessed.
      #
      # @return [Dekorator::Base] if object given.
      # @return [Enumerable] if Enumerable given.
      #
      # @raise [DecoratorNotFound] if decorator is not found.
      def decorate(object_or_enumerable, with: nil)
        return object_or_enumerable unless decorable?(object_or_enumerable)

        with ||= _decorator_class

        object_or_enumerable = _decorate(object_or_enumerable, with: with)

        if block_given?
          yield object_or_enumerable
        else
          object_or_enumerable
        end
      end

      # Define that an association must be decorated.
      #
      # @param relation_name [String, Symbol] the association name to decorate.
      # @param with [Class] the decorator class to use. If empty a decorator will be guessed.
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
          @_decorated_associations[relation_name] ||= decorate(__getobj__.public_send(relation_name), with: with)
        end
      end

      # Guess and returns the decorated object class.
      #
      # @return [Class] the decorated object class.
      def base_class
        _safe_constantize(name.sub("Decorator", ""))
      end

      private

      # @api private
      def _decorate(object_or_enumerable, with: nil)
        with = _guess_decorator(object_or_enumerable) if with.nil? || with == :__guess__

        if object_or_enumerable.is_a? Enumerable
          object_or_enumerable.lazy.map { |object| _decorate(object, with: with) }
        else
          with.new(object_or_enumerable)
        end
      end

      # @api private
      def _guess_decorator(object_or_enumerable)
        object_or_enumerable = object_or_enumerable.first if object_or_enumerable.is_a? Enumerable

        _safe_constantize("#{object_or_enumerable.class}Decorator") \
          || raise(DecoratorNotFound, "Can't guess decorator for #{object_or_enumerable.class} object")
      end

      # @api private
      def decorable?(object_or_enumerable)
        return false if defined?(ActiveRecord::Relation) \
          && object_or_enumerable.is_a?(ActiveRecord::Relation) \
          && object_or_enumerable.blank?

        return false if object_or_enumerable.respond_to?(:empty?) && object_or_enumerable.empty?
        return false if !object_or_enumerable
        return false if object_or_enumerable.is_a?(Dekorator::Base)

        true
      end

      # @api private
      def _safe_constantize(class_name)
        Object.const_get(class_name)
      rescue NameError => _
        nil
      end

      # @api private
      def _decorator_class
        return nil if self == Dekorator::Base

        self
      end
    end

    # Decorate an object
    #
    # @param object [Object] object to decorate.
    def initialize(object)
      @_decorated_associations = {}

      super(object)
    end

    # Decorate an object with a decorator.
    #
    # @param object_or_enumerable [Object, Enumerable] the object or Enumerable to decorate.
    # @param with [Class] the decorator class to use. If empty a decorator will be guessed.
    #
    # @return [Dekorator::Base] if object given.
    # @return [Enumerable] if Enumerable given.
    #
    # @raise [DecoratorNotFound] if decorator is not found.c
    def decorate(object_or_enumerable, with: :__guess__)
      self.class.decorate(object_or_enumerable, with: with)
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
