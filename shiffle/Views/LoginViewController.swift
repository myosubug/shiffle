//
//  LoginViewController.swift
//  shiffle
//
//  Created by myosubug on 2020-10-21.
//

import UIKit
import FirebaseAuth

class LoginViewController: UIViewController {

    @IBOutlet var email: UITextField!
    @IBOutlet var password: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
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
            print("no text in email")
            return
        }
        
        if password.text?.isEmpty == true {
            print("no text in password")
            return
        }
        login()
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
            print(Auth.auth().currentUser)
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let vc = storyboard.instantiateViewController(withIdentifier: "mainHome")
            vc.modalPresentationStyle = .overFullScreen
            present(vc, animated: true)
        }
    }
}
