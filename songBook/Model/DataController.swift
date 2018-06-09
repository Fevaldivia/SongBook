//
//  DataController.swift
//  songBook
//
//  Created by Felipe Valdivia on 6/7/18.
//  Copyright © 2018 Felipe Valdivia. All rights reserved.
//

import Foundation
import CoreData

class DataController {
    let persistantContainer:NSPersistentContainer
    
    var viewContext:NSManagedObjectContext {
        return persistantContainer.viewContext
    }
    
    init(modelName:String) {
        persistantContainer = NSPersistentContainer(name: modelName)
    }
    
    func load(completion: (() -> Void)? = nil){
        persistantContainer.loadPersistentStores { (storeDescription, error) in
            guard error == nil else {
                fatalError(error!.localizedDescription)
                return
            }
            completion?()
        }
    }
}
