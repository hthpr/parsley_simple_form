# Automatically add equalto validator for a confirmation field
window.Parsley.addValidator 'confirm',
  validateString: (value, refOrValue) ->
    $reference = $(refOrValue)
    $original = $(refOrValue.replace(/_confirmation$/, ''))
    if $reference.length and !$reference.attr('data-parsley-equalto')
      $reference.attr 'data-parsley-equalto', refOrValue.replace(/_confirmation$/, '')
        .attr 'data-parsley-equalto-message', $original.attr('data-parsley-confirm-message')
        .attr 'data-parsley-trigger', 'change focusout'
        .parsley().validate()

    if $reference.val().length > 0
      $reference.parsley().validate()
    if value.length > 0
      $reference.attr 'data-parsley-validate-if-empty', 'true'
      $original.attr 'data-parsley-validate-if-empty', 'true'
    else
      $original.attr 'data-parsley-reset', 'true'
        .removeAttr 'data-parsley-validate-if-empty'

      $reference.removeAttr 'data-parsley-validate-if-empty'
        .val ''
        .parsley().reset()
        .siblings('.glyphicon').remove()
    true
  priority: 200
