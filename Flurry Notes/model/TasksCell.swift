//
//  TasksCell.swift
//  Flurry Notes
//
//  Created by Vikas on 15/08/19.
//  Copyright © 2019 Vikas. All rights reserved.
//

import UIKit
import MaterialComponents

class TasksCell: MDCCardCollectionCell{
    
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var dateTime: UILabel!
    
    func configureCell() {
        self.backgroundColor = .white
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
