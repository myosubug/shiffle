//
//  DetailViewController.swift
//  shiffle
//
//  Created by Minh Hang Chu on 2020-10-27.
//

import UIKit
import FirebaseDatabase

class DetailViewController: UIViewController {

    
    @IBOutlet weak var textView: UITextView!
    var ref: DatabaseReference?
    override func viewDidLoad() {
        super.viewDidLoad()
        ref = Database.database().reference()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func backToMain(_ sender: Any) {
        presentingViewController?.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func submitData(_ sender: Any) {
        ref?.child("Schedules").childByAutoId().setValue(textView.text)
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
