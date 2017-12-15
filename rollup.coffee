import {
  coffee2
  coffeepath
} from 'cfx.rollup-plugin-coffee2'
import cleanup from 'rollup-plugin-cleanup'

plugins = [
  coffee2
    bare: true
    sourceMap: true
  coffeepath()
  cleanup()
]

index = {
  input: './rollup/index.js'
  output:
    file: './index.js'
    format: 'cjs'
  plugins
}
  
register = {
  input: './rollup/register.js'
  output:
    file: './register.js'
    format: 'cjs'
  plugins
}

export default [
  index
  register
]
