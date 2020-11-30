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
    var timer: Timer?
   
    
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
        timer =  Timer.scheduledTimer(withTimeInterval: 0.2, repeats: true) { (timer) in
            self.loadSchedule()
        }
        
               
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
    

    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, editingStyleForRowAt: IndexPath) -> UITableViewCell.EditingStyle{
        return .delete
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        let s = daySchedule[indexPath.row]
        let qstart = s.startTime
        let qend = s.endTime
        
        if editingStyle == UITableViewCell.EditingStyle.delete {
            let query = self.db.collection("schedules").whereField("day", isEqualTo: self.dstring)
            query.getDocuments() {
                QuerySnapshot, error in
                if let error = error {
                    print("\(error.localizedDescription)")
                } else{
                    for q in QuerySnapshot!.documents {
                        if qstart == q.data()["startTime"] as! String, qend == q.data()["endTime"] as! String {
                            q.reference.delete()
                        }
                    }
                    
                    DispatchQueue.main.async {
                        self.table.reloadData()
                    }
                }
            }
            
            tableView.beginUpdates()
            
            tableView.endUpdates()
        }
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
    
}
