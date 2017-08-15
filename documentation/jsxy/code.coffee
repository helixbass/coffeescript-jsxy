fs           = require 'fs'
CoffeeScript = require '../../lib/coffeescript'

# https://stackoverflow.com/questions/6234773/can-i-escape-html-special-chars-in-javascript
escapeHtml = (unsafe) ->
  unsafe
  .replace /&/g, "&amp;"
  .replace /</g, "&lt;"
  .replace />/g, "&gt;"
  .replace /"/g, "&quot;"
  .replace /'/g, "&#039;"

module.exports = ->
  counter = 0
  # hljs = require 'highlight.js'
  # hljs.configure classPrefix: ''
  (file, executable = no, showLoad = yes) ->
    counter++
    cs = fs.readFileSync "documentation/examples/#{file}.coffee", 'utf-8'
    js = CoffeeScript.compile cs, bare: yes
    js = js.replace /^\/\/ generated.*?\n/i, ''

    # cshtml = "<pre><code>#{hljs.highlight('coffeescript', cs).value}</code></pre>"
    # jshtml = "<pre><code>#{hljs.highlight('javascript', js).value}</code></pre>"
    cshtml = "<pre><code>#{escapeHtml cs}</code></pre>"
    jshtml = "<pre><code>#{escapeHtml js}</code></pre>"
    # append = if executable is yes then '' else "alert(#{executable});".replace /"/g, '&quot;'
    # if executable and executable isnt yes
    #   cs.replace /(\S)\s*\Z/m, "$1\n\nalert #{executable}"
    # run    = if executable is yes then 'run' else "run: #{executable}"
    # name   = "example#{counter}"
    # script = "<script>window.#{name} = #{JSON.stringify cs}</script>"
    # load   = if showLoad then "<div class='minibutton load' onclick='javascript: loadConsole(#{name});'>load</div>" else ''
    # button = if executable then """<div class="minibutton ok" onclick="javascript: #{js.replace /"/g, '&quot;'};#{append}">#{run}</div>""" else ''
    "<div class='code'>#{cshtml}#{jshtml}<br class='clear' /></div>"
