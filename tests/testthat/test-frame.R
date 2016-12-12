context("frame")

# Read all test files
tests <- jsonlite::fromJSON(tf("frame-manifest.jsonld"), simplifyVector = FALSE)
report_line("## Failures for jsonld.frame\n")

# Test jsonld_compact
lapply(tests$sequence, function(x){
  test_that(paste(x[["@id"]], x$name), {
    expect <- tf(x$expect)
    if(is.null(x$option$base))
      x$option$base <- paste0(tests$baseIri, x$input)
    x$output <- jsonld_frame(tf(x$input), tf(x$frame), options = x$option)
    x$success <- json_equal(x$output, expect)
    expect_true(x$success)
    report_test(x)
  })
})
