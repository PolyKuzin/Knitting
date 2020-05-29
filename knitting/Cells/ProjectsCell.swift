//
//  ProjectsCell.swift
//  knitting
//
//  Created by Павел Кузин on 22.05.2020.
//  Copyright © 2020 Павел Кузин. All rights reserved.
//

import UIKit
import FirebaseFirestore
import Kingfisher

class ProjectsCell: UITableViewCell {
    
    var projectImageView = UIImageView()
    var projectNameLabel = UILabel()
    var projectTagsLabel = UILabel()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureProjectImageView()
        configureProjectNameLabel()
        configureProjectTagsLabel()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func setCell(project: ProjectToKnit, indexPath: Int){
        let image = project.imageData.toImage()
        projectImageView.image = image
        projectNameLabel.text  = project.name
        if !project.tags.isEmpty {
            projectTagsLabel.text = project.tags
        } else {
            projectTagsLabel.isHidden = true
        }
    }
}

//MARK: Confuguring the content
extension ProjectsCell {
    
    func configureProjectImageView(){
        addSubview(projectImageView)
        projectImageView.layer.cornerRadius = 10
        projectImageView.clipsToBounds      = true
        setProjectImageConstraints()
    }
    
    func configureProjectNameLabel(){
        addSubview(projectNameLabel)
        projectNameLabel.numberOfLines             = 0
        projectNameLabel.adjustsFontSizeToFitWidth = true
        setProjectNameConstraints()
       }
    func configureProjectTagsLabel(){
        addSubview(projectTagsLabel)
        projectTagsLabel.numberOfLines             = 0
        projectTagsLabel.adjustsFontSizeToFitWidth = true
        setProjectTagsConstraints()
    }
}

//MARK: Constraints
extension ProjectsCell {
    
    func setProjectImageConstraints(){
        
        projectImageView.translatesAutoresizingMaskIntoConstraints                                                              = false
        projectImageView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive                                              = true
        projectImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20).isActive                                = true
        projectImageView.heightAnchor.constraint(equalToConstant: 70).isActive                                                  = true
        projectImageView.widthAnchor.constraint(equalToConstant: 70).isActive                                                   = true
    }
    
    func setProjectNameConstraints(){
        
        projectNameLabel.translatesAutoresizingMaskIntoConstraints                                                              = false
        projectNameLabel.centerYAnchor.constraint(equalTo: centerYAnchor, constant: -20).isActive                               = true
        projectNameLabel.leadingAnchor.constraint(equalTo: projectImageView.trailingAnchor, constant: 20).isActive              = true
        projectNameLabel.heightAnchor.constraint(equalToConstant: 25).isActive                                                  = true
        projectNameLabel.trailingAnchor.constraint(greaterThanOrEqualTo: self.leadingAnchor, constant: -12).isActive   = true
    }
    func setProjectTagsConstraints(){
        
        projectTagsLabel.translatesAutoresizingMaskIntoConstraints                                                              = false
        projectTagsLabel.centerYAnchor.constraint(equalTo: centerYAnchor, constant: 20).isActive                                = true
        projectTagsLabel.leadingAnchor.constraint(equalTo: projectImageView.trailingAnchor, constant: 20).isActive              = true
        projectTagsLabel.heightAnchor.constraint(equalToConstant: 25).isActive                                                  = true
        projectNameLabel.trailingAnchor.constraint(greaterThanOrEqualTo: self.leadingAnchor, constant: -12).isActive   = true
    }
    
    
}

