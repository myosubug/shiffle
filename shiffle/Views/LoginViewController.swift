//
//  LoginViewController.swift
//  shiffle
//
//  Created by myosubug on 2020-10-21.
//

import UIKit
import FirebaseAuth
import FirebaseFirestore

class LoginViewController: UIViewController {

    @IBOutlet var email : UITextField!
    
    @IBOutlet var password: UITextField!
    var db:Firestore!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.password.isSecureTextEntry = true
        db = Firestore.firestore()
    }
    

    @IBAction func logInTabbed(_ sender: Any) {
        validateFields()
    }
    
    @IBAction func signUpTabbed(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "signUp")
        vc.modalPresentationStyle = .overFullScreen
        present(vc, animated: true)
    }
    
    func validateFields() {
        if email.text?.isEmpty == true {
            return
        }
        
        if password.text?.isEmpty == true {
            return
        }
        login()
        checkManager()
    }
    
    func login() {
        Auth.auth().signIn(withEmail: email.text!, password: password.text!) {[weak self] authResult, err in
            guard let strongSelf = self else {return}
            if let err = err {
                print(err.localizedDescription)
                return
            }
            else {
                self!.checkUserInfo()
            }
        }
    
        
    }
    
    func checkUserInfo() {
        if Auth.auth().currentUser != nil {
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let vc = storyboard.instantiateViewController(withIdentifier: "mainHome")
            vc.modalPresentationStyle = .overFullScreen
            present(vc, animated: true)
        }
    }
    
    func checkManager(){
        let query = self.db.collection("users").whereField("email", isEqualTo: self.email.text)
        query.getDocuments() {
            QuerySnapshot, error in
            if let error = error {
                print("\(error.localizedDescription)")
            } else{
                for document in QuerySnapshot!.documents {
                    if (document.get("manager") ?? false) as! Bool {
                        Manager.isManager = true
                    } else{
                        Manager.isManager = false
                    }
                     
                }
            }
        }
    }
}
