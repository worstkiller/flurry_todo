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
    
    let TASK_ENTITY = "TaskEntity"
    
    lazy var coreDataContext : NSManagedObjectContext = {
         (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    }()
    
    //call this to save the task object
    mutating func  saveTask(title: String, tag: NSCategory) -> Bool{
        let entity = NSEntityDescription.entity(forEntityName: TASK_ENTITY, in: coreDataContext)
        let newTask = NSManagedObject(entity: entity!, insertInto: coreDataContext)
        newTask.setValue(title, forKey: NSTaskEntity.TITLTE)
        newTask.setValue(tag.rawValue, forKey: NSTaskEntity.CATEGORY)
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


