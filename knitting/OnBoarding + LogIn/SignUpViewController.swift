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

class SignUpViewController: UIViewController, UITextFieldDelegate {

    var ref: DatabaseReference!
    let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
    
    @IBOutlet weak var firstNameTextField   : UITextField!
    @IBOutlet weak var emailTextField       : UITextField!
    @IBOutlet weak var passwordTextField    : UITextField!
    @IBOutlet weak var signupButton         : UIButton!
    @IBOutlet weak var logInBtn             : UIButton!
    @IBOutlet weak var errorLabel           : UILabel!
    
    override func viewDidLoad() {
        authitication()
        super.viewDidLoad()
        ref = Database.database().reference(withPath: "users")
        view.addGestureRecognizer(tap)
        setingUpKeyboardHiding()
        settingUpUI()
    }
    
    @objc func dismissKeyboard(){
        view.endEditing(true)
    }
    
    func settingUpUI(){
        firstNameTextField.designTextField(firstNameTextField)
        emailTextField.designTextField(emailTextField)
        passwordTextField.designTextField(passwordTextField)
        errorLabel.isHidden = true
        signupButton.designButton(signupButton, 17)
        logInBtn.designButtonAsLabel(logInBtn, 14)
    }
    
    func isPasswordValid(_ password: String) -> Bool {
        
        let passwordTest = NSPredicate(format: "SELF MATCHES %@",
                                               "^(?=.*[a-z])(?=.*[$@S#!%*?&])[A-Za-z\\d$@$#!%*?&]{8,}")
        return passwordTest.evaluate(with: password)
    }
    
    func validateFields() -> String? {
        
        //check that fields are filled in
        if firstNameTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines)     == "" ||
        emailTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines)            == "" ||
        passwordTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines)         == "" {
            return "Please fill in all fields"
        }
        //check the passwird
        let cleanPassword = passwordTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        if isPasswordValid(cleanPassword) == false {
            return "Please make sure your password is at least 8 characters and contains # % & 0-9"
        }
        
        return nil
    }
    
    @IBAction func singupTapped(_ sender: Any) {
        let error = validateFields()
        if error != nil {
            showError(error!)
        } else {
            //Create cleaned versions of the data
            let firstName   = firstNameTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let email       = emailTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let password    = passwordTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)

            let db = Firestore.firestore()
            db.collection("users").addDocument(data: ["firstname"   : firstName,
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
        hideKeyboard()
    }
    
    func showError(_ message: String) {
        
        signupButton.shakeAnimation()
        firstNameTextField.shakeAnimation()
        emailTextField.shakeAnimation()
        passwordTextField.shakeAnimation()
        errorLabel.text = message
        errorLabel.alpha = 1
        errorLabel.isHidden = false
    }
    
    func transitionToMain(){
        print("transition")
//        self.performSegue(withIdentifier: "SignUp", sender: nil)
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "projectsController") as! ProjectsVC
        vc.modalPresentationStyle = .fullScreen
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillChangeFrameNotification, object: nil)
    }
}
extension SignUpViewController {
    
    func setingUpKeyboardHiding(){
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillChange(notification: )), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillChange(notification: )), name: UIResponder.keyboardWillHideNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillChange(notification: )), name: UIResponder.keyboardWillChangeFrameNotification, object: nil)

        delegates()
    }
    
    func hideKeyboard(){
        firstNameTextField.resignFirstResponder()
        emailTextField.resignFirstResponder()
        passwordTextField.resignFirstResponder()
    }
    
    func delegates(){
        firstNameTextField.delegate     = self
        emailTextField.delegate         = self
        passwordTextField.delegate      = self
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        hideKeyboard()
        return true
    }
    
    @objc func keyboardWillChange(notification: Notification){

        guard let userInfo = notification.userInfo else {return}
              let keyboardRect = (userInfo[UIResponder.keyboardFrameEndUserInfoKey] as! NSValue).cgRectValue
        
        if notification.name == UIResponder.keyboardWillShowNotification ||
           notification.name == UIResponder.keyboardWillChangeFrameNotification {
           view.frame.origin.y = -keyboardRect.height + 20
        } else {
            view.frame.origin.y = 0
        }
    }
}
//MARK: AUTH
extension SignUpViewController {
    func authitication() {
        Auth.auth().addStateDidChangeListener { (auth, user) in
            if user != nil {
                self.performSegue(withIdentifier: "LogInSegue", sender: nil)
            }
        }
    }
}
