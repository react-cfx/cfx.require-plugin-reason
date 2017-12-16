import dd from 'ddeyes'
import 'shelljs/make'

import path from 'path'
import compiler from '../../src/compiler'
# compiler = require '../../src/compiler'

_compiler = (args...) ->
  await compiler.default.apply @, args

target.all = ->
  dd 'Hello World!!!'

target.consoleLog = ->

  dd await _compiler(
    path.join __dirname
    , '../reason/consoleLog/index.re'
  )
  
target.reason = ->

  dd await _compiler(
    path.join __dirname
    , '../reason/sources/subFibs.re'
  )
