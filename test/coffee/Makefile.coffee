import dd from 'ddeyes'
import 'shelljs/make'

import path from 'path'
import compiler from '../../src/compiler'

target.all = ->
  dd 'Hello World!!!'

target.consoleLog = ->

  dd await compiler(
    path.join __dirname
    , '../reason/consoleLog/index.re'
  )

target.reason = ->

  dd await compiler(
    path.join __dirname
    , '../reason/sources/subFibs.re'
  )