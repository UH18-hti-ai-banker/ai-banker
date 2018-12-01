library(jsonlite)

setClass("OPAPI", slots=list(url="character",
                             key="character",
                             token="character"))

OPAPI <- function() {
  api_url <- "https://sandbox.apis.op-palvelut.fi/v1"
  api_key <- Sys.getenv("OP_API_KEY")
  api_token <- "b6910384440ce06f495976f96a162e2ab1bafbb4"
  new("OPAPI", url=api_url, key=api_key, token=api_token)
}

OPAPI_info <- function() {
  api_url <- "https://sandbox.apis.op-palvelut.fi/funds/info/v1"
  api_key <- Sys.getenv("OP_API_KEY")
  api_token <- "b6910384440ce06f495976f96a162e2ab1bafbb4"
  new("OPAPI", url=api_url, key=api_key, token=api_token)
}

setMethod("show", "OPAPI", function(object) {
  cat("URL:", object@url)
})

setGeneric("GET", function(object, endpoint) standardGeneric("GET"))
setMethod("GET", "OPAPI", function(object, endpoint = "") {
  url <- paste(object@url, endpoint, sep = "/")
  req <- httr::GET(url, httr::add_headers("x-api-key" = object@key, "x-authorization" = object@token))
  json <- httr::content(req, as = "text")
  fromJSON(json)
})

setGeneric("getFunds", function(object) standardGeneric("getFunds"))
setMethod("getFunds", "OPAPI", function(object) {
  GET(object, "funds")
})
