#!/usr/bin/env coffee
register = require 'cfx.require-plugin-coffee/register'
_require = require 'cfx.require'
{ gdf } = _require
register gdf _require

require './Makefile'
