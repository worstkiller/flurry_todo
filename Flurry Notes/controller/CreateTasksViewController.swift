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
    
    let headerLabel : UILabel = {
        let headerTitle = UILabel()
        headerTitle.text = "What are you planning?"
        headerTitle.font = ApplicationScheme.shared.typographyScheme.headline6
        headerTitle.textColor = UIColor(displayP3Red: 167/255, green: 171/255, blue: 178/255, alpha: 1.0)
        return headerTitle
    }()
    
    let titleTextField: MDCMultilineTextField = {
        let usernameTextField = MDCMultilineTextField()
        usernameTextField.translatesAutoresizingMaskIntoConstraints = false
        usernameTextField.clearButtonMode = .unlessEditing;
        usernameTextField.minimumLines = 6
        return usernameTextField
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
        
        self.view.addSubview(headerLabel)
        self.headerLabel.snp.makeConstraints{make -> Void in
            make.top.equalTo(self.navigationBar.snp.bottom).offset(40)
            make.left.equalToSuperview().offset(40)
            make.right.equalToSuperview()
        }
        
        self.view.addSubview(titleTextField)
        self.titleTextField.snp.makeConstraints{make-> Void in
            make.top.equalTo(self.headerLabel.snp.bottom)
            make.leading.equalToSuperview().offset(40)
            make.width.equalTo(330)
            make.rightMargin.equalTo(40)
            make.trailing.lessThanOrEqualToSuperview()
            make.height.lessThanOrEqualTo(400)
        }
       
    }

    @objc func backPressed(sender:Any?){
        self.dismiss(animated: true)
        print("back pressed details")
    }

}
