// Load this after Parsley for additional validators

// exclusion validator
window.Parsley.addValidator('exlist', {
  validateString: function(value, requirement) {
    var delimiter = ',';
    var listItems = (requirement + "").split(new RegExp("\\s*\\" + delimiter + "\\s*"));
    return ($.inArray($.trim(value), listItems) == -1);
  },
  priority: 32
});
