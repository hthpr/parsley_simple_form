module ParsleySimpleForm
  module Validators
    module Confirmation
      def initialize(options)
        super
        setup_equalto(options[:class])
      end

      def attribute_validate(*args)
        options = args.extract_options!
        options[:message] = :confirmation
        { 'parsley-confirm': "##{options[:object].model_name.singular}_#{options[:attribute_name]}_confirmation" }
      end

      private

      def setup_equalto(klass)
        attributes.map do |attribute|
          attribute_name = :"#{attribute}_confirmation"
          equalto_options = { attributes: [attribute_name], class: klass }
          validator = ActiveModel::Validations::ParsleyEqualtoValidator.new(equalto_options)
          klass._validators[attribute_name] << validator
        end.compact
      end
    end
  end
end

module ActiveModel
  module Validations
    class ConfirmationValidator < EachValidator
      include ParsleySimpleForm::Validators::Confirmation
    end
  end
end
