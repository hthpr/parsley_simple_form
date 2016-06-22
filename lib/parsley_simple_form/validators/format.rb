module ParsleySimpleForm
  module Validators
    module Format
      def attribute_validate(*args)
        options = args.extract_options!
        options[:message] = :invalid
        validate = options[:validate].options
        regexp = validate.slice(:with, :without).values.first.to_javascript
        if validate[:with]
          { "parsley-pattern": regexp, "parsley-pattern-message": parsley_error_message(options) }
        elsif validate[:without]
          { "parsley-inversepattern": regexp, "parsley-inversepattern-message": parsley_error_message(options) }
        end
      end
    end
  end
end

module ActiveModel
  module Validations
    class FormatValidator < EachValidator
      include ParsleySimpleForm::Validators::Format
    end
  end
end
