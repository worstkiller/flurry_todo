//
//  DetailsViewTasksControllerCollectionViewCell.swift
//  Flurry Notes
//
//  Created by Vikas on 15/08/19.
//  Copyright © 2019 Vikas. All rights reserved.
//

import UIKit

class DetailsViewTasksController: UICollectionViewController {
    
    
    override func viewDidLoad() {
        
    }
    
    override func collectionView(_ collectionView: UICollectionView,
                                 numberOfItemsInSection section: Int) -> Int {
        let count = 2
        return count
    }
    
    override func collectionView(_ collectionView: UICollectionView,
                                 cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = self.collectionView?.dequeueReusableCell(withReuseIdentifier: "TasksCell",
                                                            for: indexPath) as! TasksCell
        return cell
    }
}
