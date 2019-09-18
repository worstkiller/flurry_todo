//
//  AlarmManager.swift
//  Flurry Notes
//
//  Created by Vikas on 16/09/19.
//  Copyright © 2019 Vikas. All rights reserved.
//

import Foundation
import UserNotifications

protocol AlarmScheduler: class {
    func scheduleNotifications(taskResult: TaskResult)
    func cancelUserNotifications(alarm: TaskResult)
}

extension AlarmScheduler {
    
    func cancelUserNotifications(alarm: TaskResult) {
        UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers: [alarm.id])
    }
    
    func scheduleNotifications(taskResult: TaskResult)
    {
        let mutable = UNMutableNotificationContent()
        mutable.title = try! "Your \(TaskUtilties.getFormattedDay(dateTime: taskResult.date))'s mission is ready"
        mutable.body = taskResult.title
        mutable.sound = .default
        
        let dateComponents = Calendar.current.dateComponents([.hour, .minute], from: TaskUtilties.getDateFromEpoch(epoch: taskResult.date))
        let calendar = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: false)
        let request = UNNotificationRequest(identifier: taskResult.id, content: mutable, trigger: calendar)
        UNUserNotificationCenter.current().add(request)
    }
}

class AlarmManager: AlarmScheduler {
    
    static let sharedInstance = AlarmManager()
    
    func addAlarm(taskResult: TaskResult) {
        if !taskResult.isCompleted {
            scheduleNotifications(taskResult: taskResult)
        } else {
            cancelUserNotifications(alarm: taskResult)
        }
    }
}

