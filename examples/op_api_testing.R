library(jsonlite)
library(httr)

api_url <- "https://sandbox.apis.op-palvelut.fi/v1/"
api_key <- Sys.getenv("OP_API_TOKEN")
api_token <- "b6910384440ce06f495976f96a162e2ab1bafbb4"

url <- paste(api_url, "funds", sep = "/")
req <- GET(url, add_headers("x-api-key" = api_key, "x-authorization" = api_token))
json <- content(req, as = "text")
funds <- fromJSON(json)