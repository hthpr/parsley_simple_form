// Load this after Parsley for additional validators

// inverse pattern validator
window.Parsley.addValidator('inversepattern', {
  validateString: function(value, regexp) {
    return !regexp.test(value);
  },
  requirementType: 'regexp',
  priority: 64
});
