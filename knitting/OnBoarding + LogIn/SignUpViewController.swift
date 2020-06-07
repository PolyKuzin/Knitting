//
//  SignUpViewController.swift
//  knitting
//
//  Created by Павел Кузин on 06.06.2020.
//  Copyright © 2020 Павел Кузин. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
import FirebaseFirestore

class SignUpViewController: UIViewController {

    var ref: DatabaseReference!
    
    @IBOutlet weak var firstNameTextField: UITextField!
    @IBOutlet weak var lastNameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var signupButton: UIButton!
    @IBOutlet weak var errorLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ref = Database.database().reference(withPath: "users")
    }
    func isPasswordValid(_ password: String) -> Bool {
        
        let passwordTest = NSPredicate(format: "SELF MATCHES %@", "^(?=.*[a-z])(?=.*[$@S#!%*?&])[A-Za-z\\d$@$#!%*?&]{8,}")
        return passwordTest.evaluate(with: password)
    }
    
    func validateFields() -> String? {
        
        //check that fields are filled in
        if firstNameTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
        lastNameTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
        emailTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
        passwordTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" {
            return "Please fill in all fields"
        }
        //check the passwird
//        let cleanPassword = passwordTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
//        if isPasswordValid(cleanPassword) == false {
//            return "Please make sure your password is at least 8 characters or contains # % & 0-9"
//        }
        
        return nil
    }
    
    @IBAction func singupTapped(_ sender: Any) {
        let error = validateFields()
        if error != nil {
            showError(error!)
        } else {
            //Create cleaned versions of the data
            let firstName = firstNameTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let lastName = lastNameTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let email = emailTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let password = passwordTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)

//             users to FireStore
            let db = Firestore.firestore()
            db.collection("users").addDocument(data: ["firstname"   : firstName,
                                                      "lastname"    : lastName,
                                                      "email"       : email]) { (error) in
                if error != nil {
                    self.showError("Error saving user data")
                }
            }

            //Create user && transition to main Screen
             Auth.auth().createUser(withEmail: email, password: password) {[weak self] (user, err) in
                       guard err == nil, user != nil else {
                           print(err!.localizedDescription)
                           return
                       }

                       let userRef = self?.ref.child((user?.user.uid)!)
                       userRef!.setValue(["email":user!.user.email])
                   }

            self.transitionToMain()
        }
//         guard let email = emailTextField.text, email != "" else {
//        //TODO: Errors of wrong email
//                    return
//                }
//                guard let password = passwordTextField.text, password != "" else {
//        //TODO: Errors of wrong password
//                    return
//                }
//                Auth.auth().createUser(withEmail: email, password: password) {[weak self] (user, error) in
//                    guard error == nil, user != nil else {
//                        print(error!.localizedDescription)
//                        return
//                    }
//
//                    let userRef = self?.ref.child((user?.user.uid)!)
//                    userRef!.setValue(["email":user!.user.email])
//                }
    }
    
    func showError(_ message: String) {
        
        errorLabel.text = message
        errorLabel.alpha = 1
    }
    
    func transitionToMain(){
        print("transition")
//        self.performSegue(withIdentifier: "SignUp", sender: nil)
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "projectsController") as! ProjectsVC
        vc.modalPresentationStyle = .fullScreen
        self.navigationController?.pushViewController(vc, animated: true)
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
