//
//  DetailsViewController.swift
//  Flurry Notes
//
//  Created by Vikas on 10/08/19.
//  Copyright © 2019 Vikas. All rights reserved.
//

import UIKit
import MaterialComponents.MaterialNavigationBar
import SnapKit

class DetailsViewController: UIViewController {
    

    
    let navigationBar : MDCNavigationBar = {
        let appBar = MDCNavigationBar()
        appBar.backgroundColor = ApplicationScheme.shared.colorScheme.primaryColor
        
        //back button
        let menuItemImage = UIImage(named: "back")
        let templatedMenuItemImage = menuItemImage?.withRenderingMode(.alwaysOriginal)
        let menuItem = UIBarButtonItem(image: templatedMenuItemImage,
                                       style: .plain,
                                       target: self,
                                       action: #selector(backPressed(sender:)))
        appBar.leftBarButtonItem = menuItem
        
        //more button
        let menuItemImageMore = UIImage(named: "more")
        let templatedMenuItemMore = menuItemImageMore?.withRenderingMode(.alwaysOriginal)
        let menuItemMore = UIBarButtonItem(image: templatedMenuItemMore,
                                       style: .plain,
                                       target: self,
                                       action: #selector(backPressed(sender:)))
        appBar.rightBarButtonItem = menuItemMore
        return appBar
    }()
    
    //scroll view for widgets container
    let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false;
        scrollView.backgroundColor = ApplicationScheme.shared.colorScheme.primaryColor
        scrollView.layoutMargins = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
        return scrollView
    }()
    
    //category image
    let imageCategoryView: UIImageView = {
        let img = UIImage(named: "document")?.withInset(UIEdgeInsets(top: 40, left: 40, bottom: 40, right: 40))
        let category = UIImageView(image: img)
        category.autoresizingMask = [.flexibleRightMargin, .flexibleLeftMargin, .flexibleBottomMargin]
        category.contentMode = UIView.ContentMode.scaleAspectFit
        category.layer.backgroundColor = ApplicationScheme.shared.colorScheme.backgroundColor.cgColor
        category.clipsToBounds = true
        category.layer.cornerRadius = 35
        return category
    }()
    
    //category label
    let titleLabel: UILabel = {
        let font = ApplicationScheme.shared.typographyScheme.headline3
        let titleLabel = UILabel()
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.text = "All"
        titleLabel.sizeToFit()
        titleLabel.textColor=ApplicationScheme.shared.colorScheme.backgroundColor
        titleLabel.adjustsFontSizeToFitWidth = true
        titleLabel.adjustsFontForContentSizeCategory = true
        titleLabel.font = font
        return titleLabel
    }()
    
    //category label caption for no. of tasks
    let captionLabel: UILabel = {
        let font = ApplicationScheme.shared.typographyScheme.headline5
        let titleLabel = UILabel()
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.text = "\(23) Tasks"
        titleLabel.sizeToFit()
        titleLabel.textColor=ApplicationScheme.shared.colorScheme.backgroundColor
        titleLabel.adjustsFontSizeToFitWidth = true
        titleLabel.adjustsFontForContentSizeCategory = true
        titleLabel.font = font
        return titleLabel
    }()
    
    //tasks background image
    let taskBackground : UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "tasks_background"))
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        assembleViews()
    }
    
    private func assembleViews(){

        //navigation bar
        self.view.addSubview(navigationBar)
        self.navigationBar.snp.makeConstraints{ make -> Void in
            make.top.equalTo(self.view.safeAreaLayoutGuide)
            make.left.equalTo(self.view.safeAreaLayoutGuide)
            make.right.equalTo(self.view.safeAreaLayoutGuide)
        }
        
        //category image view
        self.view.addSubview(imageCategoryView)
        self.imageCategoryView.snp.makeConstraints{make->Void in
            make.top.equalTo(self.navigationBar.snp.bottom).offset(50)
            make.leftMargin.equalTo(40)
            make.height.equalTo(70)
            make.width.equalTo(70)
        }
        
        //category label
        self.view.addSubview(titleLabel)
        self.titleLabel.snp.makeConstraints{make->Void in
            make.top.equalTo(self.imageCategoryView.snp.bottom).offset(30)
            make.leftMargin.equalTo(40)
        }
        
        //category caption label
        self.view.addSubview(captionLabel)
        self.captionLabel.snp.makeConstraints{make->Void in
            make.top.equalTo(self.titleLabel.snp.bottom)
            make.leftMargin.equalTo(40)
        }
        
        //adding the background for tasks
        self.view.addSubview(taskBackground)
        self.taskBackground.snp.makeConstraints{make -> Void in
            make.top.equalTo(captionLabel).offset(60)
            make.left.equalToSuperview()
            make.right.equalToSuperview()
        }
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    @objc func backPressed(sender:Any?){
        self.dismiss(animated: true)
        print("back pressed details")
    }

}

/**
extension functions
 **/
extension UIImage {

    func withInset(_ insets: UIEdgeInsets) -> UIImage? {
        let cgSize = CGSize(width: self.size.width + insets.left * self.scale + insets.right * self.scale,
                            height: self.size.height + insets.top * self.scale + insets.bottom * self.scale)
        
        UIGraphicsBeginImageContextWithOptions(cgSize, false, self.scale)
        defer { UIGraphicsEndImageContext() }
        
        let origin = CGPoint(x: insets.left * self.scale, y: insets.top * self.scale)
        self.draw(at: origin)
        
        return UIGraphicsGetImageFromCurrentImageContext()?.withRenderingMode(self.renderingMode)
    }
}
