# This global callback will be called for any field that fails validation.
window.Parsley.on 'field:error', (e) ->
  @$element.siblings(".glyphicon").remove()

  if @$element.attr('data-parsley-reset')
    @$element.removeAttr('data-parsley-reset')
    .parsley().reset()
  else if @$element.parents('.float-form-group').hasClass('has-feedback')
    @$element.next("label").after '<span class="glyphicon glyphicon-remove form-control-feedback"></span>'
  return
