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

class TasksCell: MDCCardCollectionCell, BEMCheckBoxDelegate {
    
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var dateTime: UILabel!
    @IBOutlet weak var isCompleted: BEMCheckBox!
    
    var calllerProtocol : TaskCellUpdateProtocol?
    var indexPath : IndexPath?
    
    func configureCell() {
        self.backgroundColor = .white
        self.isCompleted.delegate = self
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        configureCell()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        configureCell()
    }
    
    func didTap(_ checkBox: BEMCheckBox) {
        calllerProtocol?.checkBoxUpdated(isChecked: checkBox.on, rowIndex: (indexPath)!)
        print("Checkbox is Tapped")
    }
    
}
