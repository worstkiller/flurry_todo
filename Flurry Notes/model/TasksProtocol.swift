//
//  TasksProtocol.swift
//  Flurry Notes
//
//  Created by Vikas on 31/08/19.
//  Copyright © 2019 Vikas. All rights reserved.
//

import Foundation

/*
 A contact between client and provider for tasks realted data
 */
protocol TaskProtocol {
    func getAllFormattedTasks(repository: Repository, nsCategory: NSCategory, completion: @escaping ([String: [TaskResult]]?) -> Void)
}
