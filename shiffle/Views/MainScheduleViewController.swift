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
    var dstring = ""
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        db = Firestore.firestore()
        calendar.delegate = self
        table.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        table.dataSource = self
        let currentDateTime = Date()
        let format = DateFormatter()
        format.dateFormat = "YYYYMMdd"
        dstring = format.string(from: currentDateTime)
        selectedDate.selectedDate = dstring
        loadSchedule()
               
    }
    
    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
        let format = DateFormatter()
        format.dateFormat = "YYYYMMdd"
        dstring = format.string(from: date)
        selectedDate.selectedDate = dstring
        loadSchedule()
    }
    
       
    @IBAction func viewMyTeam(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "employeesList")
        vc.modalPresentationStyle = .overFullScreen
        present(vc, animated: true)
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return daySchedule.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let s = daySchedule[indexPath.row]
        cell.textLabel?.text = "\(s.startTime) - \(s.endTime): \(s.name)"
        return cell
    }
    
    
    func loadSchedule(){
        let query = self.db.collection("schedules").whereField("day", isEqualTo: self.dstring)
        query.getDocuments() {
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
    
    
    @IBAction func switchCalendarScope(_ sender: Any) {
        if self.calendar.scope == FSCalendarScope.month {
            self.calendar.scope = .week
        } else {
            self.calendar.scope = .month
        }
    }

    /*
    func checkForUpdate(){
        let query = self.db.collection("schedules").whereField("day", isEqualTo: self.dstring)
        query.addSnapshotListener {
            QuerySnapshot, error in
            
            guard let snapshot = QuerySnapshot else {return}
            snapshot.documentChanges.forEach{
                diff in
                if diff.type == .added{
                    self.daySchedule.append(Schedule(dictionary: diff.document.data())!)
                    DispatchQueue.main.async {
                        self.table.reloadData()
                    }
                }
            }
                
        
        
        }
    }
 */
    

}
