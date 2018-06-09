//
//  FavoritesSongsViewController.swift
//  songBook
//
//  Created by Felipe Valdivia on 6/8/18.
//  Copyright © 2018 Felipe Valdivia. All rights reserved.
//

import UIKit
import CoreData

class FavoritesSongsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var favSongs: [Song] = []
    
    var dataController:DataController!
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //Fetching data from store
        let fetchRequest:NSFetchRequest<Song> = Song.fetchRequest()
        if let result = try? dataController.viewContext.fetch(fetchRequest){
            favSongs = result
            tableView.reloadData()
        }
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.favSongs.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellID = "FavSongs"
        
        let cell = tableView.dequeueReusableCell(withIdentifier: cellID)!
        let song = favSongs[indexPath.row]
        
        cell.textLabel?.text = song.title

        return cell
    }
}
