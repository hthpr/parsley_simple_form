# This global callback will be called for any field that suceeeds validation.
window.Parsley.on 'field:success', (ParsleyField) ->
  @$element.siblings(".glyphicon").remove()
  @$element.parents('.float-form-group').find(".help-block").remove()
  if ParsleyField.constraints.length && @$element.parents('.float-form-group').hasClass('has-feedback')
    @$element.next("label").after '<span class="glyphicon glyphicon-ok form-control-feedback"></span>'
  return
