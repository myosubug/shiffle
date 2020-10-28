//
//  MainScheduleViewController.swift
//  shiffle
//
//  Created by Minh Hang Chu on 2020-10-27.
//

import UIKit
import FirebaseDatabase



class MainScheduleViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    
    @IBOutlet weak var tableView: UITableView!
    var ref: DatabaseReference?
    var count = 0
    
    var weekday = ["Monday","Tuesday", "Wednesday", "Thursday", "Friday", "Saturday", "Sunday"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        tableView.delegate = self
        tableView.dataSource = self
        
        ref = Database.database().reference()
        
        ref?.child("Schedules").observe(.childAdded, with: { (snapshot) in
            self.count = self.count % 6
            var temp = self.weekday[self.count]
            let new = snapshot.value as? String
            if let updated = new {
                self.weekday[self.count] = temp + ": " + new! ?? "<no update>"
                self.tableView.reloadData()
                self.count = self.count + 1
            }
            
            
            
        })
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return weekday.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "WeekdayCell")
        cell?.textLabel?.text = weekday[indexPath.row]
        return cell!
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
