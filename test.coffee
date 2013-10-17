
fs = require "fs"
PEG = require "pegjs"
PEGjsCoffeePlugin = require 'pegjs-coffee-plugin'
PEGjsCoffeePlugin.addTo PEG

source_file = "./code.cr"
peg_file = "./cirru.pegcoffee"

mainTest = ->
  fs.readFile peg_file, "utf8", (err, rules) ->
    try
      parser = PEG.buildParser rules
      fs.readFile source_file, "utf8", (err, code) ->
        try
          result = parser.parse code
          console.log "==============================="
          console.log JSON.stringify result, null, 2
        catch generator_err
          console.log "parser failed", generator_err
    catch parser_faild
      console.log "generator failed", parser_faild

fs.watchFile source_file, interval: 200, mainTest
fs.watchFile peg_file, interval: 200, mainTest
do mainTest