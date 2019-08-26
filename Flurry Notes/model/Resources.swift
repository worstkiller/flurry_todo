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
   static func getImage(type: NSCategory)-> String{
        switch type {
        case .Work:
            return "work"
        case .Travel:
            return "travel"
        case .Music:
            return "music"
        case .Study:
            return "study"
        case .Home:
            return "home"
        case .Shopping:
            return "shopping"
        case .Drawing:
            return "drawing"
        default:
            return ""
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
enum NSCategory {
    case Work
    case Travel
    case Music
    case Study
    case Home
    case Shopping
    case Drawing
}
