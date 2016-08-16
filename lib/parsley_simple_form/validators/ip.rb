module ParsleySimpleForm
  module Validators
    module Ipv4
      def validate_each(record, attribute, value)
        record.errors[attribute] << (options[:message] || 'is not a valid IP address') unless value =~ Resolv::IPv4::Regex
      end

      def attribute_validate(*args)
        options = args.extract_options!
        options[:message] = :invalid
        { 'parsley-ipv4': true, 'parsley-ipv4-message': parsley_error_message(options) }
      end
    end
  end
end

module ActiveRecord
  module Validations
    class IPv4Validator < ActiveModel::EachValidator
      include ParsleySimpleForm::Validators::Ipv4
    end
  end
end
