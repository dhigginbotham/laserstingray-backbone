# get this party started
express = require "express"

sockjs = require "sockjs"
sockjs_conf = require "./lib/sockjs/config"
sockjs_app = require "./lib/sockjs"

app = module.exports = express()
server = require("http").createServer app

sockjs_app.install sockjs_conf.server_opts, server

exports.server = server
