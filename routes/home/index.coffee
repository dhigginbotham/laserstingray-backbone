express = require "express"
app = module.exports = express()

app.get "/", (request, response) ->
  response.send "So this structure works"

app.get "/test", (request, response) ->
  response.send "So test"
