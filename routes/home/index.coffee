express = require "express"
app = module.exports = express()

app.get "/", (request, response) ->
  response.send "So this structure works"
