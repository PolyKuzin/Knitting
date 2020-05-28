//
//  FirstScreen.swift
//  knitting
//
//  Created by Павел Кузин on 28.05.2020.
//  Copyright © 2020 Павел Кузин. All rights reserved.
//

import UIKit

class FirstScreen: UIViewController {

    var createNewAccount = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureCreateNewAccountButton()
        
    }
    
    func configureCreateNewAccountButton() {
        view.addSubview(createNewAccount)
        let colorGradient = CAGradientLayer()
        colorGradient.colors = [ UIColor(red: 0.278, green: 0.596, blue: 0.775, alpha: 1).cgColor,
        UIColor(red: 0.271, green: 0.438, blue: 0.867, alpha: 1).cgColor ]
        colorGradient.position = createNewAccount.center
        colorGradient.startPoint = CGPoint(x: 0.25, y: 0.5)
        colorGradient.endPoint = CGPoint(x: 0.75, y: 0.5)
        colorGradient.transform = CATransform3DMakeAffineTransform(CGAffineTransform(a: 0.96, b: 0.44, c: -0.44, d: 18.03, tx: 0.26, ty: -8.81))
        colorGradient.bounds = createNewAccount.bounds.insetBy(dx: -0.5 * createNewAccount.bounds.size.width, dy: -0.5 * createNewAccount.bounds.size.height)
        createNewAccount.layer.addSublayer(colorGradient)
        createNewAccount.addTarget(self, action: #selector(newAccount), for: .touchUpInside)
        createNewAccount.setTitleColor(.black, for: .normal)
        createNewAccount.setTitle("NewAccount", for: .normal)
        //createNewAccount.backgroundColor = .blue
        createNewAccount.layer.cornerRadius = createNewAccount.frame.size.height / 2
        createNewAccountConstraints()
    }
    @objc func newAccount() {
        let newVC = LogInVC()
            self.navigationController?.pushViewController(newVC, animated: true)
    }
    
    func createNewAccountConstraints(){
        createNewAccount.translatesAutoresizingMaskIntoConstraints = false
        createNewAccount.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        createNewAccount.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        createNewAccount.heightAnchor.constraint(equalToConstant: 65).isActive = true
        createNewAccount.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
        createNewAccount.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive = true
    }
}
