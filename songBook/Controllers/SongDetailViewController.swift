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
    
    var song = [String:AnyObject]()
    
    var dataController:DataController!
    
    override func viewDidLoad() {
        notFavorited(button: saveIcon)
        performUIUpdatesOnMain {
            self.titleSongLabel.text = self.song["title"] as? String
            self.bodySongLabel.text = self.song["body"] as? String
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
        
        let saveSong = Song(context: dataController.viewContext)
        saveSong.title = self.song["title"] as? String
        saveSong.body = self.song["body"] as? String
        saveSong.isSaved = true
        
        if ((try? dataController.viewContext.save()) != nil) {
            print("Congrats you have a new song in your book!")
            performUIUpdatesOnMain {
                self.favorited(button: self.saveIcon)
            }
        }else{
            print("We Couldn't save this song in your fav.")
        }
    }
    
}
