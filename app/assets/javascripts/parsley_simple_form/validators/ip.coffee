# IPv4 validator
window.Parsley.addValidator 'IPv4',
  validateString: (value) ->
    ipv4 = /^(([0-9]|[1-9][0-9]|1[0-9]{2}|2[0-4][0-9]|25[0-5])\.){3}([0-9]|[1-9][0-9]|1[0-9]{2}|2[0-4][0-9]|25[0-5])$/

    if !ipv4.test(value)
      return false

    true
  requirementType: 'boolean',
  priority: 64
