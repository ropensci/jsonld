context("error")

# Read all test files
tests <- jsonlite::fromJSON(tf("error-manifest.jsonld"), simplifyVector = FALSE)
report_line("## Failures for error messages\n")

# Test jsonld_compact
lapply(tests$sequence, function(x){
  test_that(paste(x[["@id"]], x$name), {
    if(is.null(x$option$base))
      x$option$base <- paste0(tests$baseIri, x$input)
    expect_error(jsonld_expand(tf(x$input), options = x$option))
    tryCatch({
      jsonld_expand(tf(x$input), options = x$option)
      report_line(sprintf("\n### Test: `%s`\n", x$input))
      report_line("Failed to raise error!\n")
    }, error = function(e){})
  })
})

