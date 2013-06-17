express = require "express"
app = module.exports = express()

app.get "/", (request, response) ->
  res.send "So this structure works"
