module ParsleySimpleForm
  module SimpleFormExtensions
    module FormHelper
      include SimpleForm::ActionViewExtensions::FormHelper

      # Custom helper to SimpleForm
      def parsley_simple_for(record, *args, &block)
        options = args.extract_options!

        case record
        when String, Symbol
          object = nil
        else
          object = record.is_a?(Array) ? record.last : record
        end
        # TODO: Investigate why novalidate="" and with normal simple_form_for it is novalidate="novalidate"
        parsley = { 'parsley-validate': true,
                    'parsley-error-class': 'has-feedback has-error',
                    'parsley-success-class': 'has-feedback has-success',
                    'parsley-errors-wrapper': '<span class="help-block">',
                    'parsley-error-template': '<div></div>',
                    'parsley-excluded': 'input[type=button], input[type=submit], input[type=reset],
                                         input[type=hidden], [disabled]' }
        parsley[:'parsley-trigger'] = object.respond_to?(:new_record?) && object.new_record? ? 'focusout' : 'change'
        html_options = { builder: ParsleySimpleForm::SimpleFormAdapt,
                         html: { data: parsley } }

        simple_form_for(record, *(args << html_options.deep_merge(options)), &block)
      end
    end
  end
end

ActionView::Base.send :include, ParsleySimpleForm::SimpleFormExtensions::FormHelper
