express = require "express"
app = module.exports = express()
flash = require "connect-flash"

fs = require "fs"
path = require "path"

middle = require "./middleware"
routes = require "./routes"

pass = require "../../lib/passport"
passport = require "passport"

scripts = require "../../lib/assets"
nav = require "../../lib/menus"
conf = require "../../conf"

_views = path.join __dirname, "..", "..", "views"

app.configure () ->
  app.set "views", _views
  app.set "view engine", "mmm"
  app.set "layout", "layout"
#   app.use express.logger "dev"
#   app.use express.compress()
#   if process.env.NODE_ENV == "development"
#     app.set "port", conf.app.port
#     app.use express.errorHandler
#       dumpExceptions: true
#       showStack: true
#   app.use express.favicon()
  app.use express.bodyParser 
    keepExtensions: true
  app.use express.methodOverride()
  app.use express.cookieParser()
  app.use express.cookieSession
    key: conf.cookie.key
    secret: conf.cookie.secret
    cookie: maxAge: conf.cookie.maxAge
  app.use passport.initialize()
  app.use passport.session()
  app.use flash()
  # app.use app.router
#   app.use express.static path.join __dirname, "public"
#   app.use express.errorHandler()
#   app.use (req, res) ->
#     res.status 404
#     res.render "pages/404", 
#       title: "404: File Not Found"
#   app.use (err, req, res, next) ->
#     res.status 500
#     res.render "pages/404", 
#       title: "500: Internal Server Error"
#       err: err

# auth routes
app.get "/login", nav.render, scripts.embed, routes.get.login
app.post "/login", passport.authenticate("local", failureRedirect: "/", failureFlash: true), 
  (req, res) -> 
    res.redirect "/"

app.get "/logout", nav.render, scripts.embed, routes.get.logout
