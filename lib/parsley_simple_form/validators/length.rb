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
          next unless (key = PARSLEY_VALIDATES[option])
          options[:message] = options_message_for(option)
          options[:count] = value
          h[key] = if option == :is
                     "[#{value}, #{value}]"
                   else
                     value
                   end
          h["#{key}-message"] = parsley_error_message(options)
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
