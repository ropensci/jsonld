context("frame")

# Read all test files
tests <- jsonlite::fromJSON(tf("frame-manifest.jsonld"), simplifyVector = FALSE)

# Test jsonld_compact
lapply(tests$sequence, function(x){
  test_that(paste(x[["@id"]], x$name), {
    expect <- tf(x$expect)
    out <- jsonld_frame(tf(x$input), tf(x$frame), options = list(
      base = "http://json-ld.org/test-suite/tests/"
    ))
    expect_true(json_equal(out, expect))
  })
})
