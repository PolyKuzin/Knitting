//
//  LogInVC.swift
//  knitting
//
//  Created by Павел Кузин on 25.05.2020.
//  Copyright © 2020 Павел Кузин. All rights reserved.
//

import UIKit
import Firebase

class LogInVC: UIViewController, UITextFieldDelegate {
    
    var ref: DatabaseReference!
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var singUpBtn: UIButton!
    @IBOutlet weak var errorLabel: UILabel!
    
    override func viewDidLoad() {
        authitication()
        super.viewDidLoad()
        setingUpKeyboardHiding()
        ref = Database.database().reference(withPath: "users")
        setUpUI()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        emailTextField.text = ""
        passwordTextField.text = ""
    }
    
    func setUpUI(){
        emailTextField.designTextField(emailTextField)
        passwordTextField.designTextField(passwordTextField)
        errorLabel.isHidden = true
        loginButton.designButton(loginButton, 17)
        singUpBtn.designButtonAsLabel(singUpBtn, 14)
    }
    
    func validateFields() -> String? {
        
        //check that fields are filled in
        if emailTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines)         == "" ||
        passwordTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines)         == "" {
            return "Please fill in all fields"
        }
             
        return nil
    }
    
    
    func showError(_ message: String) {
        errorLabel.isHidden = false
        errorLabel.text = message
        errorLabel.alpha = 1
    }
    
    @IBAction func loginTapped(_ sender: Any) {
        let error = validateFields()
        if error != nil {
            showError(error!)
        }
        if error == nil {
            let email = emailTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let password = passwordTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            Auth.auth().signIn(withEmail: email, password: password) { (user, err) in
//TODO: Warning label
                    if err != nil{
                        self.passwordTextField.backgroundColor      = Colors.errorTextField
                        self.passwordTextField.layer.borderColor    = Colors.errorTextFieldBorder.cgColor
                        self.emailTextField.backgroundColor         = Colors.errorTextField
                        self.emailTextField.layer.borderColor       = Colors.errorTextFieldBorder.cgColor
                        self.passwordTextField.textColor            = Colors.errorTextFieldBorder
                        self.emailTextField.textColor               = Colors.errorTextFieldBorder

                        self.showError(err!.localizedDescription)
                        return
                    }
                    if user != nil {
                        let storyboard = UIStoryboard(name: "Main", bundle: nil)
                        let vc = storyboard.instantiateViewController(withIdentifier: "projectsController") as! ProjectsVC
                        vc.modalPresentationStyle = .fullScreen
                        self.navigationController?.pushViewController(vc, animated: true)
                        return
                    }

//TODO: Warning label error:
                print("No such User")
            }
        }
        hideKeyboard()
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillChangeFrameNotification, object: nil)
    }
}
// MARK: Keyboard Issues
extension LogInVC {
    
    func setingUpKeyboardHiding(){
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillChange(notification: )), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillChange(notification: )), name: UIResponder.keyboardWillHideNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillChange(notification: )), name: UIResponder.keyboardWillChangeFrameNotification, object: nil)

        delegates()
    }
    
    func hideKeyboard(){
        emailTextField.resignFirstResponder()
        passwordTextField.resignFirstResponder()
    }
    
    func delegates(){
        emailTextField.delegate = self
        passwordTextField.delegate = self
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
extension LogInVC {
    func authitication() {
        Auth.auth().addStateDidChangeListener { (auth, user) in
            if user != nil {
                self.performSegue(withIdentifier: "LogInSegue", sender: nil)
            }
        }
    }
}
