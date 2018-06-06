//
//  SongsViewController.swift
//  songBook
//
//  Created by Felipe Valdivia on 12/14/17.
//  Copyright © 2017 Felipe Valdivia. All rights reserved.
//
import Foundation
import UIKit


class SongsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    //MARK: IBOutlets
    @IBOutlet weak var searchText: UITextField!
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.reloadData()
        self.tableView.delegate = self
        self.tableView.dataSource = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.getSongs()
        self.tableView.reloadData()
    }
    
    var songs = [AnyObject]()
    
    // fill table view with artist by letter A
    func getSongs() {
        GuitarFunctions.sharedInstanse.randomArtists { (result, error) in
            guard (result != nil || error == nil) else {
                print("No results or an error ocurred")
                return
            }
            
            GuitarFunctions.sharedInstanse.songs = result!
            
            self.performUIUpdatesOnMain {
                self.tableView.reloadData()
            }
        }
    }
    
    
    //MARK: Search method closure
    
    @IBAction func searchSongButton(_ sender: Any) {
        if (searchText.text?.isEmpty)! {
            print("There is no song to search.")
        }else{
            GuitarFunctions.sharedInstanse.searchText(searchByArtist: searchText.text!) { (result, error) in
                guard (result != nil || error == nil) else {
                    print("Result is nil")
                    return
                }
                
                GuitarFunctions.sharedInstanse.songs = result!
                
                self.performUIUpdatesOnMain {
                    self.tableView.reloadData()
                }
            }
        }
    }
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
           return GuitarFunctions.sharedInstanse.songs.count
        
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cellID = "songsCell"
            
            let cell = tableView.dequeueReusableCell(withIdentifier: cellID)!
            let song = GuitarFunctions.sharedInstanse.songs[indexPath.row]
            
            if let songTitle = song["title"] as? String {
                self.performUIUpdatesOnMain {
                    cell.textLabel?.text = songTitle
                }
            }
            return cell
        
    }
    // when I select a row send me to the detail song
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detailSong = self.storyboard!.instantiateViewController(withIdentifier: "detailSong") as! SongDetailViewController
        
        detailSong.song = GuitarFunctions.sharedInstanse.songs[(indexPath as NSIndexPath).row] as! [String:AnyObject]
        
        self.navigationController!.pushViewController(detailSong, animated: true)
    }

}

