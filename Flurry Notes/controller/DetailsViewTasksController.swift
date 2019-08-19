//
//  DetailsViewTasksControllerCollectionViewCell.swift
//  Flurry Notes
//
//  Created by Vikas on 15/08/19.
//  Copyright © 2019 Vikas. All rights reserved.
//

import UIKit

class DetailsViewTasksController: UICollectionViewController{
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func collectionView(_ collectionView: UICollectionView,
                                 numberOfItemsInSection section: Int) -> Int {
        let count = 3
        return count
    }
    
    override func collectionView(_ collectionView: UICollectionView,
                                 cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = self.collectionView?.dequeueReusableCell(withReuseIdentifier: "TasksCell",
                                                            for: indexPath) as! TasksCell
        cell.title.text = "Call Max"
        cell.dateTime.text = "20:15 April 29"
        cell.isCompleted.boxType = .square
        return cell
    }
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
    }
    
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        if let sectionHeader = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "TasksHeaderCell", for: indexPath) as? TasksHeaderCell{
            if indexPath.row%2==0 {
                sectionHeader.headerLabel.text = "Done"
            }else{
                sectionHeader.headerLabel.text = "Today"
            }
            print("index row is \(indexPath.row)")
            return sectionHeader
        }
        return UICollectionReusableView()
    }
    
}
