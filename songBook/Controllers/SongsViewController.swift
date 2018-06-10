//
//  SongsViewController.swift
//  songBook
//
//  Created by Felipe Valdivia on 12/14/17.
//  Copyright © 2017 Felipe Valdivia. All rights reserved.
//
import Foundation
import UIKit
import CoreData


class SongsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    //MARK: IBOutlets
    @IBOutlet weak var searchText: UITextField!
    @IBOutlet weak var tableView: UITableView!
    
    var activityIndicator: UIActivityIndicatorView = UIActivityIndicatorView()
    
    var dataController: DataController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.reloadData()
        self.tableView.delegate = self
        self.tableView.dataSource = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        performUIUpdatesOnMain {
            self.activityIndicator.center = self.view.center
            self.activityIndicator.hidesWhenStopped = true
            self.activityIndicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.gray
            self.view.addSubview(self.activityIndicator)
            
            self.activityIndicator.startAnimating()
        }
        self.getSongs()
        self.tableView.reloadData()
        self.activityIndicator.stopAnimating()
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
                self.activityIndicator.stopAnimating()
            }
        }
    }
    
    
    //MARK: Search method closure
    
    @IBAction func searchSongButton(_ sender: Any) {
        if (searchText.text?.isEmpty)! {
            self.errorAlert(title: "Error!", message: "TextBox! is EMPTY!")
        }else{
            GuitarFunctions.sharedInstanse.searchText(searchByArtist: searchText.text!) { (result, error) in
                guard (result != nil || error == nil) else {
                    print("Result is nil")
                    return
                }
                
                GuitarFunctions.sharedInstanse.songs = result!
                
                self.performUIUpdatesOnMain {
                    self.activityIndicator.center = self.view.center
                    self.activityIndicator.hidesWhenStopped = true
                    self.activityIndicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.gray
                    self.view.addSubview(self.activityIndicator)
                    self.activityIndicator.startAnimating()
                    
                    self.tableView.reloadData()
                    self.activityIndicator.stopAnimating()
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
        detailSong.dataController = dataController
        
        self.navigationController!.pushViewController(detailSong, animated: true)
    }

}

