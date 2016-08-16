module ParsleySimpleForm
  module Validators
    module IPAddress
      def validate_each(record, attribute, value)
        record.errors[attribute] << (options[:message] || 'is not a valid IP address') unless value =~ Resolv::IPv4::Regex
      end

      def attribute_validate(*args)
        options = args.extract_options!
        options[:message] = :invalid
        type = options[:validate].options.type
        { 'parsley-ipaddress': type, 'parsley-ipaddress-message': parsley_error_message(options) }
      end
    end
  end
end

module ActiveRecord
  module Validations
    class IPAddressValidator < ActiveModel::EachValidator
      include ParsleySimpleForm::Validators::IPAddress
    end
  end
end
