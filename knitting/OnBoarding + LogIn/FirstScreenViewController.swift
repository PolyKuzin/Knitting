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

    override func viewDidLoad() {
        super.viewDidLoad()
        authitication()
        // Do any additional setup after loading the view.
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
