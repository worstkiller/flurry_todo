//
//  Catalog.swift
//  Flurry Notes
//
//  Created by Vikas on 06/08/19.
//  Copyright © 2019 Vikas. All rights reserved.
//

import UIKit

class Product: NSObject {
    public private(set) var imageName: String
    public private(set) var productName: String
    public private(set) var price: String
    public private(set) var category: String
    public private(set) var isFeatured: Bool
    
    required init(imageName: String, productName: String, price: String, category: String, isFeatured: Bool) {
        self.imageName = imageName
        self.productName = productName
        self.price = price
        self.category = category
        self.isFeatured = isFeatured
        super.init()
    }
}

class Catalog: NSObject {
    // Notification that gets posted when categoryFilter is changed
    public static let CatalogFilterDidChangeNotification: Notification.Name =
        Notification.Name(rawValue: "CatalogFilterDidChangeNotification")
    
    private static let products = [
        Product(imageName: "document", productName: "All", price: "12 Tasks", category: "Accessories", isFeatured:true),
        Product(imageName: "document", productName: "Work", price: "1 Tasks", category: "Accessories", isFeatured:true),
        Product(imageName: "document", productName: "Music", price: "120 Tasks", category: "Accessories", isFeatured:false),
        Product(imageName: "document", productName: "Travel", price: "98 Tasks", category: "Accessories", isFeatured:true),
        Product(imageName: "document", productName: "Study", price: "34 Tasks", category: "Accessories", isFeatured:false),
        Product(imageName: "document", productName: "Home", price: "90 Tasks", category: "Accessories", isFeatured:false),
         Product(imageName: "document", productName: "Drawing", price: "55 Tasks", category: "Accessories", isFeatured:false),
          Product(imageName: "document", productName: "Shopping", price: "89 Tasks", category: "Accessories", isFeatured:false),
    ]
    
    private static var filteredProducts: [Product] = products
    
    static var count: Int {
        return Catalog.filteredProducts.count
    }
    
    public static func productAtIndex(index: Int) -> Product {
        return Catalog.filteredProducts[index]
    }
    
    static var categoryFilter: String = "" {
        didSet(newFilter) {
            self.applyFilter()
            NotificationCenter.default.post(name: CatalogFilterDidChangeNotification, object: nil)
        }
    }
    
    class func applyFilter() {
        self.filteredProducts.removeAll()
        for product in self.products {
            if (self.categoryFilter == "" || self.categoryFilter == "Featured") && product.isFeatured {
                self.filteredProducts.append(product)
            } else if product.category == self.categoryFilter {
                self.filteredProducts.append(product)
            }
        }
    }
}

