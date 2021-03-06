### Laserstingray.com ###
# single page application using [backbone.js](backbonejs.org), [expressjs](expressjs.com), [sockjs](sockjs.com), [bootstrap](http://twitter.github.io/bootstrap/)

# get this party started
express = require "express"
flash = require "connect-flash"
# get this party started

sockjs = require "sockjs"
sockjs_conf = require "./lib/sockjs/config"
sockjs_app = require "./lib/sockjs"

app = express()
server = require("http").createServer app

sockjs_app.install sockjs_conf.server_opts, server

# global connection sharing
_db = require "./models/db"

# native modules
fs = require "fs"
path = require "path"

conf = require "./conf"
passport = require "passport"
_passport = require "./lib/passport"

# routes, middleware, etc etc
home = require "./routes/home"
users = require "./routes/users"

#app.use on our routes.
app.use home
app.use users

_views = path.join __dirname, "views"

# default application configuration
app.configure () ->
  app.set "port", process.env.port || conf.app.port
  # app.set "views", _views
  # app.set "view engine", "mmm"
  # app.set "layout", "layout"
  app.use express.logger "dev"
  app.use express.compress()
  if process.env.NODE_ENV == "development"
    app.set "port", conf.app.port
    app.use express.errorHandler
      dumpExceptions: true
      showStack: true
  app.use express.favicon()
  # app.use express.bodyParser 
  #   keepExtensions: true
  # app.use express.methodOverride()
  # app.use express.cookieParser()
  # app.use express.cookieSession
  #   key: conf.cookie.key
  #   secret: conf.cookie.secret
  #   cookie: maxAge: conf.cookie.maxAge
  # app.use passport.initialize()
  # app.use passport.session()
  # app.use flash()
  app.use app.router
  app.use express.static path.join __dirname, "public"
  app.use express.errorHandler()
  # app.use (req, res) ->
  #   res.status 404
  #   res.render "pages/404", 
  #     title: "404: File Not Found"
  # app.use (err, req, res, next) ->
  #   res.status 500
  #   res.render "pages/404", 
  #     title: "500: Internal Server Error"
  #     err: err

# go!
server.listen conf.app.port, () ->
  col = conf.colors()
  console.log "#{col.cyan}::#{col.reset} starting engine #{col.cyan}::#{col.reset} #{conf.app.welcome} #{col.cyan}::#{col.reset} "

process.on "SIGINT", () ->
  db.close()
  server.close()
  process.exit()
