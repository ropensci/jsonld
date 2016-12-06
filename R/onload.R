#' @importFrom V8 new_context
.onLoad <- function(lib, pkg){
  assign("ctx", V8::v8("window"), environment(.onLoad))
  ctx$source(system.file("js/jsonld.js", package = pkg))
  ctx$source(system.file("js/wrappers.js", package = pkg))
}
