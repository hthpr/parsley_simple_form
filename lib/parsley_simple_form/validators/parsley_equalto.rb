# frozen_string_literal: true
require 'active_model'
require 'active_model/validator'

module ParsleyEqualto
  class Validator < ActiveModel::EachValidator
    def validate_each(record, attribute, value)
    end

    def attribute_validate(*args)
      options = args.extract_options!
      options[:message] = :confirmation
      { 'parsley-equalto': "##{options[:object].model_name.singular}_#{options[:attribute_name].to_s.chomp '_confirmation'}",
        'parsley-equalto-message': parsley_error_message(options),
        'parsley-trigger': 'change focusout' }
    end
  end
end

ActiveModel::Validations::ParsleyEqualtoValidator = ParsleyEqualto::Validator
