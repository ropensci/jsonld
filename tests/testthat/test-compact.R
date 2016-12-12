context("compact")

# Read all test files
tests <- jsonlite::fromJSON(tf("compact-manifest.jsonld"), simplifyVector = FALSE)
report_line("## Failures for jsonld.compact\n")

# Test jsonld_compact
lapply(tests$sequence, function(x){
  test_that(paste(x[["@id"]], x$name), {
    expect <- tf(x$expect)
    if(is.null(x$option$base))
      x$option$base <- paste0(tests$baseIri, x$input)
    x$output <- jsonld_compact(tf(x$input), tf(x$context), options = x$option)
    x$success <- json_equal(x$output, expect)
    expect_true(x$success)
    report_test(x)
  })
})
