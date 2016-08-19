module ParsleySimpleForm
  module Validators
    module Inclusion
      def initialize(options)
        @parsley_name = 'inlist'
        super
      end

      def attribute_validate(*args)
        options = args.extract_options!
        options[:message] = :inclusion
        inlist_string = options[:validate].options.slice(:in, :within).values.join(', ')
        { "parsley-inlist": inlist_string, "parsley-inlist-message": parsley_error_message(options) }
      end
    end
  end
end

module ActiveModel
  module Validations
    class InclusionValidator < EachValidator
      include ParsleySimpleForm::Validators::Inclusion
    end
  end
end
