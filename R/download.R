download <- function(url){
  h <- curl::new_handle()
  curl::handle_setheaders(h, "Accept" = "application/ld+json, application/json")
  req <- curl::curl_fetch_memory(url, handle = h)
  if(req$status >= 400){
    json <- rawToChar(req$content)
    if(jsonlite::validate(json)){
      data <- jsonlite::fromJSON(json)
      if(length(data$message))
        stop(sprintf("(%s) %s", url, data$message))
    }
    stop(sprintf("Download (HTTP %d): %s", req$status, url))
  }
  headers <- curl::parse_headers(req$headers)
  get_header <- function(name){
    val <- grep(paste0("^", name, "[ \t]*:"), headers, ignore.case = TRUE, value = TRUE)
    strsplit(val[1], ":[ \t]*")[[1]][2]
  }
  list(
    content_type = jsonlite::unbox(get_header("content-type")),
    link = jsonlite::unbox(get_header("link")),
    final_url = jsonlite::unbox(req$url),
    response_text = jsonlite::unbox(rawToChar(req$content))
  )
}



