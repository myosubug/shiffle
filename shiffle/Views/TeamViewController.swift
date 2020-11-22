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
    @IBOutlet weak var TeamEditButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
  
        tblEmployees.delegate = self
        tblEmployees.dataSource = self
        if (Manager.isManager == false)  {
            TeamEditButton.isHidden = true
        } else {
            TeamEditButton.isHidden = false
        }
        
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
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            let employee = employeesList[indexPath.row]
            if (Manager.isManager == true)  {
                let alertController = UIAlertController(title: employee.name, message: "Do you want to make changes?", preferredStyle: .alert)
                let updateAction = UIAlertAction(title: "Update", style:.default){ (_) in
                    let id = employee.id
                    
                    let name = alertController.textFields?[0].text
                    let contact = alertController.textFields?[1].text
                    
                    self.updateEmployee(id: id!, name: name!, contact: contact!)
                }
                let deleteAction = UIAlertAction(title: "Delete", style:.default){ (_) in
                    self.deleteEmployee(id: employee.id!)
                }
                alertController.addTextField { (textField) in
                    textField.text = employee.name
                }
                alertController.addTextField { (textField) in
                    textField.text = employee.contact
                }
                alertController.addAction(updateAction)
                alertController.addAction(deleteAction)
                present(alertController, animated: true, completion: nil)
            }
        }
        
        func updateEmployee(id: String, name: String, contact: String){
            let employee = [ "id": id, "employeeName": name, "employeeContact":contact]
            refEmployees?.child(id).setValue(employee)
        }
        
        func deleteEmployee(id:String){
            refEmployees?.child(id).setValue(nil)
        }

}
