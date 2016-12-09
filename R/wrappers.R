#' Working with JSON-LD
#'
#' Wrappers for converting, expanding and compating JSON-LD documents. All parameters
#' and return values must be JSON strings. Use [jsonlite::toJSON] and [jsonlite::fromJSON]
#' to convert between R objects and JSON format. The [readme](https://github.com/ropensci/jsonld#readme)
#' has basic examples.
#'
#' @export
#' @rdname jsonld
#' @name jsonld
#' @param doc string with JSON-LD document
#' @param context string with JSON-LD context
#' @examples doc <- '{
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
#' (out <- jsonld::compact(doc, context))
#' (expanded <- jsonld::expand(out))
#'
#' # Convert between JSON and RDF:
#' cat(nquads <- jsonld::to_rdf(doc))
#' jsonld::from_rdf(nquads)
#'
#' # Other utilities:
#' jsonld::flatten(doc)
#' cat(jsonld::normalize(doc))
compact <- function(doc, context){
  if(!jsonlite::validate(doc))
    stop("Argument 'doc' is not a valid JSON string")
  if(!jsonlite::validate(context))
    stop("Argument 'context' is not a valid JSON string")
  structure(ctx$call("r_compact", V8::JS(doc), V8::JS(context)), class = "json")
}

#' @export
#' @rdname jsonld
#' @param compacted string with JSON message
expand <- function(compacted){
  if(!jsonlite::validate(compacted))
    stop("Argument 'compacted' is not a valid JSON string")
  structure(ctx$call("r_expand", V8::JS(compacted)), class = "json")
}

#' @export
#' @rdname jsonld
flatten <- function(doc){
  if(!jsonlite::validate(doc))
    stop("Argument 'doc' is not a valid JSON string")
  structure(ctx$call("r_flatten", V8::JS(doc)), class = "json")
}

#' @export
#' @rdname jsonld
frame <- function(doc){
  if(!jsonlite::validate(doc))
    stop("Argument 'doc' is not a valid JSON string")
  structure(ctx$call("r_frame", V8::JS(doc)), class = "json")
}

#' @export
#' @rdname jsonld
#' @param rdf string with RDF text
from_rdf <- function(rdf, format = 'application/nquads'){
  stopifnot(is.character(rdf))
  structure(ctx$call("r_from_rdf", rdf, format), class = "json")
}

#' @export
#' @rdname jsonld
to_rdf <- function(doc, format = 'application/nquads'){
  if(!jsonlite::validate(doc))
    stop("Argument 'doc' is not a valid JSON string")
  ctx$call("r_to_rdf", V8::JS(doc), format)
}

#' @export
#' @rdname jsonld
#' @param algorithm normalization algorithm
#' @param format a MIME type
normalize <- function(doc, algorithm = 'URDNA2015', format = 'application/nquads'){
  if(!jsonlite::validate(doc))
    stop("Argument 'doc' is not a valid JSON string")
  ctx$call("r_normalize", V8::JS(doc), algorithm, format)
}
