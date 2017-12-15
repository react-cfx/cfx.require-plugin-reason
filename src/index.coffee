# import dd from 'ddeyes'
import compiler from './compiler'

export default (ops) ->

  caches = {}

  name: 'reasonml'
  exts: [
    '.re'
    '.ml'
  ]

  compiler: (code, id) ->

    unless caches["#{id}"]?

      fileObjs = await compiler id

      caches = {
        caches...
        fileObjs...
      }

    caches["#{id}"]
