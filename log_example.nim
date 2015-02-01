import logging

var L = newConsoleLogger(fmtStr = verboseFmtStr)
var fL = newFileLogger("test.log", levelThreshold = lvlError, fmtStr = verboseFmtStr)
var rL = newRollingFileLogger("rolling.log", fmtStr = verboseFmtStr)
handlers.add(L)
handlers.add(fL)
handlers.add(rL)
info("This is an info log")
warn("Oh Oh!")
error("Big Oh Oh!")
fatal("The bigest Oh Oh possible!")