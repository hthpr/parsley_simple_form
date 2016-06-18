module ParsleySimpleForm
  module Validators
    module Confirmation
      def attribute_validate(*args)
        options = args.extract_options!
        options[:message] = :confirmation
        { 'parsley-confirm': "##{options[:object].model_name.singular}_#{options[:attribute_name]}_confirmation",
          'parsley-confirm-message': parsley_error_message(options) }
      end
    end
  end
end

module ActiveRecord
  module Validations
    class ConfirmationValidator < ActiveModel::EachValidator
      include ParsleySimpleForm::Validators::Confirmation
    end
  end
end
