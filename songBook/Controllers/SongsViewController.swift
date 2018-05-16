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
    
    let rockSongs = [
        "Back in Black",
        "Highway to Hell",
        "Wabash Cannonball",
        "Dream On",
        "Toys in the Attic",
        "Planet Rock",
        "Ramblin' Man",
        "Whipping Post"
    ]
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return self.rockSongs.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellID = "songsCell"
        
        let cell = tableView.dequeueReusableCell(withIdentifier: cellID)!
        let favoriteThingForRow = self.rockSongs[(indexPath as NSIndexPath).row]
        cell.textLabel?.text = favoriteThingForRow
        
        return cell
        
    }

}

