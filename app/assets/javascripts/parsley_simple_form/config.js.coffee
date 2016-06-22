window.ParsleyConfig =
  #errorClass: 'has-feedback has-error'
  #successClass: 'has-feedback has-success'
  classHandler: (ParsleyField) ->
    ParsleyField.$element.parents '.float-form-group'
  errorsContainer: (ParsleyField) ->
    ParsleyField.$element.parents '.float-form-group'
  #errorsWrapper: '<span class="help-block">'
  #errorTemplate: '<div></div>'
return
