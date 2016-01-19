library(httr)

api_key <- "4f9974ed9c4ba04650ae725d743c9986"

flickr_photos_search_one <- function(api_key, query) {
  resp <- GET(
    sprintf(
      "https://api.flickr.com/services/rest/?method=flickr.photos.search&format=json&api_key=%s&text=%s&safe_search=1&content_type=1&per_page=1&sort=relevance",
      api_key,
      utils::URLencode(query)
    ),
    accept_json()
  )
  resp <- jsonlite::fromJSON(sub("^jsonFlickrApi\\((.*)\\)$", "\\1", rawToChar(resp$content)))
  resp$photos$photo
}

flickr_photo_url <- function(photo) {
  sprintf(
    "https://farm%s.staticflickr.com/%s/%s_%s.jpg",
    photo$farm,
    photo$server,
    photo$id,
    photo$secret
  )
}
