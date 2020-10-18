//
//  ViewController.swift
//  shiffle
//
//  Created by myosubug on 2020-10-17.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var signUpButton: UIButton!

    @IBOutlet weak var logInButton: UIButton!
  
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setUpElements()
    }

    func setUpElements() {
        Utilities.styleFilledButton(signUpButton)
        Utilities.styleFilledButton(logInButton)
    }
}

