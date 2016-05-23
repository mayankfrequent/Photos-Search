# PhotosSearch

Photos search is a simple implementation using Flickr API

## Features

- Can display recent photos that are publicly available using Flickr API
- Can search for photos using specific words
- Handles the downloading and caching of photos
- Lazy loading of bigger size photos

#### Opensource libraries used

- [AFNetworking](https://github.com/AFNetworking/AFNetworking)
- [IDMPhotoBrowser](https://github.com/ideaismobile/IDMPhotoBrowser)

AFNetworking is used for interacting with Flickr API
IDMPhotoBrowser is used to load and show the image on the full screen with its details. This also takes care of the caching using SDWebImage

To build the sample app you either can download the source code or open up Terminal and type

git clone https://github.com/mayankfrequent/Photos-Search.git

Double click FlickrSearch.xcworkspace and then you're good to go! :)

Note: API key is also included in the sample code