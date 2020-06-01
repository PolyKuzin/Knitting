//
//  ProjectsCell.swift
//  knitting
//
//  Created by Павел Кузин on 22.05.2020.
//  Copyright © 2020 Павел Кузин. All rights reserved.
//

import UIKit
import FirebaseFirestore

class ProjectCell: UICollectionViewCell {
    
    var cellView         = UIView()
    var projectNameLabel = UILabel()
    var projectTagsLabel = UILabel()
    var projectImageView = UIImageView()
    
    let reusedID = "ProjectCell"
    
    override init(frame: CGRect) {
        super.init(frame: frame)
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
               
        self.layer.cornerRadius = 20
        self.layer.shadowRadius = 20
        self.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.12).cgColor
        layer.shadowPath = shadowPath0.cgPath
        layer.shadowOpacity = 0.8
        layer.bounds = self.bounds
        layer.shadowOffset = CGSize(width: 0, height: 8)
        layer.position = self.center
               
        self.clipsToBounds = false
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
    
    func configureCellView(){
        cellView.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width - 50,
                                            height: UIScreen.main.bounds.height / 7)
        cellView.backgroundColor = .blue
        cellView.layer.cornerRadius                 = 20
        cellView.clipsToBounds                      = true
        addSubview(cellView)
        bringSubviewToFront(cellView)
    }
    
    func configureProjectImageView(){
        addSubview(projectImageView)
        projectImageView.layer.cornerRadius         = 10
        projectImageView.clipsToBounds              = true
        setProjectImageConstraints()
    }
    
    func configureProjectNameLabel(){
        addSubview(projectNameLabel)
        projectNameLabel.numberOfLines              = 0
        projectNameLabel.adjustsFontSizeToFitWidth  = true
        setProjectNameConstraints()
       }
    func configureProjectTagsLabel(){
        addSubview(projectTagsLabel)
        projectTagsLabel.numberOfLines              = 0
        projectTagsLabel.adjustsFontSizeToFitWidth  = true
        setProjectTagsConstraints()
    }
}

//class ProjectsCellLLLLLLLLLLLL: UICollectionViewCell {
//    
//    var cellView         = UIView()
//    var projectNameLabel = UILabel()
//    var projectTagsLabel = UILabel()
//    var projectImageView = UIImageView()
//
//    override init(frame: CGRect) {
//        super.init(frame: frame)
//        configureCellView()
//        configureProjectImageView()
//        configureProjectNameLabel()
//        configureProjectTagsLabel()
//    }
//    
//    required init?(coder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
//    
//    func setCell(project: ProjectToKnit, indexPath: Int){
//        let image = project.imageData.toImage()
//        projectImageView.image = image
//        projectNameLabel.text  = project.name
//        if !project.tags.isEmpty {
//            projectTagsLabel.text = project.tags
//        } else {
//            projectTagsLabel.isHidden = true
//        }
//    }
//    func configureCellView(){
//        cellView.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width - 50,
//                                            height: UIScreen.main.bounds.height / 7)
//        cellView.backgroundColor = .blue
//        cellView.layer.cornerRadius                 = 20
//        cellView.clipsToBounds                      = true
//        addSubview(cellView)
//        //setCellViewConstraints()
//        bringSubviewToFront(cellView)
//    }
//    
//    func configureProjectImageView(){
//        cellView.addSubview(projectImageView)
//        projectImageView.layer.cornerRadius         = 10
//        projectImageView.clipsToBounds              = true
//        setProjectImageConstraints()
//    }
//    
//    func configureProjectNameLabel(){
//        cellView.addSubview(projectNameLabel)
//        projectNameLabel.numberOfLines              = 0
//        projectNameLabel.adjustsFontSizeToFitWidth  = true
//        setProjectNameConstraints()
//       }
//    func configureProjectTagsLabel(){
//        cellView.addSubview(projectTagsLabel)
//        projectTagsLabel.numberOfLines              = 0
//        projectTagsLabel.adjustsFontSizeToFitWidth  = true
//        setProjectTagsConstraints()
//    }
//}
//
////MARK: Confuguring the content
//extension ProjectsCellLLLLLLLLLLLL {
//    
//    func configureCellView(){
//        cellView.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width - 50,
//                                            height: UIScreen.main.bounds.height / 7)
//        cellView.backgroundColor = .blue
//        cellView.layer.cornerRadius                 = 20
//        cellView.clipsToBounds                      = true
//        addSubview(cellView)
//        //setCellViewConstraints()
//        bringSubviewToFront(cellView)
//    }
//    
//    func configureProjectImageView(){
//        cellView.addSubview(projectImageView)
//        projectImageView.layer.cornerRadius         = 10
//        projectImageView.clipsToBounds              = true
//        setProjectImageConstraints()
//    }
//    
//    func configureProjectNameLabel(){
//        cellView.addSubview(projectNameLabel)
//        projectNameLabel.numberOfLines              = 0
//        projectNameLabel.adjustsFontSizeToFitWidth  = true
//        setProjectNameConstraints()
//       }
//    func configureProjectTagsLabel(){
//        cellView.addSubview(projectTagsLabel)
//        projectTagsLabel.numberOfLines              = 0
//        projectTagsLabel.adjustsFontSizeToFitWidth  = true
//        setProjectTagsConstraints()
//    }
//}
