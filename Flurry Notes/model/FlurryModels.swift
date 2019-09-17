//
//  FlurryModels.swift
//  Flurry Notes
//
//  Created by Vikas on 27/08/19.
//  Copyright © 2019 Vikas. All rights reserved.
//

import Foundation

//db result objects
struct TaskResult {
    let id: String
    var title: String
    var category: String
    var date: Int64
    var image: String
    var isCompleted: Bool
    
    //factory method to get a instance of the taska result
    static func getInstance(title: String, category: String, date: Int64) -> TaskResult{
        return TaskResult(id: TaskUtilties.generateTransactionId(), title: title, category: category, date: date, image: Resources.getImageForCategory(type: NSCategory.getNSCategoryFrom(rawValue: category)), isCompleted: false)
    }
    
}

extension TaskResult: Equatable {
    static func == (lhs: TaskResult, rhs: TaskResult) -> Bool {
        return lhs.date == rhs.date && lhs.id == rhs.id && lhs.isCompleted == rhs.isCompleted && lhs.title == rhs.title && lhs.category == rhs.category && lhs.image  == rhs.image
    }
}

struct CategoryResult {
    let id: String
    let title: String
    let date: Int64
    let image: String
}
