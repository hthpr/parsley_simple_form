# Make equalto validator work correctly for a confirmation field
window.Parsley.addValidator 'confirm',
  validateString: (value, refOrValue) ->
    $reference = $(refOrValue)
    $original = $(refOrValue.replace(/_confirmation$/, ''))

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
        .parsley()
        .reset()
      $reference.siblings('.glyphicon').remove()

    true
  priority: 200
