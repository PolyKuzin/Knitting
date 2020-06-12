//
//  Constraints.swift
//  knitting
//
//  Created by Павел Кузин on 30.05.2020.
//  Copyright © 2020 Павел Кузин. All rights reserved.
//

import UIKit

struct ConstantIdentifires {
    struct Storyboard {
        static let mainVC = "projectsController"
    }
}

struct Colors {
    static let firstColor               = UIColor(red: 0.584, green: 0.475, blue: 0.820, alpha: 1)
    static let secondColor              = UIColor(red: 0.745, green: 0.616, blue: 0.875, alpha: 1)
    static let buttonAsLabel            = UIColor(red: 0.2, green: 0.2, blue: 0.2, alpha: 1)
    static let backgroundForTextFields  = UIColor(red: 0.949, green: 0.949, blue: 0.969, alpha: 1)
    static let borderСolorForTextField  = UIColor(red: 0.82, green: 0.82, blue: 0.839, alpha: 1)
    static let errorTextField           = UIColor(red: 1, green: 0.954, blue: 0.976, alpha: 1)
    static let errorTextFieldBorder     = UIColor(red: 0.962, green: 0.188, blue: 0.467, alpha: 1)
}

struct Fonts {
    static let displayMedium    = "SFProDisplay-Medium"
    static let displayBold      = "SFProDisplay-Bold"
    static let displaySemiBold  = "SFProDisplay-Semibold"
    static let textSemibold     = "SFProText-Semibold"
    static let textRegular      = "SFProText-Regular"
    static let textBold         = "SFProText-Bold"
}

extension UITextField {
    func designTextField(_ textField: UITextField){
        textField.borderStyle = .none
        textField.layer.borderWidth = 0.5
        textField.layer.borderColor = Colors.borderСolorForTextField.cgColor
        textField.layer.cornerRadius = 14
        textField.backgroundColor = Colors.backgroundForTextFields
        textField.layer.masksToBounds   = true
    }
}

extension UIButton {
    func designButton(_ button: UIButton, _ textSize: CGFloat){
        button.tintColor             = .white
        button.titleLabel?.font      = UIFont(name: Fonts.displayMedium, size: textSize)
        button.layer.cornerRadius    = button.frame.size.height / 2
        button.layer.masksToBounds   = true
        button.setGradientBackground(colorOne: Colors.firstColor, colorTwo: Colors.secondColor)
    }
    
    func designButtonAsLabel(_ button: UIButton, _ textSize: CGFloat){
        button.tintColor              = Colors.buttonAsLabel
        switch textSize {
        case 22:
            button.titleLabel?.font   = UIFont(name: Fonts.displaySemiBold, size: textSize)
        case 17:
            button.titleLabel?.font   = UIFont(name: Fonts.textRegular, size: textSize)
        default:
            button.titleLabel?.font   = UIFont(name: Fonts.displaySemiBold, size: textSize)

        }
        
        if textSize == 22 {
        }
    }
}

//MARK: Projects ViewControoler
extension ProjectsVC {
    
    func collectionViewConstraints(){
        upStorysCollectionView.translatesAutoresizingMaskIntoConstraints                                                = false
        upStorysCollectionView.topAnchor.constraint(equalTo: view.topAnchor, constant: 60).isActive                     = true
        upStorysCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive                           = true
        upStorysCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive                         = true
        upStorysCollectionView.heightAnchor.constraint(equalToConstant: UIScreen.main.bounds.height / 4).isActive       = true
     }
    
    func setProjectsCollectionViewConstraints(){
        collectionViewForProjects.translatesAutoresizingMaskIntoConstraints                                            = false
        collectionViewForProjects.topAnchor.constraint(equalTo: cardView.bottomAnchor).isActive = true
        collectionViewForProjects.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive                         = true
        collectionViewForProjects.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive                       = true
        collectionViewForProjects.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive                     = true
    }
    
    func cardViewConstraints(){
        cardView.translatesAutoresizingMaskIntoConstraints                                                              = false
        cardView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive                                         = true
        cardView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive                                       = true
        cardView.topAnchor.constraint(equalTo: upStorysCollectionView.bottomAnchor).isActive                            = true
        cardView.heightAnchor.constraint(equalToConstant: 60).isActive                                                  = true
    }
    
