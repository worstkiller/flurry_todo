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
    mutating func  saveTask(taskResult: TaskResult) -> Bool{
        let entity = NSEntityDescription.entity(forEntityName: TASK_ENTITY, in: coreDataContext)
        let newTask = NSManagedObject(entity: entity!, insertInto: coreDataContext)
        newTask.setValue(taskResult.title, forKey: NSTaskEntity.TITLTE)
        newTask.setValue(taskResult.category, forKey: NSTaskEntity.CATEGORY)
        newTask.setValue(taskResult.date, forKey: NSTaskEntity.DATE)
        newTask.setValue(taskResult.id, forKey: NSTaskEntity.ID)
        newTask.setValue(taskResult.isCompleted, forKey: NSTaskEntity.IS_COMPLETED)
        newTask.setValue(taskResult.image, forKey: NSTaskEntity.IMAGE)
        
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
        var tempResult = [TaskResult]()
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: TASK_ENTITY)
       
        if NSCategory.All != nsCategory{
            fetchRequest.predicate = NSPredicate(format: "\(NSTaskEntity.CATEGORY) == %@", nsCategory.rawValue)
        }

        do {
            let result = try coreDataContext.fetch(fetchRequest)
            for data in result as! [NSManagedObject] {
                let title = data.value(forKey: NSTaskEntity.TITLTE) as! String
                let id = data.value(forKey: NSTaskEntity.ID) as! String
                let image = data.value(forKey: NSTaskEntity.IMAGE) as! String
                let category = data.value(forKey: NSTaskEntity.CATEGORY) as! String
                let isCompleted = data.value(forKey: NSTaskEntity.IS_COMPLETED) as! Bool
                let date = data.value(forKey: NSTaskEntity.DATE) as! Int64
                
                let taskItem = TaskResult(id: id, title: title, category: category, date: date, image: image, isCompleted: isCompleted)
                
                tempResult.append(taskItem)
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
    mutating func getItemsCountFor(nsCategory: NSCategory)-> Int{
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: TASK_ENTITY)
       
        if NSCategory.All != nsCategory{
             fetchRequest.predicate = NSPredicate(format: "\(NSTaskEntity.CATEGORY) == %@", nsCategory.rawValue)
        }
        
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
    
    //call this to get single CategoryResult based on NSCategory
    mutating func getCategoryResultFrom(nsCategory: NSCategory) -> CategoryResult? {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: CATEGORY_ENTITY)
        fetchRequest.predicate = NSPredicate(format: "\(NSCategoryEntity.TITLTE) == %@", nsCategory.rawValue)
        do {
            let result = try coreDataContext.fetch(fetchRequest)
            for data in result as! [NSManagedObject] {
                let id = data.value(forKey: NSCategoryEntity.ID) as! String
                let image = data.value(forKey: NSCategoryEntity.IMAGE) as! String
                let title = data.value(forKey: NSCategoryEntity.TITLTE) as! String
                let date = data.value(forKey: NSCategoryEntity.DATE) as! Int64
                //only single result should be there so returning it
                return CategoryResult(id: id , title: title , date: date, image: image)
                print("One item retrieved for category")
            }
        } catch {
            print("Failed")
        }
        return nil
    }
    
    //get all the categories who have any tasks related
    mutating func getAllCategoriesWithTasks()->[CategoryResult]{
        var tempResult = [CategoryResult]()
        for item in NSCategory.allCases {
            let tasksCountForSingleCategory = getItemsCountFor(nsCategory: item)
            if tasksCountForSingleCategory > 0 {
                if let item = getCategoryResultFrom(nsCategory: item){
                    tempResult.append(item)
                }
            }
        }
        return tempResult
    }
    
    //update task for category
    mutating func updateTaskFor(taskResult : TaskResult) {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: TASK_ENTITY)
        fetchRequest.predicate = NSPredicate(format: "\(NSTaskEntity.ID) == %@", taskResult.id)
        do {
            let result = try coreDataContext.fetch(fetchRequest)
            let singleObj = result[0] as! NSManagedObject
            singleObj.setValue(taskResult.isCompleted, forKey: NSTaskEntity.IS_COMPLETED)
            singleObj.setValue(taskResult.id, forKey: NSTaskEntity.ID)
            singleObj.setValue(taskResult.category, forKey: NSTaskEntity.CATEGORY)
            singleObj.setValue(taskResult.date, forKey: NSTaskEntity.DATE)
            singleObj.setValue(taskResult.image, forKey: NSTaskEntity.IMAGE)
            singleObj.setValue(taskResult.title, forKey: NSTaskEntity.TITLTE)
            try coreDataContext.save()
            print("Task is updated")
        } catch {
            print("Failed")
        }
    }
}


