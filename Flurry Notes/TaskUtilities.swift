//
//  TaskUtilities.swift
//  Flurry Notes
//
//  Created by Vikas on 26/08/19.
//  Copyright © 2019 Vikas. All rights reserved.
//

import Foundation
import MaterialComponents.MaterialSnackbar

struct TaskUtilties {
    
    //get date and time from epoch
     static func getDateTime() -> Int64 {
        return Date().currentTimeMillis()
    }
    
    //get unique id generator
    static func generateTransactionId(length: Int = 5) -> String {
        var result = ""
        let base62chars = [Character]("0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz")
        let maxBase : UInt32 = 62
        let minBase : UInt16 = 32
        
        for _ in 0..<length {
            let random = Int(arc4random_uniform(UInt32(min(minBase, UInt16(maxBase)))))
            result.append(base62chars[random])
        }
        return result
    }
    
    //show a bottom snackbar message
     static func showToast(msg: String) {
        let message = MDCSnackbarMessage()
        message.text =  msg
        MDCSnackbarManager.show(message)
    }
}

extension Date {
    func currentTimeMillis() -> Int64 {
        return Int64(self.timeIntervalSince1970 * 1000)
    }
}
