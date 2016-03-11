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

    def validations_for(attribute_name)
      (attribute_validators + reflection_validators).each_with_object({}) do |v, attributes|
        # TODO: check if it is a valid_validator? (currently fails for if certain criterias)
        # if valid_validator?(v)
        #  puts "VALID: #{attribute_name}"
        # end

        if v.respond_to?(:attribute_validate)
          pass = { object: object, validate: v, attribute_name: attribute_name, lookup_action: lookup_action }
          attributes.merge! v.attribute_validate(pass)
        end
      end
    end
  end
end
