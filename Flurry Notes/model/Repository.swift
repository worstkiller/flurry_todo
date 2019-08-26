//
//  Repository.swift
//  Flurry Notes
//
//  Created by Vikas on 26/08/19.
//  Copyright © 2019 Vikas. All rights reserved.
//

import UIKit
import CoreData

//a repository instance to save, delete, and update data inside the core data
struct Repository {
    
    let DB_REFERENCE = "Flurry_Notes"
    
    lazy var coreDataContext : NSManagedObjectContext = {
         (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    }()
    
    //call this to save the task object
    mutating func  saveTask(title: String, tag: NSCategory) -> Bool{
        let entity = NSEntityDescription.entity(forEntityName: DB_REFERENCE, in: coreDataContext)
        let newTask = NSManagedObject(entity: entity!, insertInto: coreDataContext)
        newTask.setValue(title, forKey: NSTaskEntity.TITLTE)
        newTask.setValue(tag, forKey: NSTaskEntity.CATEGORY)
        newTask.setValue(TaskUtilties.getDateTime(), forKey: NSTaskEntity.DATE)
        newTask.setValue(TaskUtilties.generateTransactionId(), forKey: NSTaskEntity.ID)
        newTask.setValue(false, forKey: NSTaskEntity.IS_COMPLETED)
        newTask.setValue(Resources.getImage(type: tag), forKey: NSTaskEntity.IMAGE)
        
        do {
            try coreDataContext.save()
            return true
        } catch {
            print("saving failed")
            return false
        }
    }
}


