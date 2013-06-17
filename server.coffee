# get this party started
module.exports = (app) ->
  express = require "express"
  conf = require "./conf"

  sockjs = require "sockjs"
  sockjs_conf = require "./lib/sockjs/config"
  sockjs_app = require "./lib/sockjs"

  server = require("http").createServer app

  sockjs_app.install sockjs_conf.server_opts, server

  return server
