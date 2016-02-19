module ParsleySimpleForm
  module SimpleFormExtensions
    module FormHelper
      include SimpleForm::ActionViewExtensions::FormHelper

      # Custom helper to SimpleForm
      def parsley_simple_for(object, *args, &block)
        options = args.extract_options!
        options[:builder] ||= ParsleySimpleForm::SimpleFormAdapt
        parsley = { 'parsley-validate': true,
                    'parsley-error-class': 'has-feedback has-error',
                    'parsley-success-class': 'has-feedback has-success',
                    'parsley-errors-wrapper': '<span class="help-block">',
                    'parsley-error-template': '<div></div>',
                    'parsley-trigger': 'focusout' }

        simple_form_for(object, *(args << options.merge(html: { data: parsley })), &block)
      end
    end
  end
end

ActionView::Base.send :include, ParsleySimpleForm::SimpleFormExtensions::FormHelper
