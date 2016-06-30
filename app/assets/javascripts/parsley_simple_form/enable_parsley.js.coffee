$(document).on "turbolinks:load", ->
  if $('[data-parsley-validate]').length
    $('[data-parsley-validate]').parsley()
  return
