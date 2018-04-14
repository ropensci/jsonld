#' @importFrom V8 new_context
.onLoad <- function(lib, pkg){
  assign("ctx", V8::v8("window"), environment(.onLoad))
  ctx$source(system.file("js/jsonld.min.js", package = pkg))
  #ctx$source(system.file("js/es6-promise.js", package = pkg))
  ctx$source(system.file("js/wrappers.js", package = pkg))
}
