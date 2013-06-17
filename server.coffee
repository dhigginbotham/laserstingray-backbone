# get this party started
express = require "express"
conf = require "./conf"

sockjs = require "sockjs"
sockjs_conf = require "./lib/sockjs/config"
sockjs_app = require "./lib/sockjs"

app = express()
server = require("http").createServer app

sockjs_app.install sockjs_conf.server_opts, server

# go!
server.listen app.get("port"), () ->
  col = conf.colors()
  console.log "#{col.cyan}::#{col.reset} starting engine #{col.cyan}::#{col.reset} #{conf.app.welcome} #{col.cyan}::#{col.reset} "

process.on "SIGINT", () ->
  db.close()
  server.close()
  process.exit()

exports = module.exports = app