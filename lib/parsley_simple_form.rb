require 'simple_form'
require 'action_view'
require 'active_model'

require 'parsley_simple_form/version'
require 'parsley_simple_form/simple_form_extensions/form_helper'
require 'parsley_simple_form/validators'

module ParsleySimpleForm
  extend ActiveSupport::Autoload

  eager_autoload do
    autoload :SimpleFormAdapt
  end

  def self.eager_load!
    super
  end

  # Configuration to add more boolean attributes
  mattr_accessor :parsley_attributes
  @@parsley_attributes = [
    'parsley-validate',
    'parsley-required'
  ]

  ActionView::Helpers::TagHelper::BOOLEAN_ATTRIBUTES << Set.new(@@parsley_attributes)
  ActionView::Helpers::TagHelper::BOOLEAN_ATTRIBUTES.flatten!
end

if defined?(Rails)
  require 'parsley_simple_form/engine'
  require 'parsley_simple_form/railtie'
end
