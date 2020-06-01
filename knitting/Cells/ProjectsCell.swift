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
    
    let mainImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = #colorLiteral(red: 0.2745098174, green: 0.4862745106, blue: 0.1411764771, alpha: 1)
        imageView.translatesAutoresizingMaskIntoConstraints = false

        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(mainImageView)
        configureCellView()
        configureProjectImageView()
        configureProjectNameLabel()
        configureProjectTagsLabel()

        
        mainImageView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        mainImageView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        mainImageView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        mainImageView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true

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
    
    func configureCellView(){
        cellView.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width - 50,
                                            height: UIScreen.main.bounds.height / 7)
        cellView.backgroundColor = .blue
        cellView.layer.cornerRadius                 = 20
        cellView.clipsToBounds                      = true
        addSubview(cellView)
        //setCellViewConstraints()
        bringSubviewToFront(cellView)
    }
    
    func configureProjectImageView(){
        cellView.addSubview(projectImageView)
        projectImageView.layer.cornerRadius         = 10
        projectImageView.clipsToBounds              = true
        setProjectImageConstraints()
    }
    
    func configureProjectNameLabel(){
        cellView.addSubview(projectNameLabel)
        projectNameLabel.numberOfLines              = 0
        projectNameLabel.adjustsFontSizeToFitWidth  = true
        setProjectNameConstraints()
       }
    func configureProjectTagsLabel(){
        cellView.addSubview(projectTagsLabel)
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
