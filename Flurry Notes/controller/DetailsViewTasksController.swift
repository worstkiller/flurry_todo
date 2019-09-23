//
//  DetailsViewTasksControllerCollectionViewCell.swift
//  Flurry Notes
//
//  Created by Vikas on 15/08/19.
//  Copyright © 2019 Vikas. All rights reserved.
//

import UIKit
import MaterialComponents

class DetailsViewTasksController: UICollectionViewController, TaskCellUpdateProtocol{
    var categoryResult: CategoryResult?
    var repository = Repository()
    var itemsMappedToHeader = [TaskHeaderModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Define Layout here
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        
        //Get device width
        let width = UIScreen.main.bounds.width
        
        //set section inset as per your requirement.
        layout.sectionInset = UIEdgeInsets(top: 0, left: 5, bottom: 0, right: 5)
        
        //set cell item size here
        layout.itemSize = CGSize(width: width, height: 80)
        
        layout.headerReferenceSize = CGSize(width: width-16, height: 50)
    
        //apply defined layout to collectionview
        collectionView!.collectionViewLayout = layout
        
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
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let data = repository.getSingleTaskWithId(id: itemsMappedToHeader[indexPath.section].getTaskResults()[indexPath.row].id)!
        let dialog = MDCAlertController(title: "Mission Details", message: data.title)
        let action = MDCAlertAction(title: "Dismiss"){action -> Void in
            dialog.dismiss(animated: true, completion: nil)
        }
        dialog.addAction(action)
        self.present(dialog, animated: true, completion: nil)
    }
    
    private func getSortedItemsForCategory(category: NSCategory){
        getAllFormattedTasks(repository: repository, nsCategory: category){ data -> Void in
            self.itemsMappedToHeader = data
            self.collectionView.reloadData()
            print("Task items are sorted")
        }
    }
    
}
