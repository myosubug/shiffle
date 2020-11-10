//
//  MainScheduleViewController.swift
//  shiffle
//
//  Created by Minh Hang Chu on 2020-10-27.
//

import UIKit
import FirebaseDatabase
import FSCalendar



class MainScheduleViewController: UIViewController, FSCalendarDelegate, UITableViewDataSource {
    
    
    
    @IBOutlet var calendar: FSCalendar!
    @IBOutlet var table: UITableView!
    
    let data = ["first", "second", "third"]
    //var ref: DatabaseReference?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        calendar.delegate = self
        table.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        table.dataSource = self
        
    }
    
    func calendar(_ calendar: FSCalendar, didDeselect date: Date, at monthPosition: FSCalendarMonthPosition) {
        let format = DateFormatter()
        format.dateFormat = "EEEE MM-dd-YYYY"
        let dstring = format.string(from: date)
        print("\(dstring)")
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = data[indexPath.row]
        return cell
    }
    
    


}
