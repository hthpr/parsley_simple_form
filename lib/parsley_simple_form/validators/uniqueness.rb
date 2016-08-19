module ParsleySimpleForm
  module Validators
    module Uniqueness
      def initialize(options)
        @parsley_name = 'remote'
        super
      end

      def attribute_validate(*args)
        options = args.extract_options!
        options[:message] = :taken
        regexp = /\Avalidate_#{options[:attribute_name]}\w*_?#{options[:object].model_name.plural}_path\z/
        validate_path = Rails.application.routes.url_helpers.methods.grep regexp
        if validate_path.length == 1
          primary_key = options[:object].class.primary_key
          path = Rails.application.routes.url_helpers.send validate_path.first, :"#{primary_key}" => options[:object].send(primary_key)
          { 'parsley-remote': path, 'parsley-remote-message': parsley_error_message(options) }
        else
          {}
        end
      end
    end
  end
end

module ActiveRecord
  module Validations
    class UniquenessValidator < ActiveModel::EachValidator
      include ParsleySimpleForm::Validators::Uniqueness
    end
  end
end
