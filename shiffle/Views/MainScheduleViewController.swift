//
//  MainScheduleViewController.swift
//  shiffle
//
//  Created by Minh Hang Chu on 2020-10-27.
//

import UIKit
import FirebaseFirestore
import FSCalendar

class MainScheduleViewController: UIViewController, FSCalendarDelegate, UITableViewDataSource {
    
    var db:Firestore!
    @IBOutlet var calendar: FSCalendar!
    @IBOutlet var table: UITableView!
    var daySchedule = [Schedule]()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        db = Firestore.firestore()
        calendar.delegate = self
        table.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        table.dataSource = self
        loadSchedule()
        
    }
    
    
    func calendar(_ calendar: FSCalendar, didDeselect date: Date, at monthPosition: FSCalendarMonthPosition) {
        let format = DateFormatter()
        format.dateFormat = "YYYYMMdd"
        let dstring = format.string(from: date)
        print("\(dstring)")
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return daySchedule.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let day = daySchedule[indexPath.row]
        
        cell.textLabel?.text = "\(day.time): \(day.name)"
        return cell
    }
    
    @IBAction func addSchedule(_ sender: Any) {
        let composeAlert = UIAlertController(title: "Add Schedule", message: "Enter your schedule her ", preferredStyle: .alert)
        
        composeAlert.addTextField{ (textFied:UITextField) in
            textFied.placeholder = "Working time"
        }
        
        composeAlert.addTextField{ (textFied:UITextField) in
            textFied.placeholder = "Your name"
        }
        
        composeAlert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        
        composeAlert.addAction(UIAlertAction(title: "Submit", style: .default, handler: {
            (action:UIAlertAction) in
            if let inputTime = composeAlert.textFields?.first?.text, let inputName = composeAlert.textFields?.last?.text {
                let newSchedule = Schedule(time: inputTime, name: inputName)
                var ref:DocumentReference? = nil
                ref = self.db.collection("schedules").addDocument(data: newSchedule.dictionary) {
                    error in
                        if let error = error {
                            print("\(error.localizedDescription)")
                        } else {
                            print("Document added with ID: \(ref!.documentID)")
                        }
                }
                
            }
        }))
        
        self.present(composeAlert, animated: true, completion: nil)
    }
    
    func loadSchedule(){
        db.collection("schedules").getDocuments() {
            QuerySnapshot, error in
            if let error = error {
                print("\(error.localizedDescription)")
            } else{
                self.daySchedule = QuerySnapshot!.documents.flatMap({Schedule(dictionary: $0.data())})
                DispatchQueue.main.async {
                    self.table.reloadData()
                }
            }
        }
    }


}
