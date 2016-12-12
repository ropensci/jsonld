#' Working with JSON-LD
#'
#' Wrappers for converting, expanding and compacting JSON-LD documents. All parameters
#' and return values must be JSON strings. Use [jsonlite::toJSON] and [jsonlite::fromJSON]
#' to convert between R objects and JSON format. The [readme](https://github.com/ropensci/jsonld#readme)
#' has basic examples.
#'
#' @export
#' @rdname jsonld
#' @name jsonld
#' @param doc a URL or literal string with JSON-LD document
#' @param context a URL or literal string with JSON-LD context
#' @param options named list with advanced options
#' @examples # Example from https://github.com/digitalbazaar/jsonld.js#quick-examples
#' doc <- '{
#'   "http://schema.org/name": "Manu Sporny",
#'   "http://schema.org/url": {"@id": "http://manu.sporny.org/"},
#'   "http://schema.org/image": {"@id": "http://manu.sporny.org/images/manu.png"}
#' }'
#'
#' context <- '{
#'   "name": "http://schema.org/name",
#'   "homepage": {"@id": "http://schema.org/url", "@type": "@id"},
#'   "image": {"@id": "http://schema.org/image", "@type": "@id"}
#' }'
#'
#' # Compact and expand:
#' (out <- jsonld_compact(doc, context))
#' (expanded <- jsonld_expand(out))
#'
#' # Convert between JSON and RDF:
#' cat(nquads <- jsonld_to_rdf(doc))
#' jsonld_from_rdf(nquads)
#'
#' # Other utilities:
#' jsonld_flatten(doc)
#' cat(jsonld_normalize(doc))
jsonld_compact <- function(doc, context, options = NULL){
  doc <- validate_arg(doc)
  context <- validate_arg(context)
  options <- V8::JS(jsonlite::toJSON(options, auto_unbox = TRUE))
  structure(ctx$call("r_compact", doc, context, options), class = "json")
}

#' @export
#' @rdname jsonld
#' @param compacted a URL or literal string with JSON message
jsonld_expand <- function(compacted, options = NULL){
  compacted <- validate_arg(compacted)
  options <- V8::JS(jsonlite::toJSON(options, auto_unbox = TRUE))
  structure(ctx$call("r_expand", compacted, options), class = "json")
}

#' @export
#' @rdname jsonld
jsonld_flatten <- function(doc, context = NULL, options = NULL){
  if(is.null(context))
    context <- "null"
  doc <- validate_arg(doc)
  context <- validate_arg(context)
  options <- V8::JS(jsonlite::toJSON(options, auto_unbox = TRUE))
  structure(ctx$call("r_flatten", doc, context, options), class = "json")
}

#' @export
#' @rdname jsonld
#' @param frame a URL or literal string with JSON-LD frame
jsonld_frame <- function(doc, frame, options = NULL){
  doc <- validate_arg(doc)
  frame <- validate_arg(frame)
  options <- V8::JS(jsonlite::toJSON(options, auto_unbox = TRUE))
  structure(ctx$call("r_frame", doc, frame, options), class = "json")
}

#' @export
#' @rdname jsonld
#' @param rdf string with RDF text
jsonld_from_rdf <- function(rdf, options = list(format = 'application/nquads')){
  stopifnot(is.character(rdf))
  options <- V8::JS(jsonlite::toJSON(options, auto_unbox = TRUE))
  structure(ctx$call("r_from_rdf", rdf, options), class = "json")
}

#' @export
#' @rdname jsonld
jsonld_to_rdf <- function(doc, options = list(format = 'application/nquads')){
  doc <- validate_arg(doc)
  options <- V8::JS(jsonlite::toJSON(options, auto_unbox = TRUE))
  ctx$call("r_to_rdf", doc, options)
}

#' @export
#' @rdname jsonld
jsonld_normalize <- function(doc, options = list(algorithm = 'URDNA2015', format = 'application/nquads')){
  doc <- validate_arg(doc)
  options <- V8::JS(jsonlite::toJSON(options, auto_unbox = TRUE))
  ctx$call("r_normalize", doc, options)
}

# Check if argument is a JSON string or URL
validate_arg <- function(x){
  if(is.character(x) && length(x) == 1){
    if(jsonlite::validate(x))
      return(V8::JS(x))
    if(grepl("^https?://", x))
      return(x)
  }
  stop("Argument is not a valid URL or JSON string")
}
