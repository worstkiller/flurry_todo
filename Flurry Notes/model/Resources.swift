//
//  Resources.swift
//  Flurry Notes
//
//  Created by Vikas on 25/08/19.
//  Copyright © 2019 Vikas. All rights reserved.
//

import Foundation

struct Resources {

    func getImage(type: Images)-> String{
        switch type {
        case .DOCUMENT:
            return "document"
        case .ALARM:
            return "alarm"
        case .TAG:
            return "tag"
        case .TRAVEL:
            return "travel"
        case .WORK:
            return "work"
        case .STUDY:
            return "work"
        case .SHOPPING:
            return "shopping"
        case .PLUS:
            return "plus"
        case .MUSIC:
            return "music"
        case .MORE:
            return "more"
        case .HOME:
            return "home"
        case .DRAWING:
            return "drawing"
        case .TASKS_BACKGROUND:
            return "task_background"
        case .CLOSE:
            return "close"
        case .BACK:
            return "back"
        default:
            return ""
        }
    }
    
}

//all images enum
enum Images {
    case DOCUMENT
    case ALARM
    case TAG
    case TRAVEL
    case WORK
    case STUDY
    case SHOPPING
    case PLUS
    case MUSIC
    case MORE
    case HOME
    case DRAWING
    case TASKS_BACKGROUND
    case CLOSE
    case BACK
}
