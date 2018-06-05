//
//  SongDetailViewController.swift
//  songBook
//
//  Created by Felipe Valdivia on 6/2/18.
//  Copyright © 2018 Felipe Valdivia. All rights reserved.
//
import UIKit

class SongDetailViewController: UIViewController {
    //MARK: IBOutlets
    @IBOutlet weak var titleSongLabel: UILabel!
    @IBOutlet weak var bodySongLabel: UITextView!
    
    var song = [String:AnyObject]()
    
    override func viewDidLoad() {
        performUIUpdatesOnMain {
            self.titleSongLabel.text = self.song["title"] as? String
            self.bodySongLabel.text = self.song["body"] as? String
        }
        
    }
}
