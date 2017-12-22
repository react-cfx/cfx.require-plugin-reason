import dd from 'ddeyes'
import compiler from './compiler'
import babel from 'cfx.babel'

import path from 'path'

export default (ops) ->

  { nodeModulesPath } = ops

  caches = {}

  name: 'reasonml'
  exts: [
    '.re'
    '.ml'
  ]

  compiler: (code, id) ->

    idObj =
      dirname: path.dirname id
      basename: path.basename id
      extname: path.extname id 

    _id = path.join idObj.dirname
    ,
      idObj.basename.replace(
        new RegExp idObj.extname, 'g'
        '.js'
      )

    unless caches["#{_id}"]?

      fileObjs = await compiler id, {
        nodeModulesPath
      }

      caches = {
        caches...
        fileObjs...
      }

    caches["#{_id}"]
