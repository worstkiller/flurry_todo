//
//  BaseViewController.swift
//  Flurry Notes
//
//  Created by Vikas on 04/08/19.
//  Copyright © 2019 Vikas. All rights reserved.
//

import UIKit
import MaterialComponents
import SnapKit

class BaseViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //button setup
        let plusImage = UIImage(named: "plus")?.withRenderingMode(.alwaysTemplate)
        let button = MDCFloatingButton()
        button.setImage(plusImage, for: .normal)
        MDCFloatingButtonColorThemer.applySemanticColorScheme(ApplicationScheme.shared.colorScheme, to: button)
        button.setImageTintColor(.white, for: .normal)
        button.tintColorDidChange()
        
        //adding views to parent
         assembleViews(button)
    }
    
    func assembleViews(_ button: MDCFloatingButton){
        view.addSubview(button)
        button.snp.makeConstraints { (make) -> Void in
            make.size.width.height.equalTo(70)
            make.bottom.right.equalTo(self.view)
            make.bottom.equalTo(view.snp.bottom).offset(-40)
            make.right.equalTo(view.snp.right).offset(-40)
        }
    }

}
