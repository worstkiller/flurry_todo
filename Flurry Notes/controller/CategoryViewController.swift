//
//  CategoryViewController.swift
//  Flurry Notes
//
//  Created by Vikas on 09/09/19.
//  Copyright © 2019 Vikas. All rights reserved.
//

import UIKit

class CategoryViewController: UICollectionViewController {

    var repsository = Repository()
    var items: [CategoryResult]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("Category view controller is called")
        view.backgroundColor = .white
        
        //data loading
        items = repsository.getAllCategory()
    }

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items?.count ?? 0
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CategoryCell", for: indexPath) as! CategoryCell
        cell.titleCategory.text = items?[indexPath.row].title
        cell.catImage.image = UIImage(named: items?[indexPath.row].image ?? Resources.Images.DOCUMENT)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let padding: CGFloat =  50
        let collectionViewSize = collectionView.frame.size.width - padding
        
        return CGSize(width: collectionViewSize/2, height: collectionViewSize/2)
    }

}
