//
//  LogInVC.swift
//  knitting
//
//  Created by Павел Кузин on 25.05.2020.
//  Copyright © 2020 Павел Кузин. All rights reserved.
//

import UIKit
import Firebase

class LogInVC: UIViewController {

    @IBAction func registerTapped(_ sender: Any) {
        guard let email = emailTextField.text, let password = passwordTextField.text, email != "", password != "" else {
//TODO: Errors of wrong email or password
                    return
                }
        Auth.auth().createUser(withEmail: email, password: password) { (user, error) in
            
            if error == nil{
                if user != nil{
                    
                } else {
                    print("user is not created")
                }
            } else {
                print(error!.localizedDescription)
            }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        emailTextField.text = ""
        passwordTextField.text = ""
    }
// Регистрация пользователя
    @IBAction func loginTapped(_ sender: Any) {
        guard let email = emailTextField.text, let password = passwordTextField.text, email != "", password != "" else {
//TODO: Errors of wrong email or password
            return
        }
        Auth.auth().signIn(withEmail: email, password: password) { (user, error) in
//TODO: Warning label
            if error != nil{
                print("Error ocered")
                return
            }
            if user != nil {
                let storyboard = UIStoryboard(name: "Main", bundle: nil)
                let vc = storyboard.instantiateViewController(withIdentifier: "projectsController") as! ProjectsController
                vc.modalPresentationStyle = .fullScreen
                self.navigationController?.pushViewController(vc, animated: true)
                //performSegue(withIdentifier: "LogInSegue", sender: nil)
                return
            }
            
//TODO: Warning label error:
            print("No such User")
        }
    }
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var label: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        Auth.auth().addStateDidChangeListener { (auth, user) in
            if user != nil {
                self.performSegue(withIdentifier: "LogInSegue", sender: nil)
            }
        }
        
        NotificationCenter.default.addObserver(self, selector: #selector(kbDidShow), name: UIResponder.keyboardDidShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(kbDidHide), name: UIResponder.keyboardDidHideNotification, object: nil)
    }
    
    @objc func kbDidShow(notification: Notification) {
        guard  let userInfo = notification.userInfo else {return}
        let kbFrameSize = (userInfo[UIResponder.keyboardFrameEndUserInfoKey] as! NSValue).cgRectValue
        (self.view as! UIScrollView).contentSize = CGSize(width: self.view.bounds.size.width, height: self.view.bounds.size.height + (kbFrameSize.height / 2))
//TODO: set position
        (self.view as! UIScrollView).scrollIndicatorInsets = UIEdgeInsets(top: 0, left: 0, bottom: kbFrameSize.height, right: 0)
    }
    
    @objc func kbDidHide() {
           (self.view as! UIScrollView).contentSize = CGSize(width: self.view.bounds.size.width, height: self.view.bounds.size.height)
       }
    
    func delegating(){
        emailTextField.delegate = self
        passwordTextField.delegate = self
    }
}

extension LogInVC: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
       
        return true
    }
    
}
