//
//  ViewController.swift
//  Flurry Notes
//
//  Created by Vikas on 24/07/19.
//  Copyright © 2019 Vikas. All rights reserved.
//

import UIKit
import MaterialComponents.MaterialNavigationDrawer
import MaterialComponents.MaterialButtons

class ViewController: UIViewController {

    let bottomDrawerViewController = MDCBottomDrawerViewController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let button = MDCButton()
        button.setTitle("Button", for: .normal)
        button.sizeToFit()
        button.addTarget(self, action: #selector(tapped), for: .touchUpInside)
        self.view.addSubview(button)
    }


    @objc func tapped(sender: UIButton?){
        print("Button was tapped!")
    }
    
}

