// Load this after Parsley for additional comparison validators
// equal_to, other_than, even, odd, extra validators

// Equal to validator
window.Parsley.addValidator('eq', {
  validateString: function (value, requirement) {
    return parseFloat(value) == parseRequirement(requirement);
  },
  priority: 32
});

// Other than validator
window.Parsley.addValidator('ot', {
  validateString: function (value, requirement) {
    return parseFloat(value) != parseRequirement(requirement);
  },
  priority: 32
});

// Even numbers validator
window.Parsley.addValidator('even', {
  validateString: function(value) {
    return (value % 2) ? false: true;
  },
  priority: 16
});

// Odd numbers validator
window.Parsley.addValidator('odd', {
  validateString: function(value) {
    return (value % 2) ? true: false;
  },
  priority: 16
});
