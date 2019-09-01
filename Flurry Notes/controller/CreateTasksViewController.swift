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

    var repository = Repository()
    
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
        usernameTextField.minimumLines = 8
        return usernameTextField
    }()
    
    let alarmImage : UIImageView = {
        let image = UIImage(named: "alarm")
        let imageView = UIImageView(image: image)
        return imageView
    }()
    
    let alarmLabel : UILabel = {
        let font = ApplicationScheme.shared.typographyScheme.headline6
       let uiLabel = UILabel()
        uiLabel.text = "20:14  April 24"
        uiLabel.font = font
        return uiLabel
    }()
    
    let categoryImage : UIImageView = {
        let image = UIImage(named: "tag")
        let imageView = UIImageView(image: image)
        return imageView
    }()
    
    let categoryLabel : UILabel = {
        let font = ApplicationScheme.shared.typographyScheme.headline6
        let uiLabel = UILabel()
        uiLabel.text = "Category"
        uiLabel.font = font
        return uiLabel
    }()
    
    // Buttons
    let createButton: MDCButton = {
        let button = MDCButton()
        button.setBackgroundColor(ApplicationScheme.shared.colorScheme.primaryColor)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Create", for: .normal)
        button.addTarget(self, action: #selector(didTapCreate(sender:)), for: .touchUpInside)
        return button
    }()
    
    //will get called when create button clicked, save user data here
    @objc func didTapCreate(sender: Any?){
        let errorString = "Sorry something went wrong while saving data"
        let successString = "A new task has been created successfully"
        guard let titleText = titleTextField.text else{
            TaskUtilties.showToast(msg: errorString)
            return
        }
        
        if repository.saveTask(title: titleText, tag: NSCategory.Work) {
            TaskUtilties.showToast(msg: successString)
        }else{
            TaskUtilties.showToast(msg: errorString)
        }
    }
    
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
        
        self.view.addSubview(alarmImage)
        self.alarmImage.snp.makeConstraints{make -> Void in
            make.width.equalTo(24)
            make.height.equalTo(24)
            make.left.equalToSuperview().offset(40)
            make.top.equalTo(self.titleTextField.snp.bottom).offset(40)
        }
        
        self.view.addSubview(alarmLabel)
        self.alarmLabel.snp.makeConstraints{make -> Void in
            make.top.equalTo(self.titleTextField.snp.bottom).offset(40)
            make.left.equalTo(self.alarmImage.snp.left).offset(40)
            make.right.equalToSuperview()
        }
       
        self.view.addSubview(categoryImage)
        self.categoryImage.snp.makeConstraints{make -> Void in
            make.width.equalTo(24)
            make.height.equalTo(24)
            make.left.equalToSuperview().offset(40)
            make.top.equalTo(self.alarmLabel.snp.bottom).offset(40)
        }
        
        self.view.addSubview(categoryLabel)
        self.categoryLabel.snp.makeConstraints{make -> Void in
            make.top.equalTo(self.alarmLabel.snp.bottom).offset(40)
            make.left.equalTo(self.categoryImage.snp.left).offset(40)
            make.right.equalToSuperview()
        }
        
        self.view.addSubview(createButton)
        self.createButton.snp.makeConstraints{make -> Void in
            make.left.equalToSuperview()
            make.height.equalTo(54)
            make.bottom.equalTo(self.view.safeAreaLayoutGuide)
            make.right.equalToSuperview()
        }
        
    }

    @objc func backPressed(sender:Any?){
        self.dismiss(animated: true)
        print("back pressed details")
    }

}
