//
//  TasksCell.swift
//  Flurry Notes
//
//  Created by Vikas on 15/08/19.
//  Copyright © 2019 Vikas. All rights reserved.
//

import UIKit
import MaterialComponents
import SnapKit
import BEMCheckBox

class TasksCell: MDCCardCollectionCell{
    
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var dateTime: UILabel!
    @IBOutlet weak var isCompleted: BEMCheckBox!
    
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
