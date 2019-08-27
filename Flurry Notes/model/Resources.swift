//
//  Resources.swift
//  Flurry Notes
//
//  Created by Vikas on 25/08/19.
//  Copyright © 2019 Vikas. All rights reserved.
//

import Foundation

struct Resources {
    
    /*
     get an image from for a category
    */
   static func getImageForCategory(type: NSCategory)-> String{
        switch type {
        case .Work:
            return Images.WORK
        case .Travel:
            return Images.TRAVEL
        case .Music:
            return Images.MUSIC
        case .Study:
            return Images.STUDY
        case .Home:
            return Images.HOME
        case .Shopping:
            return Images.SHOPPING
        case .Drawing:
            return Images.DRAWING
        default:
            return Images.DOCUMENT
        }
    }
 
    //all images enum
   internal struct Images {
        static let DOCUMENT = "document"
        static let ALARM = "alarm"
        static let TAG = "tag"
        static let TRAVEL = "travel"
        static let WORK = "work"
        static let STUDY = "study"
        static let SHOPPING = "shopping"
        static let PLUS = "plus"
        static let MUSIC = "music"
        static let MORE = "more"
        static let HOME = "home"
        static let DRAWING = "drawing"
        static let TASKS_BACKGROUND = "task_background"
        static let CLOSE = "close"
        static let BACK = "back"
    }
    
}

//all images enum
enum NSCategory: String, CaseIterable {
    case All
    case Work
    case Music
    case Travel
    case Study
    case Home
    case Drawing
    case Shopping
}
