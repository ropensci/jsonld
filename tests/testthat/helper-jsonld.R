# read a test file
tf <- function(name){
  x <- normalizePath(file.path("../test-suite", name), mustWork = TRUE)
  paste(readLines(x, warn = FALSE), collapse = "\n")
}

# test if two JSON objects are identical
json_equal <- local({
  ctx <- V8::v8()
  ctx$source("underscore-min.js")
  ctx$eval("function json_equal(x,y){return _.isEqual(JSON.parse(x), JSON.parse(y))}")
  function(a, b){
    ctx$call("json_equal", a, b)
  }
})
