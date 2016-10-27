module ParsleySimpleForm
  module Validators
    module IPAddress
      def initialize(options)
        @parsley_name = 'ipaddress'
        super
      end

      def validate_each(record, attribute, value)
        record.errors[attribute] << (options[:message] || 'is not a valid IP address') unless valid_ip? options[:type], value
      end

      def attribute_validate(*args)
        options = args.extract_options!
        options[:message] = :invalid
        type = options[:validate].options[:type]
        { 'parsley-ipaddress': type, 'parsley-ipaddress-message': parsley_error_message(options) }
      end

      private

      def valid_ip?(type, value)
        ip_regex = { ipv4: Resolv::IPv4::Regex, ipv6: Resolv::IPv6::Regex }
        ip_regex[:both] = Regexp.union ip_regex[:ipv4], ip_regex[:ipv6]
        case type
        when :ipv4, :ipv6
          return true if value =~ ip_regex[type]
        when :'ipv4+v6', :both, :ipv4v6, :all
          return true if value =~ ip_regex[:both]
        end
        false
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
