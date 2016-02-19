module ParsleySimpleForm
  module Validators
    class Base
      attr_reader :object, :error, :validate, :options, :attribute_name

      def initialize(object, validate, attribute_name)
        @object = object
        @error = object.errors
        @validate = validate
        @options = validate.options.dup
        @attribute_name = attribute_name
      end

      def message_error(options_message = {}, other_value_validate = nil)
        generate_message(options_message, other_value_validate)
      end

      protected

      def generate_message(options_message, other_value_validate = nil)
        error.generate_message(attribute_name, other_value_validate || validate.kind, options.merge(options_message))
      end
    end
  end
end

Status API Training Shop Blog About Pricing
