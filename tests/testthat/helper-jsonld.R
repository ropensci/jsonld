# read a test file
tf <- function(name){
  if(is.null(name)) return(NULL)
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

con <- file("report.md", open = "w")

report_line <- function(str){
  writeLines(paste(str, collapse = "\n"), con = con)
}

report_test <- function(x){
  if(x$success) return()
  report_line(sprintf("\n### Test: `%s`\n", x$input))
  report_line("Expected:\n```json")
  report_line(jsonlite::prettify(tf(x$expect)))
  report_line("```\n")
  report_line("Found output:\n```json")
  report_line(jsonlite::prettify(x$output))
  report_line("```\n\n")
}

report_line("# R bindings for jsonld.js\n")
report_line(paste("Tests at:", Sys.time(), "\n"))

