//
//  ViewController.swift
//  Flurry Notes
//
//  Created by Vikas on 24/07/19.
//  Copyright © 2019 Vikas. All rights reserved.
//

import UIKit
import MaterialComponents.MaterialBottomAppBar
import MaterialComponents.MaterialBottomAppBar_ColorThemer
import MaterialComponents.MaterialColorScheme
import MaterialComponents.MaterialNavigationDrawer
import MaterialComponents.MaterialNavigationDrawer_ColorThemer

class HomeViewController: UICollectionViewController {

    var appBarViewController = MDCAppBarViewController()
    let bottomAppBar = MDCBottomAppBarView()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //this will tint the status bar color to given color
        //like network, time, battery icons
        self.view.tintColor = .black
        self.view?.backgroundColor = .red
        self.collectionView?.backgroundColor = .clear
        
        self.addChild(self.appBarViewController)
        self.view.addSubview(self.appBarViewController.view)
        self.appBarViewController.didMove(toParent: self)
        
        //     Set the tracking scroll view.
        self.appBarViewController.headerView.trackingScrollView = self.collectionView
        
        // Setup Navigation Items
        let menuItemImage = UIImage(named: "MenuItem")
        let templatedMenuItemImage = menuItemImage?.withRenderingMode(.alwaysTemplate)
        let menuItem = UIBarButtonItem(image: templatedMenuItemImage,
                                       style: .plain,
                                       target: self,
                                       action: #selector(menuItemTapped(sender:)))
        self.navigationItem.leftBarButtonItem = menuItem
        
        //color scheme
        MDCAppBarColorThemer.applyColorScheme(ApplicationScheme.shared.colorScheme,
                                              to:self.appBarViewController)
        
        MDCAppBarTypographyThemer.applyTypographyScheme(ApplicationScheme.shared.typographyScheme,
                                                        to: self.appBarViewController)
    }
    
    @objc func menuItemTapped(sender: Any) {
        print("Bottom navigation items clicked")
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        if (self.collectionViewLayout is UICollectionViewFlowLayout) {
            let flowLayout = self.collectionViewLayout as! UICollectionViewFlowLayout
            let HORIZONTAL_SPACING: CGFloat = 8.0
            let itemDimension: CGFloat = (self.view.frame.size.width - 3.0 * HORIZONTAL_SPACING) * 0.5
            let itemSize = CGSize(width: itemDimension, height: itemDimension)
            flowLayout.itemSize = itemSize
        }

    }

}

extension HomeViewController {
    
    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if (scrollView == self.appBarViewController.headerView.trackingScrollView) {
            self.appBarViewController.headerView.trackingScrollDidScroll()
        }
    }
    
    override func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        if (scrollView == self.appBarViewController.headerView.trackingScrollView) {
            self.appBarViewController.headerView.trackingScrollDidEndDecelerating()
        }
    }
    
    override func scrollViewDidEndDragging(_ scrollView: UIScrollView,
                                           willDecelerate decelerate: Bool) {
        let headerView = self.appBarViewController.headerView
        if (scrollView == headerView.trackingScrollView) {
            headerView.trackingScrollDidEndDraggingWillDecelerate(decelerate)
        }
    }
    
    override func scrollViewWillEndDragging(_ scrollView: UIScrollView,
                                            withVelocity velocity: CGPoint,
                                            targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        let headerView = self.appBarViewController.headerView
        if (scrollView == headerView.trackingScrollView) {
            headerView.trackingScrollWillEndDragging(withVelocity: velocity,
                                                     targetContentOffset: targetContentOffset)
        }
}

}
