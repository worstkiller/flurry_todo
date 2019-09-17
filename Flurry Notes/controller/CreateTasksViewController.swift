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

class CreateTasksViewController: UIViewController, CategorySelectionProtocol, DateSelector {

    var repository = Repository()
    var dateSelected: Int64 = TaskUtilties.getDateTime()
    
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
        uiLabel.text = "Select reminder"
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
        uiLabel.text = "Choose category"
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
        let emptyMsg = "Did you forgot to add something?"
        let successString = "A new task has been created successfully"
        guard let titleText = titleTextField.text else{
            TaskUtilties.showToast(msg: errorString)
            return
        }
        
        if titleText.isEmpty {
            TaskUtilties.showToast(msg: emptyMsg)
            return
        }
        
        let taskResult = TaskResult.getInstance(title: titleText, category: categoryLabel.text ?? NSCategory.All.rawValue, date: dateSelected)
        
        if repository.saveTask(taskResult: taskResult) {
            TaskUtilties.showToast(msg: successString)
            AlarmManager.sharedInstance.addAlarm(taskResult: taskResult)
            self.navigationController?.popViewController(animated: true)
        }else{
            TaskUtilties.showToast(msg: errorString)
        }
    }
    
    @objc func onCategoryTap(sender: UITapGestureRecognizer){
        print("Category is selected")
        //view controller for categories
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let newViewController = storyBoard.instantiateViewController(withIdentifier: "CategoryViewController") as! CategoryViewController
        newViewController.categorySelectionProtocol = self
        let bottomSheet = MDCBottomSheetController(contentViewController: newViewController)
        present(bottomSheet, animated: true, completion: nil)
    }
    
    @objc func onReminderTap(sender: UITapGestureRecognizer){
        print("Reminder is selected")
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let newViewController = storyBoard.instantiateViewController(withIdentifier: "DatePickerViewController") as! DatePickerViewController
        newViewController.datePickerProtocol = self
        let bottomSheet = MDCBottomSheetController(contentViewController: newViewController)
        present(bottomSheet, animated: true, completion: nil)
    }
    
    func onCategoryClick(categoryResult: CategoryResult){
        categoryLabel.text = categoryResult.title
        categoryLabel.textColor = ApplicationScheme.shared.colorScheme.primaryColor
        print("Category callback received")
    }
    
    func onDateSelected(dateRaw: Date?) {
        guard let date = dateRaw?.timeIntervalSince1970 else {
            return
        }
        alarmLabel.text = try? TaskUtilties.getFormattedDate(dateTime: Int64(date))
        alarmLabel.textColor = ApplicationScheme.shared.colorScheme.primaryColor
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        assembleViews()
        addClickListener()
    }
    
    func addClickListener(){
        //for categories
        let tapCat = UITapGestureRecognizer(target: self, action: #selector(onCategoryTap))
        categoryLabel.isUserInteractionEnabled = true
        categoryLabel.addGestureRecognizer(tapCat)
        
        //for reminders
        let tapRem = UITapGestureRecognizer(target: self, action: #selector(onReminderTap))
        alarmLabel.isUserInteractionEnabled = true
        alarmLabel.addGestureRecognizer(tapRem)
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
