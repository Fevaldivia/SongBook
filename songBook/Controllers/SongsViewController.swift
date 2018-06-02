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
    
    @IBOutlet weak var searchText: UITextField!
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.reloadData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.getSongs()
        self.tableView.reloadData()
    }
    
    var songs = [AnyObject]()
    var filteredSongs = [AnyObject]()
    
    func getSongs() {
        let urlString = "http://api.guitarparty.com/v2/songs/?query=All"
        let url = URL(string: urlString)
        var request = URLRequest(url: url!)
        
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue( Constants.API.APIKey, forHTTPHeaderField: "Guitarparty-Api-Key")
        
        let session = URLSession.shared
        
        let task = session.dataTask(with: request) {data, response, error in
            if error != nil {
                print("It Was an error in the task")
                return
            }
            
            guard let data = data else {
                print("No data to return")
                return
            }
            
            let parsedResult: [String:AnyObject]!
            
            do {
                parsedResult = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as! [String:AnyObject]
            }catch{
                print("There was an error parsing the data!")
                return
            }
            guard let songsDictonary = parsedResult["objects"] as? [[String:AnyObject]] else {
                print("We Couldn't get any song")
                return
            }
            
            for everySong in songsDictonary {
                self.songs.append(everySong as AnyObject)
            }
            
            self.performUIUpdatesOnMain {
                self.tableView.reloadData()
            }
        }
        task.resume()
    }
    
    
    //MARK: Search method
    
    @IBAction func searchSongButton(_ sender: Any) {
        if (searchText.text?.isEmpty)! {
            print("There is no song to search.")
        }else{
            let escapedURL = searchText.text!.addingPercentEncoding(withAllowedCharacters:NSCharacterSet.urlQueryAllowed)
            let urlString = "http://api.guitarparty.com/v2/songs/?query=\(escapedURL!)"
            let url = URL(string: urlString)
            var request = URLRequest(url: url!)
            
            request.addValue("application/json", forHTTPHeaderField: "Content-Type")
            request.addValue( Constants.API.APIKey, forHTTPHeaderField: "Guitarparty-Api-Key")
            
            let session = URLSession.shared
            
            let task = session.dataTask(with: request) {data, response, error in
                if error != nil {
                    print("It Was an error in the task")
                    return
                }
                
                guard let data = data else {
                    print("No data to return")
                    return
                }
                
                let parsedResult: [String:AnyObject]!
                
                do {
                    parsedResult = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as! [String:AnyObject]
                }catch{
                    print("There was an error parsing the data!")
                    return
                }
                guard let songsDictonary = parsedResult["objects"] as? [[String:AnyObject]] else {
                    print("We Couldn't get any song")
                    return
                }
                // remove my last search from the array
                self.filteredSongs.removeAll()
                
                for filter in songsDictonary {
                    self.filteredSongs.append(filter as AnyObject)
                }
                
                self.performUIUpdatesOnMain {
                    self.tableView.reloadData()
                }
            }
            task.resume()
        }
    }
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if filteredSongs.isEmpty {
           return self.songs.count
        }else{
            return self.filteredSongs.count
        }
        
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if filteredSongs.isEmpty {
            let cellID = "songsCell"
            
            let cell = tableView.dequeueReusableCell(withIdentifier: cellID)!
            let song = self.songs[(indexPath as NSIndexPath).row]
            
            if let songTitle = song["title"] as? String {
                self.performUIUpdatesOnMain {
                    cell.textLabel?.text = songTitle
                }
            }
            return cell
        }else{
            let cellID = "songsCell"
            
            let cell = tableView.dequeueReusableCell(withIdentifier: cellID)!
            let song = self.filteredSongs[(indexPath as NSIndexPath).row]
            
            if let songTitle = song["title"] as? String {
                self.performUIUpdatesOnMain {
                    cell.textLabel?.text = songTitle
                }
            }
            return cell
        }
        
    }

}

