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
    
    var cellView         = UIView()
    var projectNameLabel = UILabel()
    var projectTagsLabel = UILabel()
    var projectImageView = UIImageView()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureCellView()
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
    
    func configureCellView(){
        cellView.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width - 50, height: UIScreen.main.bounds.height / 7)
        cellView.backgroundColor = .blue
        cellView.layer.cornerRadius = 20
        cellView.clipsToBounds = true
        addSubview(cellView)
        bringSubviewToFront(cellView)
    }
    
    func configureProjectImageView(){
        cellView.addSubview(projectImageView)
        projectImageView.layer.cornerRadius = 10
        projectImageView.clipsToBounds      = true
        setProjectImageConstraints()
    }
    
    func configureProjectNameLabel(){
        cellView.addSubview(projectNameLabel)
        projectNameLabel.numberOfLines             = 0
        projectNameLabel.adjustsFontSizeToFitWidth = true
        setProjectNameConstraints()
       }
    func configureProjectTagsLabel(){
        cellView.addSubview(projectTagsLabel)
        projectTagsLabel.numberOfLines             = 0
        projectTagsLabel.adjustsFontSizeToFitWidth = true
        setProjectTagsConstraints()
    }
}

//MARK: Constraints
extension ProjectsCell {
    
    func setCellViewConstraints(){
        
        cellView.translatesAutoresizingMaskIntoConstraints = false
        cellView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        cellView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        cellView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
    }
    
    func setProjectImageConstraints(){
        
        projectImageView.translatesAutoresizingMaskIntoConstraints                                                              = false
        projectImageView.centerYAnchor.constraint(equalTo: cellView.centerYAnchor).isActive                                              = true
        projectImageView.leadingAnchor.constraint(equalTo: cellView.leadingAnchor, constant: 20).isActive                                = true
        projectImageView.heightAnchor.constraint(equalToConstant: 70).isActive                                                  = true
        projectImageView.widthAnchor.constraint(equalToConstant: 70).isActive                                                   = true
    }
    
    func setProjectNameConstraints(){
        
        projectNameLabel.translatesAutoresizingMaskIntoConstraints                                                              = false
        projectNameLabel.centerYAnchor.constraint(equalTo: cellView.centerYAnchor, constant: -20).isActive                               = true
        projectNameLabel.leadingAnchor.constraint(equalTo: projectImageView.trailingAnchor, constant: 20).isActive              = true
        projectNameLabel.heightAnchor.constraint(equalToConstant: 25).isActive                                                  = true
        projectNameLabel.trailingAnchor.constraint(greaterThanOrEqualTo: cellView.leadingAnchor, constant: -12).isActive   = true
    }
    func setProjectTagsConstraints(){
        
        projectTagsLabel.translatesAutoresizingMaskIntoConstraints                                                              = false
        projectTagsLabel.centerYAnchor.constraint(equalTo: cellView.centerYAnchor, constant: 20).isActive                           = true
        projectTagsLabel.leadingAnchor.constraint(equalTo: projectImageView.trailingAnchor, constant: 20).isActive              = true
        projectTagsLabel.heightAnchor.constraint(equalToConstant: 25).isActive                                                  = true
        projectNameLabel.trailingAnchor.constraint(greaterThanOrEqualTo: cellView.leadingAnchor, constant: -12).isActive   = true
    }
    
    
}

