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
    
    var ref: DatabaseReference!
    var warningLabel            = UILabel()
    var register                = UIButton()
    var logIn                   = UIButton()
    
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    override func viewDidLoad() {
        authitication()
        super.viewDidLoad()
        configureAllUI()
        constraints()
        ref = Database.database().reference(withPath: "users")

        NotificationCenter.default.addObserver(self, selector: #selector(kbDidShow), name: UIResponder.keyboardDidShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(kbDidHide), name: UIResponder.keyboardDidHideNotification, object: nil)
    }
    
    @IBAction func registerTapped(_ sender: Any) {
        guard let email = emailTextField.text, let password = passwordTextField.text, email != "", password != "" else {
//TODO: Errors of wrong email or password
                    return
                }
        Auth.auth().createUser(withEmail: email, password: password) {[weak self] (user, error) in
            guard error == nil, user != nil else {
                print(error!.localizedDescription)
                return
            }
            
            let userRef = self?.ref.child((user?.user.uid)!)
            userRef!.setValue(["email":user!.user.email])
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        //emailTextField.text = ""
        //passwordTextField.text = ""
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
                let vc = storyboard.instantiateViewController(withIdentifier: "projectsController") as! ProjectsVC
                vc.modalPresentationStyle = .fullScreen
                self.navigationController?.pushViewController(vc, animated: true)
                //performSegue(withIdentifier: "LogInSegue", sender: nil)
                return
            }
            
//TODO: Warning label error:
            print("No such User")
        }
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
    
    func configureAllUI(){
        configureRegisterBtn()
    }
    
    func configureRegisterBtn(){
        register.setTitle("Register", for: .normal)
        register.setTitleColor(UIColor(red: 0.188, green: 0.188, blue: 0.188, alpha: 1), for: .normal)
        register.backgroundColor = .red
        
        view.addSubview(register)
    }

}

//MARK: Constraints
extension LogInVC{
    
    func constraints(){
        passwordTextField.translatesAutoresizingMaskIntoConstraints                                                     = false
        passwordTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive                  = true
        passwordTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 20).isActive                = true
        passwordTextField.heightAnchor.constraint(equalToConstant: 60).isActive                                         = true
        passwordTextField.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.size.width - 40).isActive        = true
        passwordTextField.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive                                = true
        
        emailTextField.translatesAutoresizingMaskIntoConstraints                                                        = false
        emailTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive                     = true
        emailTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 20).isActive                   = true
        emailTextField.heightAnchor.constraint(equalToConstant: 60).isActive                                            = true
        emailTextField.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.size.width - 40).isActive           = true
        emailTextField.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -80).isActive                    = true
        
        register.translatesAutoresizingMaskIntoConstraints                                                              = false
        register.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        register.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 20).isActive = true

    }
}
