//
//  DetailsViewTasksControllerCollectionViewCell.swift
//  Flurry Notes
//
//  Created by Vikas on 15/08/19.
//  Copyright © 2019 Vikas. All rights reserved.
//

import UIKit

class DetailsViewTasksController: UICollectionViewController, TaskCellUpdateProtocol{
    var categoryResult: CategoryResult?
    var repository = Repository()
    var itemsMappedToHeader = [TaskHeaderModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initViews()
    }
    
    func initViews(){
         getSortedItemsForCategory(category: NSCategory.getNSCategoryFrom(rawValue: categoryResult?.title ?? NSCategoryEntity.TITLTE))
    }
    
    override func collectionView(_ collectionView: UICollectionView,
                                 numberOfItemsInSection section: Int) -> Int {
        return itemsMappedToHeader[section].getTaskResults().count
    }
    
    override func collectionView(_ collectionView: UICollectionView,
                                 cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = self.collectionView?.dequeueReusableCell(withReuseIdentifier: "TasksCell",for: indexPath) as! TasksCell
        let singleITem = itemsMappedToHeader[indexPath.section].getTaskResults()[indexPath.row]
        cell.title.text = singleITem.title
        cell.dateTime.text = try? TaskUtilties.getFormattedDate(dateTime: singleITem.date)
        cell.isCompleted.boxType = .square
        cell.indexPath = indexPath
        cell.calllerProtocol = self
        cell.isCompleted.setOn(singleITem.isCompleted, animated: true)
        return cell
    }
    
    //will get called everytime checkbox changes
    func checkBoxUpdated(isChecked: Bool, rowIndex: IndexPath) {
        var task =
            itemsMappedToHeader[rowIndex.section].getTaskResults()[rowIndex.row]
        task.isCompleted = isChecked
        repository.updateTaskFor(taskResult: task)
        print("Updated received for cell check box")
    }
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return itemsMappedToHeader.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        if let sectionHeader = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "TasksHeaderCell", for: indexPath) as? TasksHeaderCell{
            sectionHeader.headerLabel.text = itemsMappedToHeader[indexPath.section].getHeader()
            print("Header index row is \(indexPath.row)")
            return sectionHeader
        }
        return UICollectionReusableView()
    }
    
    private func getSortedItemsForCategory(category: NSCategory){
        getAllFormattedTasks(repository: repository, nsCategory: category){ data -> Void in
            self.itemsMappedToHeader = data
            self.collectionView.reloadData()
            print("Task items are sorted")
        }
    }
    
}
