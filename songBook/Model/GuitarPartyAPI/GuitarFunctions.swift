//
//  GuitarFunctions.swift
//  songBook
//
//  Created by Felipe Valdivia on 6/4/18.
//  Copyright © 2018 Felipe Valdivia. All rights reserved.
//
import Foundation
import UIKit

class GuitarFunctions: NSObject {
    
    static let sharedInstanse = GuitarFunctions()
    
    var songs = [AnyObject]()
    
    func searchText(searchByArtist: String , completionHandlerForSearch: @escaping (_ result: [AnyObject]?, _ error: NSError?)-> Void){
        
        let escapedURL = searchByArtist.addingPercentEncoding(withAllowedCharacters:NSCharacterSet.urlQueryAllowed)
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
            self.songs.removeAll()
            
            for filter in songsDictonary {
                self.songs.append(filter as AnyObject)
            }
            
            completionHandlerForSearch(self.songs, nil)
            
            
            
        }
        task.resume()
    }
    // End of search method
    
    // MARK: Fill the table view with artist that start with A
    func randomArtists(completionHandlerForSearch: @escaping (_ result: [AnyObject]?, _ error: NSError?)-> Void){
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
            
            // remove my last search from the array
            self.songs.removeAll()
            
            for everySong in songsDictonary {
                self.songs.append(everySong as AnyObject)
            }
            
            completionHandlerForSearch(self.songs, nil)
            
        }
        task.resume()
    }
}
