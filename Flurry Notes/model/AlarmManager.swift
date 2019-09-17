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
    func scheduleUserNotifications(alarm: TaskResult)
    func cancelUserNotifications(alarm: TaskResult)
}

extension AlarmScheduler {

    func scheduleUserNotifications(alarm: TaskResult) {
        let mutable = UNMutableNotificationContent()
        mutable.title = "Flurry Task"
        mutable.body = alarm.title
        mutable.sound = .default
        
        let dateComponents = Calendar.current.dateComponents([.hour, .minute], from: TaskUtilties.getDateFromEpoch(epoch: alarm.date))
        let calendar = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)
        let request = UNNotificationRequest(identifier: alarm.id, content: mutable, trigger: calendar)
        UNUserNotificationCenter.current().add(request)
    }
    
    func cancelUserNotifications(alarm: TaskResult) {
        UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers: [alarm.id])
    }
}

class AlarmManager: AlarmScheduler {
    
    static let sharedInstance = AlarmManager()
    
    func addAlarm(taskResult: TaskResult) {
        if !taskResult.isCompleted {
            scheduleUserNotifications(alarm: taskResult)
        } else {
            cancelUserNotifications(alarm: taskResult)
        }
    }
}

