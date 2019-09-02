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
}

struct CategoryResult {
    let id: String
    let title: String
    let date: Int64
    let image: String
}
