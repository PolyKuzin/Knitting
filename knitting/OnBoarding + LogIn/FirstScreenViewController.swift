//
//  FirstScreenViewController.swift
//  knitting
//
//  Created by Павел Кузин on 06.06.2020.
//  Copyright © 2020 Павел Кузин. All rights reserved.
//

import UIKit
import FirebaseAuth

class FirstScreenViewController: UIViewController {
    
    @IBOutlet weak var singUpBtn    : UIButton!
    @IBOutlet weak var logInBtn     : UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        authitication()
        singUpBtn.designButton(singUpBtn, 22)
        logInBtn.designButtonAsLabel(logInBtn, 17)
    }
}

extension FirstScreenViewController {
    func authitication() {
        Auth.auth().addStateDidChangeListener { (auth, user) in
            if user != nil {
                self.performSegue(withIdentifier: "Auth", sender: nil)
            }
        }
    }
}
