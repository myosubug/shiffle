//
//  TeamViewController.swift
//  shiffle
//
//  Created by Minh Hang Chu on 2020-11-18.
//

import UIKit
import FirebaseDatabase

class TeamViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var refEmployees:DatabaseReference?
    @IBOutlet weak var tblEmployees: UITableView!
    var employeesList = [EmployeeModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
  
        tblEmployees.delegate = self
        tblEmployees.dataSource = self
        
        refEmployees = Database.database().reference().child("Employees Info");
        refEmployees?.observe(DataEventType.value, with: { (DataSnapshot) in
            if DataSnapshot.childrenCount>0{
                self.employeesList.removeAll()
                for employees in DataSnapshot.children.allObjects as![DataSnapshot]{
                    let employeeObject = employees.value as?[String: AnyObject]
                    let employeeName = employeeObject?["employeeName"]
                    let employeeContact = employeeObject?["employeeContact"]
                    let employeeId = employeeObject?["id"]
                    
                    let employee = EmployeeModel(id: employeeId as! String?, name: employeeName as! String?, contact: employeeContact as! String?)
                    
                    self.employeesList.append(employee)
                }
                self.tblEmployees.reloadData()
            }
        })
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return employeesList.count
    }
        
    @IBAction func backToMain(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "mainHome")
        vc.modalPresentationStyle = .overFullScreen
        present(vc, animated: true)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "employeeCell", for: indexPath) as! EmployeeTableViewCell
        let employee: EmployeeModel
        
        // load infomation
        employee = employeesList[indexPath.row]
        cell.lblName.text = employee.name
        cell.lblContact.text = employee.contact
        return cell
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
