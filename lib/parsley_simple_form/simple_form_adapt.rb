# Provide a custom class of SimpleForm
module ParsleySimpleForm
  class SimpleFormAdapt < SimpleForm::FormBuilder
    include SimpleForm::Helpers::Validators

    attr_reader :attribute_name, :reflection

    # Add parsley attributes validation
    def input(attribute_name, options = {}, &block)
      @attribute_name = attribute_name
      @reflection = options[:reflection]
      options[:input_html] ||= {}
      options[:input_html][:data] ||= {}
      parsley_validations = validations_for(attribute_name)

      options[:input_html][:data].merge!(parsley_validations)
      super
    end

    private

    def valid_validator?(validator)
      case parsley_validator?(validator)
      when true, :on, :action_only
        action_validator_match?(validator)
      when false, :off
        false
      when :always
        true
      when :if_only
        conditional_validators?(validator)
      when :no_if
        !conditional_validators?(validator)
      else
        !conditional_validators?(validator) && action_validator_match?(validator)
      end
    end

    def parsley_validator?(validator)
      return true unless validator.options.include?(:parsley)
      validator.options[:parsley]
    end

    def validations_for(attribute_name)
      (attribute_validators + reflection_validators).each_with_object({}) do |v, attributes|
        if v.respond_to?(:attribute_validate) && valid_validator?(v)
          pass = { object: object, validate: v, attribute_name: attribute_name, lookup_action: lookup_action }
          attributes.merge! v.attribute_validate(pass)
        end
      end
    end
  end
end
