//
//  ViewController.swift
//  Flurry Notes
//
//  Created by Vikas on 24/07/19.
//  Copyright © 2019 Vikas. All rights reserved.
//

import UIKit

import MaterialComponents

class HomeViewController: UICollectionViewController {
    var shouldDisplayLogin = false
    var appBarViewController = MDCAppBarViewController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.tintColor = .black
        self.view.backgroundColor = .white
        
        self.collectionView?.backgroundColor = .white
        
        // AppBar Init
        self.addChild(self.appBarViewController)
        self.view.addSubview(self.appBarViewController.view)
        self.appBarViewController.didMove(toParent: self)
        
        // Set the tracking scroll view.
        self.appBarViewController.headerView.trackingScrollView = self.collectionView
        
        // Setup Navigation Items
        let menuItemImage = UIImage(named: "navigation")
        let templatedMenuItemImage = menuItemImage?.withRenderingMode(.alwaysTemplate)
        let menuItem = UIBarButtonItem(image: templatedMenuItemImage,
                                       style: .plain,
                                       target: self,
                                       action: #selector(menuItemTapped(sender:)))
        self.navigationItem.leftBarButtonItem = menuItem
        
        // TODO: Theme our interface with our colors
        self.view.backgroundColor = ApplicationScheme.shared.colorScheme
            .surfaceColor
        self.collectionView?.backgroundColor = ApplicationScheme.shared.colorScheme
            .surfaceColor
        MDCAppBarColorThemer.applyColorScheme(ApplicationScheme.shared.colorScheme
            , to:self.appBarViewController)
        // TODO: Theme our interface with our typography
        MDCAppBarTypographyThemer.applyTypographyScheme(ApplicationScheme.shared.typographyScheme
            , to: self.appBarViewController)
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
        
        if (self.shouldDisplayLogin) {
            let loginViewController = BaseViewController(nibName: nil, bundle: nil)
            self.present(loginViewController, animated: false, completion: nil)
            self.shouldDisplayLogin = false
        }
    }
    
    //MARK - Methods
    @objc func menuItemTapped(sender: Any) {
//        let loginViewController = LoginViewController(nibName: nil, bundle: nil)
//        self.present(loginViewController, animated: true, completion: nil)
    }
    
//    MARK - UICollectionViewDataSource
    override func collectionView(_ collectionView: UICollectionView,
                                 numberOfItemsInSection section: Int) -> Int {
        let count = Catalog.count
        return count
    }
    
    override func collectionView(_ collectionView: UICollectionView,
                                 cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = self.collectionView?.dequeueReusableCell(withReuseIdentifier: "ProductCell",
                                                            for: indexPath) as! ProductCell
        let product = Catalog.productAtIndex(index: indexPath.row)
        cell.imageView.image = UIImage(named: product.imageName)
        cell.nameLabel.text = product.productName
        cell.priceLabel.text = product.price
        return cell
    }
    
}

//MARK: - UIScrollViewDelegate

// The following four methods must be forwarded to the tracking scroll view in order to implement
// the Flexible Header's behavior.

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
