//
//  CreateTasksViewController.swift
//  Flurry Notes
//
//  Created by Vikas on 20/08/19.
//  Copyright © 2019 Vikas. All rights reserved.
//

import UIKit
import MaterialComponents
import SnapKit

class CreateTasksViewController: UIViewController {

    
    //navigation view
    let navigationBar : MDCNavigationBar = {
        let appBar = MDCNavigationBar()
        
           //close button
        let menuItemImageMore = UIImage(named: "close")
        let templatedMenuItemMore = menuItemImageMore?.withRenderingMode(.alwaysOriginal)
        let menuItemMore = UIBarButtonItem(image: templatedMenuItemMore,
                                           style: .plain,
                                           target: self,
                                           action: #selector(backPressed(sender:)))
        appBar.rightBarButtonItem = menuItemMore
        appBar.title = "New Task"
        return appBar
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        assembleViews()
    }
    
    func assembleViews(){
        self.view.addSubview(navigationBar)
        self.navigationBar.snp.makeConstraints{ make -> Void in
            make.top.equalTo(self.view.safeAreaLayoutGuide)
            make.left.equalTo(self.view.safeAreaLayoutGuide)
            make.right.equalTo(self.view.safeAreaLayoutGuide)
        }
    }

    @objc func backPressed(sender:Any?){
        self.dismiss(animated: true)
        print("back pressed details")
    }

}
