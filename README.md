# Song Book 

[![Build Status][travis-image]][travis-url]
[![License][license-image]][license-url]
[![Platform](https://img.shields.io/cocoapods/p/LFAlertController.svg?style=flat)](http://cocoapods.org/pods/LFAlertController)

This app is a classic version of old songBooks that I used to buy to learn new guitar songs now in your phone and available to search 
any song that you would like to learn.

## Getting Started

You need Xcode and Swift 4 installed in your computer so you can run this project without any problems or code errors. The API that 
I am using in this project lamentably is not updated and the request is via HTTP so I have to write in the plist file to accept this 
kind of request in my app.

Download the app from this github profile and save it into your computer make sure that you have the last version of Xcode and Swift open
Xcode and choose open project go to the songBook project and open it.


## Features

- [x] Search by artists
- [x] Save song into your favorites
- [x] Delete songs from your book
- [x] See the chords + lyrics in every song

## Some Methods that you can find in this app
```
getSongs() // this method is to get a list of songs to fill the first table view.
searchSongs(text: textField) // we use this method to search by artist that the user write in the textfield.
deleteSong() // this method is to delete songs from your favorites calling the coredata and working with the context.
addSong() // this method is to add songs to the songBook Core Data and show it in Favorites.
```

## Future Improvements
- I want to find a better API to have more artist and endPoints to create a more complete app.
- Work with body of the song to highlight Chords and organize lyrics in a better way. 
- Add AutoScroll so the user doesn't need to stop playing to see the next chords and lyrics. 
- Add social network features like sharing in fb or instagram and maybe add registration.

## Authors

* **Felipe Valdivia** - *iOS Developer* - [Website](http://fvaldivia.com/)

## License

This project is licensed under the MIT License - see the [LICENSE.md](LICENSE.md) file for details

## Social

Felipe Valdivia – [@FeValdiviaA](https://twitter.com/FeValdiviaA) – fe.valdiviaa@gmail.com
Felipe Valdivia - *iOS Developer* - [Website](http://fvaldivia.com/)











