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
   
    //pass a raw image and get resized image to desired size
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
    
    /*get back date in format EEEE
     ex MONDAY
     */
    static func getFormattedDay(dateTime: Int64)throws ->String {
        let date = Date(timeIntervalSince1970: TimeInterval(dateTime))
        let dateFormatterGet = DateFormatter()
        dateFormatterGet.dateFormat = "EEEE"
        return dateFormatterGet.string(from: date)
    }
    
    //get a date object from epoch Int64
    static func getDateFromEpoch(epoch: Int64)->Date{
        return Date(timeIntervalSince1970: TimeInterval(epoch))
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

//extension for getting formatted tasks according to priorities in details task view
extension DetailsViewTasksController: TaskProtocol{
    
    func getAllFormattedTasks(repository: Repository, nsCategory: NSCategory, completion: @escaping ([TaskHeaderModel]) -> Void) {

        let allTasks = self.repository.getAllTasksFor(nsCategory: NSCategory.getNSCategoryFrom(rawValue: self.categoryResult?.title ?? NSCategoryEntity.TITLTE))
        
        //moving on to background thread loading of tasks from Core Data
        DispatchQueue.global(qos: .background).async {
            print("In background thread")
            
            var taskHeaderModel = [TaskHeaderModel]()
            
            let today  = Date()
            let calendarToday = Calendar.current
            
            var headerSet = Set<TaskHeaderModel.HEADER>()
            var todayArray = [TaskResult]()
            var upcomingArray = [TaskResult]()
            var lateArray = [TaskResult]()
            var doneArray = [TaskResult]()
            
            for task in allTasks {
                let taskDate = TaskUtilties.getDateFromEpoch(epoch: task.date)
                if task.isCompleted {
                    doneArray.append(task)
                    headerSet.insert(TaskHeaderModel.HEADER.Done)
                }else if  calendarToday.isDateInToday(taskDate) {
                    todayArray.append(task)
                    headerSet.insert(TaskHeaderModel.HEADER.Today)
                }else if(today < taskDate){
                    upcomingArray.append(task)
                    headerSet.insert(TaskHeaderModel.HEADER.Upcoming)
                }else {
                    lateArray.append(task)
                    headerSet.insert(TaskHeaderModel.HEADER.Late)
                }
            }
            
           let headerArray = Array(headerSet).sorted()
            
            for item in headerArray{
                var array = [TaskResult]()
                switch item{
                case .Done:
                    array = doneArray
                case .Late:
                    array = lateArray
                case .Today:
                    array = todayArray
                case .Upcoming:
                    array = upcomingArray
                }
                taskHeaderModel.append(TaskHeaderModel.init(header: item.rawValue, items: array))
            }
            
            //moving data to ui thread
            DispatchQueue.main.async {
                completion(taskHeaderModel)
                print("dispatched to main")
            }
            
        }
    }
}

