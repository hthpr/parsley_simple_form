module ParsleySimpleForm
  module Validators
    module ClassMethods
      protected

        def _validates_default_keys
          super << :parsley
        end
    end
  end
end

module ActiveModel
  module Validations
    module ClassMethods
      prepend ParsleySimpleForm::Validators::ClassMethods
    end
  end
end
