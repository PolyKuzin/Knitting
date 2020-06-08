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
    @IBOutlet weak var errorLabel: UILabel!
    
    override func viewDidLoad() {
        authitication()
        super.viewDidLoad()
        setingUpKeyboardHiding()
        constraints()
        ref = Database.database().reference(withPath: "users")
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        emailTextField.text = ""
        passwordTextField.text = ""
    }

    func showError(_ message: String) {
        
        errorLabel.text = message
        errorLabel.alpha = 1
    }
    
    func validateFields() -> String? {
        
        //check that fields are filled in
        if emailTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines)         == "" ||
        passwordTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines)         == "" {
            return "Please fill in all fields"
        }
             
        return nil
    }
    
    @IBAction func loginTapped(_ sender: Any) {
        let error = validateFields()
        if error == nil {
            let email = emailTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let password = passwordTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            Auth.auth().signIn(withEmail: email, password: password) { (user, err) in
//TODO: Warning label
                    if err != nil{
                        self.passwordTextField.backgroundColor = UIColor(red: 1, green: 0.954, blue: 0.976, alpha: 1)
                        self.passwordTextField.layer.borderColor = UIColor(red: 0.962, green: 0.188, blue: 0.467, alpha: 1).cgColor
                        self.emailTextField.backgroundColor = UIColor(red: 1, green: 0.954, blue: 0.976, alpha: 1)
                        self.emailTextField.layer.borderColor = UIColor(red: 0.962, green: 0.188, blue: 0.467, alpha: 1).cgColor
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
           view.frame.origin.y = -keyboardRect.height
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
//MARK: Configuring
extension LogInVC{
    
//    func configureAllUI(){
//        configureLoginBtn()
//    }
//
//    func configureLoginBtn(){
//        loginButton.setTitle("Log In", for: .normal)
//        loginButton.setTitleColor(.white, for: .normal)
//        loginButton.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width - 80, height: UIScreen.main.bounds.size.height / 15)
//        let layer1 = CAGradientLayer()
//        layer1.colors = [
//          UIColor(red: 0.278, green: 0.596, blue: 0.775, alpha: 1).cgColor,
//          UIColor(red: 0.271, green: 0.438, blue: 0.867, alpha: 1).cgColor
//        ]
//        layer1.locations = [0, 1]
//        layer1.startPoint = CGPoint(x: 0.25, y: 0.5)
//        layer1.endPoint = CGPoint(x: 0.75, y: 0.5)
//        layer1.transform = CATransform3DMakeAffineTransform(CGAffineTransform(a: 0.96, b: 0.44, c: -0.44, d: 18.03, tx: 0.26, ty: -8.81))
//        layer1.bounds = loginButton.bounds.insetBy(dx: -0.5 * loginButton.bounds.size.width, dy: -0.5 * loginButton.bounds.size.height)
//        layer1.position = loginButton.center
//        loginButton.layer.addSublayer(layer1)
//
//        loginButton.layer.cornerRadius = loginButton.frame.size.height / 2
//        loginButton.clipsToBounds = true
////        loginButton.addTarget(self, action: #selector(logInBtn), for: .touchUpInside)
//        view.addSubview(loginButton)
//    }
    
//    @objc func logInBtn(){
//        guard let email = emailTextField.text, let password = passwordTextField.text, password != "" || email != "" else {
//            if emailTextField.text == "" && passwordTextField.text == ""{
//                self.emailTextField.backgroundColor         = UIColor(red: 1, green: 0.954, blue: 0.976, alpha: 1)
//                self.emailTextField.layer.borderColor       = UIColor(red: 0.962, green: 0.188, blue: 0.467, alpha: 1).cgColor
//                self.passwordTextField.backgroundColor      = UIColor(red: 1, green: 0.954, blue: 0.976, alpha: 1)
//                self.passwordTextField.textColor            = UIColor(red: 0.962, green: 0.188, blue: 0.467, alpha: 1)
//                self.passwordTextField.layer.borderColor    = UIColor(red: 0.962, green: 0.188, blue: 0.467, alpha: 1).cgColor
//            }
//            return
//        }
//        emailTextField.backgroundColor      = .white
//        passwordTextField.backgroundColor   = .white
//        passwordTextField.textColor         = .black
//        Auth.auth().signIn(withEmail: email, password: password) { (user, error) in
////TODO: Warning label
//        if error != nil{
//            self.passwordTextField.backgroundColor = UIColor(red: 1, green: 0.954, blue: 0.976, alpha: 1)
//            self.passwordTextField.layer.borderColor = UIColor(red: 0.962, green: 0.188, blue: 0.467, alpha: 1).cgColor
//            self.emailTextField.backgroundColor = UIColor(red: 1, green: 0.954, blue: 0.976, alpha: 1)
//            self.emailTextField.layer.borderColor = UIColor(red: 0.962, green: 0.188, blue: 0.467, alpha: 1).cgColor
//            return
//        }
//                if user != nil {
//                    let storyboard = UIStoryboard(name: "Main", bundle: nil)
//                    let vc = storyboard.instantiateViewController(withIdentifier: "projectsController") as! ProjectsVC
//                    vc.modalPresentationStyle = .fullScreen
//                    self.navigationController?.pushViewController(vc, animated: true)
//                    return
//                        }
//
//        //TODO: Warning label error:
//                    print("No such User")
//                }
//    }
}

