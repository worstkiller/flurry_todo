//
//  TasksProtocol.swift
//  Flurry Notes
//
//  Created by Vikas on 31/08/19.
//  Copyright © 2019 Vikas. All rights reserved.
//

import Foundation
import UIKit

/*
 A contract between client and provider for tasks realted data
 */
protocol TaskProtocol {
    func getAllFormattedTasks(repository: Repository, nsCategory: NSCategory, completion: @escaping ([TaskHeaderModel]) -> Void)
}

protocol TaskCellUpdateProtocol {
    func checkBoxUpdated(isChecked: Bool, rowIndex: IndexPath)
}

protocol CategorySelectionProtocol {
    func onCategoryClick(categoryResult: CategoryResult)
}

protocol CategoryCellSelectionProtocol {
    func onCategoryClick(rowIndex: IndexPath)
}

protocol DateSelector {
    func onDateSelected(dateRaw: Date?)
}
