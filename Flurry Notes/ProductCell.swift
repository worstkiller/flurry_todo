//
//  ProductCell.swift
//  Flurry Notes
//
//  Created by Vikas on 06/08/19.
//  Copyright © 2019 Vikas. All rights reserved.
//

import UIKit

import MaterialComponents

class ProductCell: MDCCardCollectionCell {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    
    func configureCell() {
        self.backgroundColor = .white
        
        //TODO: Set custom font based on our ApplicationScheme and center align text
        self.imageView.contentMode = .scaleAspectFit
        self.nameLabel.font = ApplicationScheme.shared.typographyScheme.subtitle1
        self.priceLabel.font = ApplicationScheme.shared.typographyScheme.subtitle1
        self.nameLabel.textAlignment = .left
        self.priceLabel.textAlignment = .left
        self.nameLabel.font = self.nameLabel.font.withSize(30)
         self.priceLabel.font = self.priceLabel.font.withSize(18)
        //TODO: Set to 0 to disable the curved corners
//        self.cornerRadius = 4
//        self.contentView.layer.cornerRadius = 4
//        self.contentView.layer.masksToBounds = true
//        self.layer.masksToBounds = false
//        self.setShadowElevation(ShadowElevation(rawValue: 0.2), for: .normal)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        configureCell()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        configureCell()
    }
}
