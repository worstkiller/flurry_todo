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
        let backImg = UIImage(named: "back")
        let backButton = UIBarButtonItem(image: backImg!,style: .plain,target: self, action: #selector(backPressed(sender:)))
        appBar.backItem = backButton
        return appBar
    }()
    
    let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false;
        scrollView.backgroundColor = ApplicationScheme.shared.colorScheme.primaryColor
        scrollView.layoutMargins = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
        return scrollView
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
        self.scrollView.addSubview(navigationBar)
        self.navigationBar.snp.makeConstraints{ make -> Void in
            make.top.equalTo(scrollView.snp.top)
            make.left.equalTo(scrollView.snp.left)
            make.right.equalTo(scrollView.snp.right)
        }
    }
    
    @objc func backPressed(sender:Any?){
        print("back pressed")
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
