//
//  TasksHeaderModel.swift
//  Flurry Notes
//
//  Created by Vikas on 31/08/19.
//  Copyright © 2019 Vikas. All rights reserved.
//

import Foundation

//a somple  model for organising the data as per header
struct TaskHeaderModel {
    private let header : String
    private let items : [TaskResult]
    
    init(header: String, items: [TaskResult]) {
        self.header = header
        self.items = items
    }
    
    func getHeader()-> String{
        return header
    }
    
    func getTaskResults()-> [TaskResult]{
        return items
    }
    
    enum HEADER : String, CaseIterable, Comparable{
        case Late
        case Today
        case Upcoming
        case Done
        
        private var sortOrder: Int {
            switch self {
            case .Late:
                return 0
            case .Today:
                return 1
            case .Upcoming:
                return 2
            case .Done:
                return 3
            }
        }
        
        static func < (lhs: TaskHeaderModel.HEADER, rhs: TaskHeaderModel.HEADER) -> Bool {
           return lhs.sortOrder < rhs.sortOrder
        }
        
    }
}
