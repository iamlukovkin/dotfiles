Bar = require("sketchybar")

Bar.begin_config()

Bar.hotload(true)

require("fonts")
require("colorschema")
require("plugins")
require("icons")
require("bar")
require("default")
require("items")
Bar.end_config()

Bar.event_loop()
