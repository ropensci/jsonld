context("from_rdf")

# Read all test files
tests <- jsonlite::fromJSON(tf("fromRdf-manifest.jsonld"), simplifyVector = FALSE)
report_line("## Failures for jsonld.fromRdf\n")

# Test jsonld_compact
lapply(tests$sequence, function(x){
  test_that(paste(x[["@id"]], x$name), {
    expect <- tf(x$expect)
    if(is.null(x$option$base))
      x$option$base <- paste0(tests$baseIri, x$input)
    out <- jsonld_from_rdf(tf(x$input), options = x$option)
    expect_true(json_equal(out, expect))
  })
})
