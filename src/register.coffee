reason = require './'

module.exports = (
  _require
) ->

  { register } = _require [
    reason()
  ]

  register()
