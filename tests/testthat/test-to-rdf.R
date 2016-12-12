context("to_rdf")

# Read all test files
tests <- jsonlite::fromJSON(tf("toRdf-manifest.jsonld"), simplifyVector = FALSE)
report_line("## Failures for jsonld.toRdf\n")

# Test jsonld_compact
lapply(tests$sequence, function(x){
  test_that(paste(x[["@id"]], x$name), {
    tryCatch({
      expect <- tf(x$expect)
      x$option$format = "application/nquads"
      if(is.null(x$option$base))
        x$option$base <- paste0(tests$baseIri, x$input)
      out <- jsonld_to_rdf(tf(x$input), options = x$option)
      expect_equal(trimws(out), trimws(expect))
    }, error = function(e){
      report_line(sprintf("\n### Test: `%s`\n", x$input))
      report_line(paste("**RUNTIME ERROR!!**: ", e$message, "\n"))
      stop(e$message)
    })
  })
})
