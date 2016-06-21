module ParsleySimpleForm
  module Validators
    module Exclusion
      def attribute_validate(*args)
        options = args.extract_options!
        options[:message] = :exclusion
        exlist_string = options[:validate].options.slice(:in, :within).values.join(', ')
        { "parsley-exlist": exlist_string, "parsley-exlist-message": parsley_error_message(options) }
      end
    end
  end
end

module ActiveModel
  module Validations
    class ExclusionValidator < EachValidator
      include ParsleySimpleForm::Validators::Exclusion
    end
  end
end
