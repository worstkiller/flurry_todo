//
//  TaskUtilities.swift
//  Flurry Notes
//
//  Created by Vikas on 26/08/19.
//  Copyright © 2019 Vikas. All rights reserved.
//

import Foundation
import MaterialComponents.MaterialSnackbar
import SnapKit

struct TaskUtilties {
    
    //get date and time from epoch
     static func getDateTime() -> Int64 {
        return Date().currentTimeMillis()
    }
    
    //get unique id generator
    static func generateTransactionId(length: Int = 5) -> String {
        var result = ""
        let base62chars = [Character]("0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz")
        let maxBase : UInt32 = 62
        let minBase : UInt16 = 32
        
        for _ in 0..<length {
            let random = Int(arc4random_uniform(UInt32(min(minBase, UInt16(maxBase)))))
            result.append(base62chars[random])
        }
        return result
    }
    
    //show a bottom snackbar message
     static func showToast(msg: String) {
        let message = MDCSnackbarMessage()
        message.text =  msg
        MDCSnackbarManager.show(message)
    }
    
    //get a error view with label and image view
    static func getErrorView()-> UIView{
        let view = UIView()
       
        //error image
        let image = UIImageView(image: UIImage(named: Resources.Images.BOX))
        view.addSubview(image)
        image.snp.makeConstraints{make -> Void in
            make.top.equalToSuperview().offset(40)
            make.centerX.equalToSuperview()
            make.width.equalTo(40)
            make.height.equalTo(40)
        }
        
        //error label
        let errorLabel = UILabel()
        errorLabel.numberOfLines = 3
        errorLabel.textAlignment = .center
        errorLabel.text = "Nothing to show ! \n Click plus button to add one"
        errorLabel.font = ApplicationScheme.shared.typographyScheme.headline6
        errorLabel.textColor = UIColor(displayP3Red: 167/255, green: 171/255, blue: 178/255, alpha: 1.0)

        view.addSubview(errorLabel)
        errorLabel.snp.makeConstraints{make -> Void in
            make.top.equalTo(image.snp.bottom).offset(10)
            make.left.equalToSuperview()
            make.right.equalToSuperview()
        }
        
        return view
    }
    
   static func resizeImage(image: UIImage, newWidth: CGFloat) -> UIImage {
        
        let scale = newWidth / image.size.width
        let newHeight = image.size.height * scale
        UIGraphicsBeginImageContext(CGSize(width: newWidth, height: newHeight))
        image.draw(in: CGRect(x: 0, y: 0, width: newWidth, height: newHeight))
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return newImage!
    }
    
    /*get back date in format HH:mm MMM YYYY
        ex 20:15 April 29
     */
    static func getFormattedDate(dateTime: Int64)throws ->String {
        let date = Date(timeIntervalSince1970: TimeInterval(dateTime))
        let dateFormatterGet = DateFormatter()
        dateFormatterGet.dateFormat = "HH:mm MMM dd"
        return dateFormatterGet.string(from: date)
        
    }
    
}

extension Date {
    func currentTimeMillis() -> Int64 {
        return Int64(self.timeIntervalSince1970 * 1000)
    }
}

extension UIView {
    
    func fadeIn(duration: TimeInterval = 0.5, delay: TimeInterval = 0.0, completion: @escaping ((Bool) -> Void) = {(finished: Bool) -> Void in }) {
        self.alpha = 0.0
        
        UIView.animate(withDuration: duration, delay: delay, options: UIView.AnimationOptions.curveEaseIn, animations: {
            self.isHidden = false
            self.alpha = 1.0
        }, completion: completion)
    }
    
    func fadeOut(duration: TimeInterval = 0.5, delay: TimeInterval = 0.0, completion: @escaping (Bool) -> Void = {(finished: Bool) -> Void in }) {
        self.alpha = 1.0
        
        UIView.animate(withDuration: duration, delay: delay, options: UIView.AnimationOptions.curveEaseIn, animations: {
            self.alpha = 0.0
        }) { (completed) in
            self.isHidden = true
            completion(true)
        }
    }
}