    func labelConstraints() {
        workingOnThese.translatesAutoresizingMaskIntoConstraints                                                        = false
        workingOnThese.topAnchor.constraint(equalTo: cardView.topAnchor, constant: 20).isActive                         = true
        workingOnThese.leadingAnchor.constraint(equalTo: cardView.leadingAnchor, constant: 20).isActive                 = true
        workingOnThese.trailingAnchor.constraint(greaterThanOrEqualTo: cardView.trailingAnchor, constant: 20).isActive  = true
        workingOnThese.heightAnchor.constraint(equalToConstant: 30).isActive                                            = true
    }
    
    func profileImageConstraints(){
        profileImage.translatesAutoresizingMaskIntoConstraints                                                          = false
        profileImage.topAnchor.constraint(equalTo: cardView.topAnchor, constant: 20).isActive                           = true
        profileImage.trailingAnchor.constraint(equalTo: cardView.trailingAnchor, constant: -20).isActive                = true
        profileImage.heightAnchor.constraint(equalTo: workingOnThese.heightAnchor).isActive                             = true
        profileImage.widthAnchor.constraint(equalTo: workingOnThese.heightAnchor).isActive                              = true
    }
    
    func setAddProjectConstraints(){
        
        addProject.translatesAutoresizingMaskIntoConstraints                                                            = false
        addProject.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -30).isActive                          = true
        addProject.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive                                       = true
    }
}

//MARK: ProjectCell
extension ProjectCell {
    
    func setCellViewConstraints(){
        
        cellView.translatesAutoresizingMaskIntoConstraints = false
        //cellView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 20).isActive = true
        cellView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        cellView.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        //cellView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: -20).isActive = true
    }
    
    func setProjectImageConstraints(){
        
        projectImageView.translatesAutoresizingMaskIntoConstraints                                                              = false
        projectImageView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive                                           = true
        projectImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20).isActive                                = true
        projectImageView.heightAnchor.constraint(equalToConstant: 90).isActive                                                  = true
        projectImageView.widthAnchor.constraint(equalToConstant: 90).isActive                                                   = true
    }
    
    func setProjectNameConstraints(){
        
        projectNameLabel.translatesAutoresizingMaskIntoConstraints                                                              = false
        projectNameLabel.centerYAnchor.constraint(equalTo: centerYAnchor, constant: -20).isActive                               = true
        projectNameLabel.leadingAnchor.constraint(equalTo: projectImageView.trailingAnchor, constant: 20).isActive              = true
        projectNameLabel.heightAnchor.constraint(equalToConstant: 25).isActive                                                  = true
        projectNameLabel.trailingAnchor.constraint(greaterThanOrEqualTo: leadingAnchor, constant: -12).isActive   = true
    }
    func setProjectTagsConstraints(){
        
        projectTagsLabel.translatesAutoresizingMaskIntoConstraints                                                              = false
        projectTagsLabel.centerYAnchor.constraint(equalTo: centerYAnchor, constant: 20).isActive                           = true
        projectTagsLabel.leadingAnchor.constraint(equalTo: projectImageView.trailingAnchor, constant: 20).isActive              = true
        projectTagsLabel.heightAnchor.constraint(equalToConstant: 25).isActive                                                  = true
        projectNameLabel.trailingAnchor.constraint(greaterThanOrEqualTo: leadingAnchor, constant: -12).isActive   = true
    }
}

extension UIView {
    
    func setGradientBackground(colorOne: UIColor, colorTwo: UIColor) {
        
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = bounds
        gradientLayer.colors = [colorOne.cgColor, colorTwo.cgColor]
        gradientLayer.locations = [0.0, 1.0]
        gradientLayer.startPoint = CGPoint(x: 0.5, y: 1.0)
        gradientLayer.endPoint = CGPoint(x: 0.5, y: 0.0)
        
        layer.insertSublayer(gradientLayer, at: 0)
    }
    
    func pinEdgesToSuperView() {
           guard let superView = superview else { return }
           translatesAutoresizingMaskIntoConstraints = false
           topAnchor.constraint(equalTo: superView.topAnchor).isActive = true
           leftAnchor.constraint(equalTo: superView.leftAnchor).isActive = true
           bottomAnchor.constraint(equalTo: superView.bottomAnchor).isActive = true
           rightAnchor.constraint(equalTo: superView.rightAnchor).isActive = true
       }
}
