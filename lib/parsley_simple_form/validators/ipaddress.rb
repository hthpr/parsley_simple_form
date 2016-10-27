module ParsleySimpleForm
  module Validators
    module IPAddress
      def initialize(options)
        @parsley_name = 'ipaddress'
        super
      end

      def validate_each(record, attribute, value)
        case options[:type]
        when :ipv4
          record.errors[attribute] << (options[:message] || 'is not a valid IP address') unless value =~ Resolv::IPv4::Regex
        when :ipv6
          record.errors[attribute] << (options[:message] || 'is not a valid IP address') unless value =~ Resolv::IPv6::Regex
        else
          record.errors[attribute] << (options[:message] || 'is not a valid IP address')
        end
      end

      def attribute_validate(*args)
        options = args.extract_options!
        options[:message] = :invalid
        type = options[:validate].options[:type]
        { 'parsley-ipaddress': type, 'parsley-ipaddress-message': parsley_error_message(options) }
      end
    end
  end
end

module ActiveRecord
  module Validations
    class IpaddressValidator < ActiveModel::EachValidator
      include ParsleySimpleForm::Validators::IPAddress
    end
  end
end
