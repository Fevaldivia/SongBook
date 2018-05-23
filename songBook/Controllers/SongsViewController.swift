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
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.songs.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellID = "songsCell"
        
        let cell = tableView.dequeueReusableCell(withIdentifier: cellID)!
        let song = self.songs[(indexPath as NSIndexPath).row]
        
        if let songTitle = song["title"] as? String {
            self.performUIUpdatesOnMain {
                cell.textLabel?.text = songTitle
            }
        }
        return cell
    }

}

