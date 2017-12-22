import dd from 'ddeyes'

import path from 'path'
import fs from 'fs'

import tmp from 'tmp'
import rimraf from 'rimraf'
import mkdirp from 'mkdirp'
import find from 'find'

import { compileFile } from 'bsb-js'
import babel from 'cfx.babel'

tmpFactory = (cb) ->

  tmpObj = tmp.dirSync()
  tmpDir = tmpObj.name

  result = await cb tmpDir

  # dd tmpDir

  rimraf.sync "#{tmpDir}/*"
  rimraf.sync "#{tmpDir}/.*"

  tmpObj.removeCallback()

  result

prepareBuilderDir = ({
  builderPath
  nodeModulesPath
}) ->

  # src dir
  mkdirp.sync "#{builderPath}/src"

  # bsconfig.json
  fs.writeFileSync(
    "#{builderPath}/bsconfig.json"
    JSON.stringify
      name: 'basic'
      sources: [ 'src' ]
      'package-specs': [ 'es6' ]
      'bsc-flags': [ '-bs-super-errors' ]
      refmt: 3
    , null, 2
    'utf-8'
  )

  # link node_modules
  fs.symlinkSync(
    nodeModulesPath
    "#{builderPath}/node_modules"
  )

copySources = ({
  dirname
  builderPath
}) ->
  # move sources
  findFiles = find.fileSync /\.(re|rei|ml|mli)$/
  , dirname

  # dd findFiles

  findFiles.map (findFile) ->

    fileName = path.join "#{builderPath}/src/"
    ,
      findFile.replace(
        new RegExp dirname
        , 'g'
        ''
      )

    fs.copyFileSync findFile, fileName

builder = ({
  builderPath
  basename
  extname
}) ->

  compiledFilePath = path.join builderPath
  , '/lib/es6/src/'
  ,
    basename.replace(
      new RegExp extname
      , 'g'
      '.js'
    )

  try
    result = await compileFile(
      # buildDir
      builderPath
      # moduleDir
      'es6'
      # compiledFilePath
      compiledFilePath
    )
  catch e
    console.error e

  result

checkCacheDir = ({
  dirname
  builderPath
}) ->

  findFiles = find.fileSync /\.js/
  , "#{builderPath}/lib/es6/src"

  findFiles.reduce (r, fileName) ->
    k = path.join dirname
    ,
      fileName.replace(
        new RegExp "#{builderPath}/lib/es6/src"
        , 'g'
        ''
      )
    v = fs.readFileSync fileName, 'utf-8'
    {
      r...
      "#{k}":
        babel v
        ,
          presets:
            env:
              targets:
                node: 'current'
          runtime: true
    }
  , {}

export default (
  id
  { nodeModulesPath }
) ->

  file =
    dirname: path.dirname id
    basename: path.basename id
    extname: path.extname id

  await tmpFactory (tmpDir) ->

    prepareBuilderDir {
      builderPath: tmpDir
      nodeModulesPath
    }

    copySources
      dirname: file.dirname
      builderPath: tmpDir

    codeObj = await builder
      builderPath: tmpDir
      basename: file.basename
      extname: file.extname

    # console.log codeObj.src

    # unless codeObj.src is ''
    checkCacheDir
      dirname: file.dirname
      builderPath: tmpDir
