//
//  ApplicationScheme.swift
//  Flurry Notes
//
//  Created by Vikas on 05/08/19.
//  Copyright © 2019 Vikas. All rights reserved.
//

import Foundation

import MaterialComponents

class ApplicationScheme: NSObject {
    
    private static var singleton = ApplicationScheme()
    
    static var shared: ApplicationScheme {
        return singleton
    }
    
    override init() {
        self.buttonScheme.colorScheme = self.colorScheme
        self.buttonScheme.typographyScheme = self.typographyScheme
        super.init()
    }
    
    public let buttonScheme = MDCButtonScheme()
    
    public let colorScheme: MDCColorScheming = {
        let scheme = MDCSemanticColorScheme(defaults: .material201804)
        scheme.primaryColor =
            UIColor(red: 85.0/255.0, green: 132.0/255.0, blue: 253.0/255.0, alpha: 1.0)
        scheme.primaryColorVariant =
            UIColor(red: 85.0/255.0, green: 132.0/255.0, blue: 253.0/255.0, alpha: 1.0)
        scheme.onPrimaryColor =
            UIColor(red: 68.0/255.0, green: 44.0/255.0, blue: 46.0/255.0, alpha: 1.0)
        scheme.secondaryColor =
            UIColor(red: 255.0/255.0, green: 255.0/255.0, blue: 255.0/255.0, alpha: 1.0)
        scheme.onSecondaryColor =
            UIColor(red: 68.0/255.0, green: 44.0/255.0, blue: 46.0/255.0, alpha: 1.0)
        scheme.surfaceColor =
            UIColor(red: 248/255.0, green: 248/255.0, blue: 248/255.0, alpha: 1.0)
        scheme.onSurfaceColor =
            UIColor(red: 248/255.0, green: 248/255.0, blue: 248/255.0, alpha: 1.0)
        scheme.backgroundColor =
            UIColor(red: 248/255.0, green: 248/255.0, blue: 248/255.0, alpha: 1.0)
        scheme.onBackgroundColor =
            UIColor(red: 248/255.0, green: 248/255.0, blue: 248/255.0, alpha: 1.0)
        scheme.errorColor =
            UIColor(red: 255.0/255.0, green: 137.0/255.0, blue: 168.0/255.0, alpha: 1.0)
        return scheme
    }()
    
    public let typographyScheme: MDCTypographyScheming = {
        let scheme = MDCTypographyScheme()
        let fontName = "Rubik"
        scheme.headline5 = UIFont(name: fontName, size: 24)!
        scheme.headline6 = UIFont(name: fontName, size: 20)!
        scheme.subtitle1 = UIFont(name: fontName, size: 16)!
        scheme.button = UIFont(name: fontName, size: 14)!
        return scheme
    }()
    
    public let shapeScheme: MDCShapeScheming = {
        let scheme = MDCShapeScheme()
        scheme.largeComponentShape = MDCShapeCategory(cornersWith: .cut, andSize: 20)
        return scheme
    }()
}
