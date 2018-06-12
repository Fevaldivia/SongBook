//
//  SongDetailViewController.swift
//  songBook
//
//  Created by Felipe Valdivia on 6/2/18.
//  Copyright © 2018 Felipe Valdivia. All rights reserved.
//
import UIKit
import CoreData

class SongDetailViewController: UIViewController {
    //MARK: IBOutlets
    @IBOutlet weak var titleSongLabel: UILabel!
    @IBOutlet weak var bodySongLabel: UITextView!
    @IBOutlet weak var saveIcon: UIButton!
    @IBOutlet weak var removeIcon: UIButton!
    
    var song = [String:AnyObject]()
    
    var favoriteSongs = [Song]()
    
    var dataController:DataController!
    
    override func viewDidLoad() {
        performUIUpdatesOnMain {
            self.titleSongLabel.text = self.song["title"] as? String
            self.bodySongLabel.text = self.song["body"] as? String
        }
        
        let title = self.song["title"] as? String
        let body = self.song["body"] as? String
        var isFav = false
        for songs in favoriteSongs {
            if songs.title == title && songs.body == body{
                isFav = true
            }
        }
        
        // Checking for this song is it in favourite or not. This will prevent duplication in core data.
        if isFav {
            saveIcon.isSelected = true
            saveIcon.setImage(#imageLiteral(resourceName: "savedSong"), for: .selected)
        }else{
            saveIcon.isSelected = false
            saveIcon.setImage(#imageLiteral(resourceName: "beforeSave"), for: .normal)
        }
        
    }
    
    
    
    
    func favorited(button: UIButton) {
        button.isSelected = true
        button.setImage(#imageLiteral(resourceName: "savedSong"), for: .selected)
    }
    
    func notFavorited(button: UIButton) {
        button.isSelected = false
        button.setImage(#imageLiteral(resourceName: "beforeSave"), for: .normal)
    }
    
    @IBAction func saveToFavorites(_ sender: Any) {
        
        // checking for if song is already favourite or not by checking saveIcon is selected means it is in favourite so it have to remove from here.
        if saveIcon.isSelected {
            self.removeFromFav()
            return
        }
        
        // If  saveIcon button is not selected so it is not in favourite so you can save it to favourite.
        let saveSong = Song(context: dataController.viewContext)
        saveSong.title = self.song["title"] as? String
        saveSong.body = self.song["body"] as? String
        saveSong.isSaved = true
        
        if ((try? dataController.viewContext.save()) != nil) {
            performUIUpdatesOnMain {
                self.favorited(button: self.saveIcon)
            }
            self.favoriteSongs.append(saveSong)
            self.errorAlert(title: "Success!", message: "Congrats you have a new song in your book!")
        }else{
            self.errorAlert(title: "Error!", message: "We Couldn't save this song in your fav.")
        }
    }
    
    
    
    func removeFromFav(){
        // Here i am searching for the match of current song and if current song found in favourite then it will be delete it will resolve the crash issue because in old code the favoritesong object was null.
        let title = self.song["title"] as? String
        let body = self.song["body"] as? String
        
        for songs in favoriteSongs {
            if songs.title == title && songs.body == body{
                favoriteSongs.remove(at: favoriteSongs.index(of: songs)!)
                dataController.viewContext.delete(songs)
            }
        }
        if ((try? dataController.viewContext.save()) != nil) {
            self.errorAlert(title: "Success!", message: "Your song has been removed from favorites!")
            performUIUpdatesOnMain {
                self.notFavorited(button: self.saveIcon)
            }
        }else{
            self.errorAlert(title: "Error!", message: "We couldn't remove this song, try later")
        }
    }
    
    
}
