//
//  ProjectsCell.swift
//  knitting
//
//  Created by Павел Кузин on 22.05.2020.
//  Copyright © 2020 Павел Кузин. All rights reserved.
//

import UIKit
import RealmSwift

class ProjectsCell: UITableViewCell {
    
    var projectImageView = UIImageView()
    var projectNameLabel = UILabel()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addSubview(projectImageView)
        addSubview(projectNameLabel)
        
        configueProjectImageView()
        configueProjectNameLabel()
        setProjectImageConstraints()
        setProjectNameConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func setCell(project: Project){
        
        let image = UIImage(data: project.imageProject!)
        projectImageView.image = image
        projectNameLabel.text = project.name
    }
    
    func configueProjectImageView(){
        
        projectImageView.layer.cornerRadius = 10
        projectImageView.clipsToBounds      = true
    }
    
    func configueProjectNameLabel(){
           
        projectNameLabel.numberOfLines = 0
        projectNameLabel.adjustsFontSizeToFitWidth = true
       }
    
    func setProjectImageConstraints(){
        
        projectImageView.translatesAutoresizingMaskIntoConstraints                                                  = false
        projectImageView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive                                  = true
        projectImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20).isActive                    = true
        projectImageView.heightAnchor.constraint(equalToConstant: 70).isActive                                      = true
        projectImageView.widthAnchor.constraint(equalToConstant: 70).isActive                                       = true
    }
    
    func setProjectNameConstraints(){
        
        projectNameLabel.translatesAutoresizingMaskIntoConstraints                                                  = false
        projectNameLabel.centerYAnchor.constraint(equalTo: centerYAnchor, constant: -20).isActive                                  = true
        projectNameLabel.leadingAnchor.constraint(equalTo: projectImageView.trailingAnchor, constant: 20).isActive  = true
        projectNameLabel.heightAnchor.constraint(equalToConstant: 25).isActive                   = true
        projectNameLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -12).isActive                 = true
    }
}

