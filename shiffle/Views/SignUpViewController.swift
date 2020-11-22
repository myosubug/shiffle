//
//  SignUpViewController.swift
//  shiffle
//
//  Created by myosubug on 2020-10-21.
//

import UIKit
import FirebaseAuth
import Firebase
import FirebaseFirestore

class SignUpViewController: UIViewController {

    @IBOutlet var email: UITextField!
    @IBOutlet var password: UITextField!
    var db:Firestore!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        db = Firestore.firestore()
    }
    

    @IBAction func signUpTabbed(_ sender: Any) {
        if email.text?.isEmpty == true {
            return
        }
        
        if password.text?.isEmpty == true {
            return
        }
        signUp()
        checkManager()
    }
    
    @IBAction func haveAccountLoginTabbed(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "login")
        vc.modalPresentationStyle = .overFullScreen
        present(vc, animated: true)
    }
    
    func signUp(){
        Auth.auth().createUser(withEmail: email.text!, password: password.text!) { (authResult, error) in
            guard let user = authResult?.user, error == nil else {
                print("Error \(error?.localizedDescription)")
                return
            }
            
            if let newEmail = self.email.text {
                let newUser = User(email:newEmail, manager: false)
                self.db.collection("users").addDocument(data: newUser.dictionary){
                    error in
                        if let error = error {
                            print("\(error.localizedDescription)")
                        } else {
                            print("Document added")
                        }
                }
                
            }
            
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let vc = storyboard.instantiateViewController(withIdentifier: "mainHome")
            vc.modalPresentationStyle = .overFullScreen
            self.present(vc, animated: true)
        
        
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
