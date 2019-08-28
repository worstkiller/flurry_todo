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
    
    var repository = Repository()
    
    let errorView : UIView = {
        TaskUtilties.getErrorView()
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //button setup
        let plusImage = UIImage(named: "plus")?.withRenderingMode(.alwaysTemplate)
        let button = MDCFloatingButton()
        button.setImage(plusImage, for: .normal)
        MDCFloatingButtonColorThemer.applySemanticColorScheme(ApplicationScheme.shared.colorScheme, to: button)
        button.setImageTintColor(.white, for: .normal)
        button.tintColorDidChange()
        button.addTarget(self, action: #selector(openCreateTaskController(sender:)),for: .touchUpInside)
        
        //adding views to parent
         assembleViews(button)
        
        checkIfTasksAreEmpty()
    }
    
    private func checkIfTasksAreEmpty(){
        if !repository.hasTaskItems() {
            self.view.addSubview(errorView)
            self.errorView.snp.makeConstraints{make -> Void in
                make.centerX.equalTo(self.view)
                make.centerY.equalTo(self.view).offset(60)
                make.width.height.equalTo(300)
            }
        }
    }
    
    //open create tasks controller
    @objc func openCreateTaskController(sender: Any?){
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let newViewController = storyBoard.instantiateViewController(withIdentifier: "CreateTasksViewController")
        self.present(newViewController, animated: true,completion: nil)
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
