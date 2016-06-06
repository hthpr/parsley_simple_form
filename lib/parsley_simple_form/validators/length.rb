module ParsleySimpleForm
  module Validators
    module Length
      PARSLEY_VALIDATES = {
        minimum: :"parsley-minlength",
        maximum: :"parsley-maxlength",
        is: :"parsley-length"
      }.freeze

      def attribute_validate(*args)
        options = args.extract_options!
        validate = options[:validate].options
        validate.each_with_object({}) do |(option, value), h|
          next unless key = PARSLEY_VALIDATES[option]
          options.merge! message: options_message_for(option), count: value
          args << options
          h.merge! "#{key}-message": parsley_error_message(*args)
          if option == :is
            h.merge! "#{key}": "[#{value}, #{value}]"
          else
            h.merge! "#{key}": value
          end
        end
      end

      private

      def options_message_for(option)
        message = ActiveModel::Validations::LengthValidator::MESSAGES[option]
        return options[message] if options.include? message

        message
      end
    end
  end
end

module ActiveModel
  module Validations
    class LengthValidator < EachValidator
      include ParsleySimpleForm::Validators::Length
    end
  end
end
