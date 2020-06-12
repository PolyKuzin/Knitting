//
//  ProjectsCell.swift
//  knitting
//
//  Created by Павел Кузин on 22.05.2020.
//  Copyright © 2020 Павел Кузин. All rights reserved.
//

import UIKit
import FirebaseFirestore

class ProjectCell: SwipeableCollectionViewCell {
    
    let reusedID = "ProjectCell"
    var cellView         = UIView()
    var projectNameLabel = UILabel()
    var projectTagsLabel = UILabel()
    var projectImageView = UIImageView()
    var row            : Int?
        
    let deleteImageView: UIImageView = {
        let image = UIImage(named: "delete")?.withRenderingMode(.alwaysTemplate)
        let imageView = UIImageView(image: image)
        imageView.tintColor = .white
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupSubviews()
        backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        configureProjectImageView()
        configureProjectNameLabel()
        configureProjectTagsLabel()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        let shadowPath0 = UIBezierPath(roundedRect: self.bounds, cornerRadius: 20)
        layer.shadowRadius = 20
        layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.12).cgColor
        layer.shadowPath = shadowPath0.cgPath
        layer.shadowOpacity = 0.8
        layer.bounds = self.bounds
        layer.shadowOffset = CGSize(width: 0, height: 8)
        layer.position = self.center
        layer.cornerRadius = 20
        clipsToBounds = false
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
    
    func configureProjectImageView(){
        projectImageView.layer.cornerRadius         = 10
        projectImageView.clipsToBounds              = true
        setProjectImageConstraints()
    }
    
    func configureProjectNameLabel(){
        projectNameLabel.numberOfLines              = 0
        projectNameLabel.adjustsFontSizeToFitWidth  = true
        setProjectNameConstraints()
       }
    func configureProjectTagsLabel(){
        projectTagsLabel.numberOfLines              = 0
        projectTagsLabel.adjustsFontSizeToFitWidth  = true
        setProjectTagsConstraints()
    }
}
extension ProjectCell{
    private func setupSubviews() {
        visibleContainerView.backgroundColor = .white
        visibleContainerView.addSubview(projectTagsLabel)
        visibleContainerView.addSubview(projectNameLabel)
        visibleContainerView.addSubview(projectImageView)
        hiddenContainerView.backgroundColor = UIColor(red: 231.0 / 255.0, green: 76.0 / 255.0, blue: 60.0 / 255.0, alpha: 1)
        hiddenContainerView.addSubview(deleteImageView)
        deleteImageView.translatesAutoresizingMaskIntoConstraints = false
        deleteImageView.centerXAnchor.constraint(equalTo: hiddenContainerView.centerXAnchor).isActive = true
        deleteImageView.centerYAnchor.constraint(equalTo: hiddenContainerView.centerYAnchor).isActive = true
        deleteImageView.widthAnchor.constraint(equalToConstant: 25).isActive = true
        deleteImageView.heightAnchor.constraint(equalToConstant: 30).isActive = true
    }
}
