import dd from 'ddeyes'
import 'shelljs/make'

import path from 'path'
import compiler from '../../src/compiler'

_compiler = (args...) ->
  await compiler.apply @, args

target.all = ->
  dd 'Hello World!!!'

# yarn test_one
target.consoleLog = ->

  dd await _compiler(
    path.join __dirname
    , '../reason/consoleLog/index.re'
  )
  
# yarn test_reason
target.reason = ->

  dd await _compiler(
    path.join __dirname
    , '../reason/sources/subFibs.re'
  )
