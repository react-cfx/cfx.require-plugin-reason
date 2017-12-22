import dd from 'ddeyes'
import 'shelljs/make'
import path from 'path'

import getRequire, { gdf } from 'cfx.require'
import Es6ToEs5 from 'cfx.babel'

# import reason from '../../src'
import reason from '../..'

target.all = ->
  dd 'Hello Reason!!!'

target.reason = ->

  RML = getRequire [
    reason
      nodeModulesPath: path.join __dirname, '../../node_modules'
  ]

  { sub }  = await RML.requireAsync './consoleLog/index.re'
  dd sub 2, 1
