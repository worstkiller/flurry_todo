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
    
    let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false;
        scrollView.backgroundColor = ApplicationScheme.shared.colorScheme.primaryColor
        scrollView.layoutMargins = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
        return scrollView
    }()
    
    let imageCategoryView: UIImageView = {
        let img = UIImage(named: "document")?.withInset(UIEdgeInsets(top: 40, left: 40, bottom: 40, right: 40))
        let category = UIImageView(image: img)
        category.autoresizingMask = [.flexibleRightMargin, .flexibleLeftMargin, .flexibleBottomMargin]
        category.contentMode = UIView.ContentMode.scaleAspectFit
        category.layer.backgroundColor = ApplicationScheme.shared.colorScheme.backgroundColor.cgColor
        category.clipsToBounds = true
        category.layer.cornerRadius = 30
        return category
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        assembleViews()
    }
    
    private func assembleViews(){
        
        //added the scrollview with safe bounds
        view.addSubview(scrollView)
        self.scrollView.snp.makeConstraints{make -> Void in
            make.left.equalToSuperview()
            make.right.equalToSuperview()
            make.top.equalTo(self.view.safeAreaLayoutGuide)
            make.bottom.equalToSuperview()
        }
        //navigation bar
        self.view.addSubview(navigationBar)
        self.navigationBar.snp.makeConstraints{ make -> Void in
            make.top.equalTo(scrollView.snp.top)
            make.left.equalTo(scrollView.snp.left)
            make.right.equalTo(scrollView.snp.right)
        }
        
        //category image view
        self.view.addSubview(imageCategoryView)
        self.imageCategoryView.snp.makeConstraints{make->Void in
            make.top.equalTo(self.navigationBar.snp.bottom).offset(70)
            make.leftMargin.equalTo(40)
            make.height.equalTo(60)
            make.width.equalTo(60)
        }
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
