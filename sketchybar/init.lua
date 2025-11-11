Bar = require("sketchybar")

Bar.begin_config()
Bar.hotload(true)
require("helpers")
require("color")
require("bar")
require("default")
require("items")
Bar.end_config()

Bar.event_loop()
