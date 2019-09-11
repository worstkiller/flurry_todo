//
//  CategoryCell.swift
//  Flurry Notes
//
//  Created by Vikas on 09/09/19.
//  Copyright © 2019 Vikas. All rights reserved.
//

import Foundation
import UIKit

//cell for showing the category row
class CategoryCell: UICollectionViewCell {
    
    @IBOutlet weak var titleCategory : UILabel!
    @IBOutlet weak var catImage : UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
}
