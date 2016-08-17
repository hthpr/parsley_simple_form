# Dynamically add validators to another field based on the value entered
# Very useful for select fields
# data-parsley-selectif="#field" field to add validators
# data-parsley-selectif-validators="json object" it should be in format:
# {"value":{"validator": "name of validator","setting": "setting for validator",
# "message": "optional error message to use"}}
window.Parsley.addValidator 'selectif',
  requirementType:
    '': 'string'
    'validators': 'object'
    'previous': 'string'
  validateString: (value, inputfield, settings, parsleyInstance) ->
    $validators = settings.validators
    $input = $(inputfield)
    $select_input = parsleyInstance.$element
    $parsley = 'data-parsley-'

    if settings.previous?
      $input.removeAttr "#{$parsley}#{settings.previous}"
      $input.removeAttr "#{$parsley}#{settings.previous}-message"

    if $validators[value]?
      $object = $validators[value]
      $select_input.attr "#{$parsley}selectif-previous", $object.validator
      $input.attr "#{$parsley}#{$object.validator}", $object.setting

      if $object.message?
        $input.attr "#{$parsley}#{$object.validator}-message", $object.message

    if $input.val().length > 0
      $input.parsley().validate()

    true
  priority: 100
