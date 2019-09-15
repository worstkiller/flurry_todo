//
//  DatePickerViewController.swift
//  Flurry Notes
//
//  Created by Vikas on 14/09/19.
//  Copyright © 2019 Vikas. All rights reserved.
//

import UIKit

class DatePickerViewController: UIViewController {
    
    @IBOutlet weak var datePicker: UIDatePicker?
    @IBOutlet weak var imageClose: UIImageView?
    var datePickerProtocol: DateSelector?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //set click listener
        setClickListener()
        
        //set minimum date requirement
        datePicker?.minimumDate = Date()
    }
    
    private func setClickListener(){
        let tap = UITapGestureRecognizer(target: self, action: #selector(closeDatePicker(_:)))
        imageClose?.addGestureRecognizer(tap)
        imageClose?.isUserInteractionEnabled = true
    }
    
    @IBAction func datePickerChanged(_ sender: Any) {
        print("date picker")
        let dateFormatter = DateFormatter()
        
        dateFormatter.dateStyle = DateFormatter.Style.short
        dateFormatter.timeStyle = DateFormatter.Style.short
        
        datePickerProtocol?.onDateSelected(dateRaw: datePicker?.date)
    }
    
    @objc func closeDatePicker(_ sender: Any){
        print("date picker closed")
        datePickerProtocol?.onDateSelected(dateRaw: datePicker?.date)
        dismiss(animated: true, completion: nil)
    }

}
