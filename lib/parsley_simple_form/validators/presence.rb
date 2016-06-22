module ParsleySimpleForm
  module Validators
    module Presence
      def attribute_validate(*args)
        options = args.extract_options!
        options[:message] = :blank
        { 'parsley-required': true, 'parsley-required-message': parsley_error_message(options) }
      end
    end
  end
end

module ActiveModel
  module Validations
    class PresenceValidator < EachValidator
      include ParsleySimpleForm::Validators::Presence
    end
  end
end
