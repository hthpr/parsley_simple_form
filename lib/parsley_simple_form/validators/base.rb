module ParsleySimpleForm
  module Validators
    module Base
      attr_reader :parsley_name

      def psm_setting
        ('parsley-' + parsley_name).to_sym
      end

      def psm_message
        ('parsley-' + parsley_name + '-message').to_sym
      end

      def select_validator(*args)
        parsley = attribute_validate(*args)
        { options[:selectkey] => { validator: parsley_name, setting: parsley[psm_setting], message: parsley[psm_message] } }
      end

      def parsley_error_message(*args)
        options = args.extract_options!
        object = options[:object]
        simple_form_errors(object, options) || object.errors.generate_message(options[:attribute_name], options[:validate].kind, options)
      end

      protected

      def simple_form_errors(object, options, default = '')
        lookup_action = options[:lookup_action]
        attribute_name = options[:attribute_name]
        type = options[:message].is_a?(Symbol) ? options[:message] : options[:validate].kind

        if object.class.respond_to?(:i18n_scope)
          defaults = object.class.lookup_ancestors.map do |klass|
            [:"#{klass.model_name.i18n_key}.#{lookup_action}.#{attribute_name}.#{type}",
             :"#{klass.model_name.i18n_key}.#{lookup_action}.#{type}",
             :"#{klass.model_name.i18n_key}.#{attribute_name}.#{type}",
             :"#{klass.model_name.i18n_key}.#{type}"]
          end
        else
          defaults = []
        end
        defaults << :"defaults.#{lookup_action}.#{attribute_name}.#{type}"
        defaults << :"defaults.#{lookup_action}.#{type}"
        defaults << :"defaults.#{attribute_name}.#{type}"
        defaults << :"defaults.#{type}"
        defaults << default

        defaults.compact!
        defaults.flatten!

        key = defaults.shift
        value = (attribute_name != :base ? object.send(:read_attribute_for_validation, attribute_name) : nil)

        options = {
          scope: :"#{SimpleForm.i18n_scope}.errors",
          default: defaults,
          model: object.model_name.human,
          attribute: object.class.human_attribute_name(attribute_name),
          value: value
        }.merge!(options)
        I18n.t(key, options).presence
      end
    end
  end
end

module ActiveModel
  class EachValidator < Validator
    include ParsleySimpleForm::Validators::Base
  end
end
