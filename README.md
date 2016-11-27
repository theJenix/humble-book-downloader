# humble-book-downloader
A set of scripts for automating download and retrieval of humble book bundles

## Set up
* Modify .destination to specify a destination folder (defaults to .)

## Usage
* Log into the Humble Bundle site, and browse to your purchases.
* Open an eBook bundle you wish to download
* Using the Developer tools (or other means), capture the response from the call to https://www.humblebundle.com/api/v1/order and save in <name>.json (where <name> is some unique name)
* Run ./download.sh <name.json to download that bundle, or capture multiple bundles (in separate json files) and run ./download_all.sh
* Enjoy all your local content!


## Why?
I buy more than a few Humble eBook bundles, and the Humble Bundle isn't the fastest or most mobile friendly.  I usually try and archive all of my eBooks on Dropbox, but and downloading/archiving all of the content in a bundle is a pain in the ass.  This makes it less painful.

## Contribute
If you can improve upon this, please do and send me a pull request.  I eventually want to roll this into a browser add-in that will detect/capture the API call on the page and automate the download directly from within the browser, but I'm happy to consider any/all contributions.

