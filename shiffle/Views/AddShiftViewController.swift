//
//  AddShiftViewController.swift
//  shiffle
//
//  Created by Minh Hang Chu on 2020-11-23.
//

import UIKit
import FirebaseFirestore

class AddShiftViewController: UIViewController {

    
    @IBOutlet weak var startTimeInput: UITextField!
    @IBOutlet weak var endTimeInput: UITextField!
    @IBOutlet weak var nameInput: UITextField!
    
    var db:Firestore!
    var startTimePicker: UIDatePicker!
    var endTimePicker: UIDatePicker!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        startTimeInput.layer.cornerRadius = 25;
        endTimeInput.layer.cornerRadius = 25;
        nameInput.layer.cornerRadius = 25;
        db = Firestore.firestore()
        setupTimePicker()
        setupEndTimePicker()
    }
    
    func setupTimePicker() {
        self.startTimePicker = UIDatePicker.init(frame: CGRect(x: 0, y: 0, width: self.view.bounds.width, height: 200))
        startTimePicker.datePickerMode = .time
        startTimePicker.addTarget(self, action: #selector(self.timeChanged), for: .allEvents)
        
        if #available(iOS 13.4, *) {
            startTimePicker.preferredDatePickerStyle = .wheels
        }
        
        self.startTimeInput.inputView = startTimePicker
        
        let toolBar: UIToolbar = UIToolbar.init(frame: CGRect(x: 0, y: 0, width: self.view.bounds.width, height: 44))
        
        let spaceButton:UIBarButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
        
        let doneButton:UIBarButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.done, target: self, action: #selector(self.tapOnDoneBut))
        
        toolBar.setItems([spaceButton, doneButton], animated: true)
        
        self.startTimeInput.inputAccessoryView = toolBar
        
    }
    
    @objc func timeChanged() {
        let timeFormat = DateFormatter()
        timeFormat.dateFormat = "HH:mm"
        self.startTimeInput.text = timeFormat.string(from: startTimePicker.date)
    }
    
    @objc func tapOnDoneBut() {
        startTimeInput.resignFirstResponder()
    }
    
    
    func setupEndTimePicker() {
        self.endTimePicker = UIDatePicker.init(frame: CGRect(x: 0, y: 0, width: self.view.bounds.width, height: 200))
        endTimePicker.datePickerMode = .time
        endTimePicker.addTarget(self, action: #selector(self.endtimeChanged), for: .allEvents)
        
        if #available(iOS 13.4, *) {
            endTimePicker.preferredDatePickerStyle = .wheels
        }
        
        self.endTimeInput.inputView = endTimePicker
        
        let toolBar: UIToolbar = UIToolbar.init(frame: CGRect(x: 0, y: 0, width: self.view.bounds.width, height: 44))
        
        let spaceButton:UIBarButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
        
        let doneButton:UIBarButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.done, target: self, action: #selector(self.tapOnDoneBut2))
        
        toolBar.setItems([spaceButton, doneButton], animated: true)
        
        self.endTimeInput.inputAccessoryView = toolBar
        
    }
    
    @objc func endtimeChanged() {
        let timeFormat = DateFormatter()
        timeFormat.dateFormat = "HH:mm"
        self.endTimeInput.text = timeFormat.string(from: endTimePicker.date)
    }
    
    @objc func tapOnDoneBut2() {
        endTimeInput.resignFirstResponder()
    }
    
    
    @IBAction func backToMain(_ sender: Any) {
        presentingViewController?.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func addShift(_ sender: Any) {
        addNewShift()
        presentingViewController?.dismiss(animated: true, completion: nil)
    }
    
    func addNewShift(){
        if let inputStartTime = self.startTimeInput.text, let inputEndTime = self.endTimeInput.text , let inputName = self.nameInput.text {
            let newSchedule = Schedule(day:selectedDate.selectedDate, startTime: inputStartTime, endTime: inputEndTime, name: inputName)
            self.db.collection("schedules").addDocument(data: newSchedule.dictionary){
                error in
                    if let error = error {
                        print("\(error.localizedDescription)")
                    } else {
                        print("Document added")
                    }
            }
            
        }        
    }
    
    
}
