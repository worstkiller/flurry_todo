//
//  CategoryCell.swift
//  Flurry Notes
//
//  Created by Vikas on 09/09/19.
//  Copyright © 2019 Vikas. All rights reserved.
//

import Foundation
import UIKit
import MaterialComponents

//cell for showing the category row
class CategoryCell: MDCCardCollectionCell  {
    
    @IBOutlet weak var titleCategory : UILabel!
    @IBOutlet weak var catImage : UIImageView!
    
    private var categoryProtocol : CategoryCellSelectionProtocol?
    internal var indexPath : IndexPath?
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func setProtocolListener(indexPath: IndexPath, categoryProtocol: CategoryCellSelectionProtocol){
        self.indexPath = indexPath
        self.categoryProtocol = categoryProtocol
    }
    
    func setCellClickListener(){
        let gestureRecoTap = UITapGestureRecognizer(target: self, action: #selector(onClickCell(sender:)))
        self.contentView.addGestureRecognizer(gestureRecoTap)
    }
    
    @objc func onClickCell(sender: Any?){
        categoryProtocol?.onCategoryClick(rowIndex: indexPath!)
        print("Category cell clicked")
    }
}
