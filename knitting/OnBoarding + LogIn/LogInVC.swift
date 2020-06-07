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

    var warningPasswordLabel    = UILabel()
//    var warningEmailLabel       = UILabel()
    var register                = UIButton()
    var logIn                   = UIButton()
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    
    override func viewDidLoad() {
        authitication()
        super.viewDidLoad()
        configureAllUI()
        constraints()
        keyboardMoving()
        ref = Database.database().reference(withPath: "users")
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        emailTextField.text = ""
        passwordTextField.text = ""
    }
    
    @IBAction func loginTapped(_ sender: Any) {
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
        configureWarningLabels()
        configureRegisterBtn()
        configureLoginBtn()
    }
    
    func configureWarningLabels(){
        
        warningPasswordLabel.isHidden = true
        warningPasswordLabel.text = ""
        warningPasswordLabel.font = UIFont(name: "Helvetica", size: 10)
        warningPasswordLabel.textColor = UIColor(red: 0.962, green: 0.188, blue: 0.467, alpha: 1)
        
        view.addSubview(warningPasswordLabel)
    }
    
    func configureLoginBtn(){
        logIn.setTitle("Log In", for: .normal)
        logIn.setTitleColor(.white, for: .normal)
        logIn.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width - 80, height: UIScreen.main.bounds.size.height / 15)
        let layer1 = CAGradientLayer()
        layer1.colors = [
          UIColor(red: 0.278, green: 0.596, blue: 0.775, alpha: 1).cgColor,
          UIColor(red: 0.271, green: 0.438, blue: 0.867, alpha: 1).cgColor
        ]
        layer1.locations = [0, 1]
        layer1.startPoint = CGPoint(x: 0.25, y: 0.5)
        layer1.endPoint = CGPoint(x: 0.75, y: 0.5)
        layer1.transform = CATransform3DMakeAffineTransform(CGAffineTransform(a: 0.96, b: 0.44, c: -0.44, d: 18.03, tx: 0.26, ty: -8.81))
        layer1.bounds = logIn.bounds.insetBy(dx: -0.5*logIn.bounds.size.width, dy: -0.5*logIn.bounds.size.height)
        layer1.position = logIn.center
        logIn.layer.addSublayer(layer1)
        
        logIn.layer.cornerRadius = logIn.frame.size.height / 2
        logIn.clipsToBounds = true
        logIn.addTarget(self, action: #selector(logInBtn), for: .touchUpInside)
        view.addSubview(logIn)
    }
    
    func configureRegisterBtn(){
        register.setTitle("Register", for: .normal)
        register.setTitleColor(UIColor(red: 0.188, green: 0.188, blue: 0.188, alpha: 1), for: .normal)
        register.addTarget(self, action: #selector(registerBtn), for: .touchUpInside)
        view.addSubview(register)
    }
    
    @objc func logInBtn(){
        guard let email = emailTextField.text, let password = passwordTextField.text, password != "" || email != "" else {
            if emailTextField.text == "" && passwordTextField.text == ""{
                self.emailTextField.backgroundColor         = UIColor(red: 1, green: 0.954, blue: 0.976, alpha: 1)
                self.emailTextField.layer.borderColor       = UIColor(red: 0.962, green: 0.188, blue: 0.467, alpha: 1).cgColor
                self.warningPasswordLabel.isHidden          = false
                self.warningPasswordLabel.text              = "Fill the fields to log in"
                self.passwordTextField.backgroundColor      = UIColor(red: 1, green: 0.954, blue: 0.976, alpha: 1)
                self.passwordTextField.textColor            = UIColor(red: 0.962, green: 0.188, blue: 0.467, alpha: 1)
                self.passwordTextField.layer.borderColor    = UIColor(red: 0.962, green: 0.188, blue: 0.467, alpha: 1).cgColor
            }
            return
        }
        emailTextField.backgroundColor      = .white
        passwordTextField.backgroundColor   = .white
        passwordTextField.textColor         = .black
        warningPasswordLabel.isHidden       = true
        Auth.auth().signIn(withEmail: email, password: password) { (user, error) in
//TODO: Warning label
        if error != nil{
            self.warningPasswordLabel.isHidden = false
            self.warningPasswordLabel.text = error?.localizedDescription
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

    @objc func registerBtn(){
        guard let email = emailTextField.text, email != "" else {
//TODO: Errors of wrong email
            return
        }
        guard let password = passwordTextField.text, password != "" else {
//TODO: Errors of wrong password
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
}



//MARK: Keyboard essuise
extension LogInVC {
    
    func keyboardMoving(){
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
}
//MARK: Design
//TODO: FONTS
extension UIView {
    
    func setGradientBackground(colorOne: UIColor, colorTwo: UIColor) {
        
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = bounds
        gradientLayer.colors = [colorOne.cgColor, colorTwo.cgColor]
        gradientLayer.locations = [0.0, 1.0]
        gradientLayer.startPoint = CGPoint(x: 0.25, y: 0.5)
        gradientLayer.endPoint = CGPoint(x: 0.75, y: 0.5)
        
        gradientLayer.bounds = bounds.insetBy(dx: -0.5 * bounds.size.width, dy: -0.5 * bounds.size.height)
        gradientLayer.frame = bounds
        layer.insertSublayer(gradientLayer, at: 0)
    }
}
