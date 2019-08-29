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
    let CATEGORY_ENTITY = "CategoryEntity"
    
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
        newTask.setValue(Resources.getImageForCategory(type: tag), forKey: NSTaskEntity.IMAGE)
        
        do {
            try coreDataContext.save()
            return true
        } catch {
            print("saving failed")
            return false
        }
    }
    
    //call this to add the default categories
    mutating func addDefaultCategory() ->Bool{
        let entity = NSEntityDescription.entity(forEntityName: CATEGORY_ENTITY, in: coreDataContext)
        for category in NSCategory.allCases {
            let newCategory = NSManagedObject(entity: entity!, insertInto: coreDataContext)
            newCategory.setValue(category.rawValue, forKey: NSCategoryEntity.TITLTE )
            newCategory.setValue(TaskUtilties.generateTransactionId(), forKey: NSCategoryEntity.ID)
            newCategory.setValue(TaskUtilties.getDateTime(), forKey: NSCategoryEntity.DATE)
            newCategory.setValue(Resources.getImageForCategory(type: category), forKey: NSCategoryEntity.IMAGE)
            
            do {
                try coreDataContext.save()
            } catch {
                print("saving failed")
                return false
            }
        }
         return true
    }
    
    //get all task which belong some category
    mutating func getAllTasksFor(nsCategory: NSCategory)-> [TaskResult]{
        let tempResult = [TaskResult]()
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: CATEGORY_ENTITY)
        do {
            let result = try coreDataContext.fetch(fetchRequest)
            for data in result as! [NSManagedObject] {
                print(data.value(forKey: "title"))
            }
        } catch {
            print("Failed")
        }
        return tempResult
    }
    
    //check if there is category present or not
    mutating func hasCategoryItems()-> Bool{
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: CATEGORY_ENTITY)
        do{
            let result = try coreDataContext.fetch(fetchRequest)
            return result.count>0
        }catch{
            return false
        }
    }
    
    //returns count if there is category present or 0
    mutating func categoryItemsCountFor(nsCategory: NSCategory)-> Int{
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: TASK_ENTITY)
        fetchRequest.predicate = NSPredicate(format: "\(NSTaskEntity.CATEGORY) == %@", nsCategory.rawValue)
        do{
            let result = try coreDataContext.fetch(fetchRequest)
            return result.count
        }catch{
            return 0
        }
    }
    
    //check if there is category present or not
    mutating func hasTaskItems()-> Bool{
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: TASK_ENTITY)
        do{
            let result = try coreDataContext.fetch(fetchRequest)
            return result.count>0
        }catch{
            return false
        }
    }
    
    //get all the category
    mutating func getAllCategory()->[CategoryResult]{
        var tempResult = [CategoryResult]()
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: CATEGORY_ENTITY)
        do {
            let result = try coreDataContext.fetch(fetchRequest)
            for data in result as! [NSManagedObject] {
                let id = data.value(forKey: NSCategoryEntity.ID) as! String
                let image = data.value(forKey: NSCategoryEntity.IMAGE) as! String
                let title = data.value(forKey: NSCategoryEntity.TITLTE) as! String
                let date = data.value(forKey: NSCategoryEntity.DATE) as! Int64
                
                let item = CategoryResult(id: id , title: title , date: date, image: image)
                tempResult.append(item)
               print("One item retrieved for category")
            }
        } catch {
            print("Failed")
        }
        return tempResult
    }
}


