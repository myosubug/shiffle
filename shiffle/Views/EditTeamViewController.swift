//
//  EditTeamViewController.swift
//  shiffle
//
//  Created by Minh Hang Chu on 2020-11-16.
//

import UIKit
import FirebaseDatabase

class EditTeamViewController: UIViewController {

    @IBOutlet weak var textView: UITextView!
    
    @IBOutlet weak var textFieldName: UITextField!
    
    @IBOutlet weak var textFieldContact: UITextField!
    
    var refEmployees:DatabaseReference?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        

        refEmployees = Database.database().reference()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func addInfo(_ sender: Any) {
        addEmployee()
        presentingViewController?.dismiss(animated: true, completion: nil)
    }
    
    func addEmployee(){
        let key = refEmployees?.child("Employees Info").childByAutoId().key
        let employee = ["id":key,"employeeName": textFieldName.text! as String,"employeeContact": textFieldContact.text! as String]
        refEmployees?.child("Employees Info").child(key!).setValue(employee)
    }
    
    @IBAction func cancelEdit(_ sender: Any) {
        presentingViewController?.dismiss(animated: true, completion: nil)
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
