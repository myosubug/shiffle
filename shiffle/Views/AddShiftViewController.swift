//
//  AddShiftViewController.swift
//  shiffle
//
//  Created by Minh Hang Chu on 2020-11-23.
//

import UIKit
import FirebaseDatabase

class AddShiftViewController: UIViewController {

    @IBOutlet weak var startTimeInput: UITextField!
    
    @IBOutlet weak var endTimeInput: UITextField!
    
    @IBOutlet weak var dateInput: UITextField!
    
    var startTimePicker: UIDatePicker!
    var endTimePicker: UIDatePicker!
    var datePicker: UIDatePicker!
    
    var refSchedules:DatabaseReference?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTimePicker()
        setupEndTimePicker()
        setupDatePicker()
       
                // Do any additional setup after loading the view.
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
    
    
    func setupDatePicker() {
        self.datePicker = UIDatePicker.init(frame: CGRect(x: 0, y: 0, width: self.view.bounds.width, height: 200))
        datePicker.datePickerMode = .date
        datePicker.addTarget(self, action: #selector(self.dateChanged), for: .allEvents)
        
        if #available(iOS 13.4, *) {
            datePicker.preferredDatePickerStyle = .wheels
        }
        
        self.dateInput.inputView = datePicker
        
        let toolBar: UIToolbar = UIToolbar.init(frame: CGRect(x: 0, y: 0, width: self.view.bounds.width, height: 44))
        
        let spaceButton:UIBarButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
        
        let doneButton:UIBarButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.done, target: self, action: #selector(self.tapOnDoneButDate))
        
        toolBar.setItems([spaceButton, doneButton], animated: true)
        
        self.dateInput.inputAccessoryView = toolBar
        
    }
    
    @objc func dateChanged() {
        let timeFormat = DateFormatter()
        timeFormat.dateFormat = "MM/dd/yyyy"
        self.dateInput.text = timeFormat.string(from: datePicker.date)
    }
    
    @objc func tapOnDoneButDate() {
        dateInput.resignFirstResponder()
    }
    
    
    @IBAction func backToMain(_ sender: Any) {
        presentingViewController?.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func addShift(_ sender: Any) {
        addNewShift()
        presentingViewController?.dismiss(animated: true, completion: nil)
    }
    
    func addNewShift(){
    
 /*       if let inputTime = composeAlert.textFields?.first?.text, let inputName = composeAlert.textFields?.last?.text {
            let newSchedule = Schedule(day:self.dstring, time: inputTime, name: inputName)
            self.db.collection("schedules").addDocument(data: newSchedule.dictionary){
                error in
                    if let error = error {
                        print("\(error.localizedDescription)")
                    } else {
                        print("Document added")
                    }
            }
            
        } */
        
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
