//
//  Constraints.swift
//  knitting
//
//  Created by Павел Кузин on 30.05.2020.
//  Copyright © 2020 Павел Кузин. All rights reserved.
//

import UIKit

//MARK: Login ViewController
extension LogInVC{
    
    func constraints(){
        
        emailTextField.translatesAutoresizingMaskIntoConstraints                                                        = false
        emailTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive                     = true
        emailTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 20).isActive                   = true
        emailTextField.heightAnchor.constraint(equalToConstant: 60).isActive                                            = true
        emailTextField.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.size.width - 40).isActive           = true
        emailTextField.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -85).isActive                    = true
        
        passwordTextField.translatesAutoresizingMaskIntoConstraints                                                     = false
        passwordTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive                  = true
        passwordTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 20).isActive                = true
        passwordTextField.heightAnchor.constraint(equalToConstant: 60).isActive                                         = true
        passwordTextField.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.size.width - 40).isActive        = true
        passwordTextField.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive                                = true
        
        warningPasswordLabel.translatesAutoresizingMaskIntoConstraints                                                  = false
        warningPasswordLabel.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 3).isActive       = true
        warningPasswordLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 20).isActive             = true
        warningPasswordLabel.leadingAnchor.constraint(greaterThanOrEqualTo: view.leadingAnchor, constant: 20).isActive  = true
        
        logIn.translatesAutoresizingMaskIntoConstraints                                                                 = false
        logIn.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive                                            = true
        logIn.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 40).isActive                      = true
        logIn.trailingAnchor.constraint(greaterThanOrEqualTo: view.trailingAnchor,constant: -80).isActive               = true
        logIn.heightAnchor.constraint(equalTo: passwordTextField.heightAnchor).isActive                                 = true

        register.translatesAutoresizingMaskIntoConstraints                                                              = false
        register.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive                                         = true
        register.topAnchor.constraint(equalTo: logIn.bottomAnchor, constant: 40).isActive                               = true
    }
}

//MARK: Projects ViewControoler
extension ProjectsVC {
    
    func collectionViewConstraints(){
        galeryCollectionView.translatesAutoresizingMaskIntoConstraints = false
        galeryCollectionView.topAnchor.constraint(equalTo: view.topAnchor, constant: 60).isActive = true
        galeryCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        galeryCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        galeryCollectionView.heightAnchor.constraint(equalToConstant: 150).isActive = true
     }
    
    func cardViewConstraints(){
        cardView.translatesAutoresizingMaskIntoConstraints = false
        cardView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        cardView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        cardView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 40).isActive = true
        cardView.topAnchor.constraint(equalTo: galeryCollectionView.bottomAnchor).isActive = true
    }
    
    func labelConstraints() {
        workingOnThese.translatesAutoresizingMaskIntoConstraints = false
        workingOnThese.topAnchor.constraint(equalTo: cardView.topAnchor, constant: 20).isActive = true
        workingOnThese.leadingAnchor.constraint(equalTo: cardView.leadingAnchor, constant: 20).isActive = true
        workingOnThese.trailingAnchor.constraint(greaterThanOrEqualTo: cardView.trailingAnchor, constant: 20).isActive = true
        workingOnThese.heightAnchor.constraint(equalToConstant: 30).isActive = true
    }
    
    func profileImageConstraints(){
        profileImage.translatesAutoresizingMaskIntoConstraints = false
        profileImage.topAnchor.constraint(equalTo: cardView.topAnchor, constant: 20).isActive = true
        profileImage.trailingAnchor.constraint(equalTo: cardView.trailingAnchor, constant: -20).isActive = true
        profileImage.heightAnchor.constraint(equalTo: workingOnThese.heightAnchor).isActive = true
        profileImage.widthAnchor.constraint(equalTo: workingOnThese.heightAnchor).isActive = true
    }
    
    func tableViewConstraints(){
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.topAnchor.constraint(equalTo: cardView.topAnchor, constant: 60).isActive = true
        tableView.leadingAnchor.constraint(equalTo: cardView.leadingAnchor, constant: 25).isActive = true
        tableView.trailingAnchor.constraint(equalTo: cardView.trailingAnchor, constant: -25).isActive = true
        tableView.bottomAnchor.constraint(equalTo: cardView.bottomAnchor).isActive = true
    }
    
    func setAddProjectConstraints(){
        
        addProject.translatesAutoresizingMaskIntoConstraints = false
        addProject.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -20).isActive = true
        addProject.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
    }
}

