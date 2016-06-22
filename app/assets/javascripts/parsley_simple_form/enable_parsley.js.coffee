$(document).on "page:change", ->
  if $('[data-parsley-validate]').length
    $('[data-parsley-validate]').parsley()
  return
