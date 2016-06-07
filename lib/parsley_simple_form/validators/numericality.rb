module ParsleySimpleForm
  module Validators
    module Numericality
      PARSLEY_VALIDATIONS = {
        greater_than: :"parsley-gt",
        greater_than_or_equal_to: :"parsley-min",
        equal_to: :"parsley-eq",
        other_than: :"parsley-ot",
        less_than: :"parsley-lt",
        less_than_or_equal_to: :"parsley-max",
        odd: :"parsley-odd",
        even: :"parsley-even"
      }.freeze

      def attribute_validate(*args)
        options = args.extract_options!
        validate = options[:validate].options
        attributes = validate.each_with_object({}) do |(option, value), h|
          next unless key = PARSLEY_VALIDATIONS[option]
          options[:message] = option
          options[:count] = value
          h[key.to_s] = value
          h["#{key}-message"] = parsley_error_message(options)
        end

        if allow_only_integer?(validate)
          options[:message] = :not_an_integer
          options[:count] = nil
          attributes.merge! "parsley-type": 'digits', 'parsley-type-message': parsley_error_message(options)
        else
          options[:message] = :not_a_number
          options[:count] = nil
          attributes.merge! "parsley-pattern": '/^-?(\d*\.)?\d+(e[-+]?\d+)?$/i', 'parsley-pattern-message': parsley_error_message(options)
        end
      end

      private

      def allow_only_integer?(options)
        options[:only_integer]
      end
    end
  end
end

module ActiveModel
  module Validations
    class NumericalityValidator < EachValidator
      include ParsleySimpleForm::Validators::Numericality
    end
  end
end
