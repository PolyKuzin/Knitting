//
//  ProjectsTableView.swift
//  knitting
//
//  Created by Павел Кузин on 28.05.2020.
//  Copyright © 2020 Павел Кузин. All rights reserved.
//

import UIKit
import Firebase

extension ProjectsVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    func configureCollectionViewForProjects(){
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        view.addSubview(collectionViewForProjects)
        view.sendSubviewToBack(collectionViewForProjects)
        collectionViewForProjects.frame                             = cardView.bounds
        collectionViewForProjects.collectionViewLayout              = layout
        collectionViewForProjects.backgroundColor                   = .white
        collectionViewForProjects.delegate                          = self
        collectionViewForProjects.dataSource                        = self
        collectionViewForProjects.bounds = cardView.bounds
        
        collectionViewForProjects.register(ProjectCell.self, forCellWithReuseIdentifier: "ProjectCell")
        
        layout.minimumLineSpacing = 10
        collectionViewForProjects.contentInset                      = UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20)
        collectionViewForProjects.backgroundColor                   = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        collectionViewForProjects.showsHorizontalScrollIndicator    = false
        collectionViewForProjects.showsVerticalScrollIndicator      = false
        setProjectsCollectionViewConstraints()
        
//Shadows:
        let shadowPath0 = UIBezierPath(roundedRect: collectionViewForProjects.bounds, cornerRadius: 30)
        collectionViewForProjects.layer.shadowPath                  = shadowPath0.cgPath
        collectionViewForProjects.layer.shadowRadius                = 30
        collectionViewForProjects.layer.shadowColor                 = UIColor(red: 1, green: 0, blue: 0, alpha: 1).cgColor
        collectionViewForProjects.layer.shadowOpacity               = 1
        collectionViewForProjects.layer.bounds                      = collectionViewForProjects.bounds
        collectionViewForProjects.layer.shadowOffset                = CGSize(width: 0, height: 8)
        collectionViewForProjects.layer.position                    = collectionViewForProjects.center
//
        collectionViewForProjects.clipsToBounds                     = false
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return projects.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionViewForProjects.dequeueReusableCell(withReuseIdentifier: "ProjectCell", for: indexPath)  as! ProjectCell
        let project = projects[indexPath.row]
        cell.setCell(project: project, indexPath : indexPath.row)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: UIScreen.main.bounds.width - 40, height: UIScreen.main.bounds.height / 5.2)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let project = projects[indexPath.row]
        collectionViewForProjects.deselectItem(at: indexPath, animated: true)
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "projectLifeController") as! CountersVC
        vc.modalPresentationStyle = .fullScreen
        vc.currentProject = project
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

//class ProjectsCollectionView: UICollectionView, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
//
//
//    var projects                = Array<ProjectToKnit>()
//    var ref                     : DatabaseReference!
//    var user                    : Users!
//
//    init() {
//        let layout = UICollectionViewFlowLayout()
//        layout.scrollDirection = .vertical
//        super.init(frame: .zero, collectionViewLayout: layout)
//        backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
//        delegate = self
//        dataSource = self
//        register(ProjectCell.self, forCellWithReuseIdentifier: "ProjectCell")
//        translatesAutoresizingMaskIntoConstraints = false
//
//        layout.minimumLineSpacing = 10
//        contentInset = UIEdgeInsets(top: 80, left: 20, bottom: 20, right: 20)
//        layer.cornerRadius = 30
//        showsHorizontalScrollIndicator = false
//        showsVerticalScrollIndicator = false
//
//    guard let currentUser = Auth.auth().currentUser else { return }
//    user = Users(user: currentUser)
//    ref = Database.database().reference(withPath: "users").child(String(user.uid)).child("projects")
//        ref.observe(.value, with: { [weak self] (snapshot) in
//            var _projects = Array<ProjectToKnit>()
//            for item in snapshot.children {
//                let task = ProjectToKnit(snapshot: item as! DataSnapshot)
//                _projects.append(task)
//            }
//            self?.projects = _projects
//            self?.reloadData()
//        })
//        print("Inition complete")
//    }
//
//    override func layoutSubviews() {
//        super.layoutSubviews()
//        let shadowPath0 = UIBezierPath(roundedRect: self.bounds, cornerRadius: 20)
//
//        self.layer.cornerRadius = 20
//        self.layer.shadowRadius = 20
//        self.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.12).cgColor
//        layer.shadowPath = shadowPath0.cgPath
//        layer.shadowOpacity = 1
//        layer.bounds = self.bounds
//        layer.shadowOffset = CGSize(width: 0, height: 4)
//        layer.position = self.center
//
//        self.clipsToBounds = false
//    }
//
//    required init?(coder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
//
//    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        return projects.count
//    }
//
//    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        let cell = dequeueReusableCell(withReuseIdentifier: "ProjectCell", for: indexPath)  as! ProjectCell
//        let project = projects[indexPath.row]
//        cell.setCell(project: project, indexPath : indexPath.row)
//        return cell
//    }
//
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        return CGSize(width: UIScreen.main.bounds.width - 40, height: UIScreen.main.bounds.height / 5.2)
//    }
//
//
//    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        let project = projects[indexPath.row]
//        self.deselectItem(at: indexPath, animated: true)
//        let storyboard = UIStoryboard(name: "Main", bundle: nil)
//        let vc = storyboard.instantiateViewController(withIdentifier: "projectLifeController") as! CountersVC
//        vc.modalPresentationStyle = .fullScreen
//        vc.currentProject = project
//    }
//
//
//}



//
//import Foundation
//import UIKit
//
//extension ProjectsVC: UITableViewDelegate, UITableViewDataSource {
//    
//    func setTableViewDetegates (){
//        
//        tableView.delegate = self
//        tableView.dataSource = self
//    }
//    
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return projects.count
//    }
//    
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        
//        let cell = tableView.dequeueReusableCell(withIdentifier: "ProjectCell") as! ProjectsCell
//        let project = projects[indexPath.row]
//        cell.setCell(project: project, indexPath : indexPath.row)
//        //cell.contentView.frame = CGRect(x: 0, y: 0, width: cell.frame.size.width, height: cell.frame.size.height)
//        return cell
//    }
////Delete Action
//
//    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
//        return true
//    }
//    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
//        if editingStyle == .delete {
//            let project = projects[indexPath.row]
//            project.ref?.removeValue()
//        }
//    }
//    
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        let project = projects[indexPath.row]
//        tableView.deselectRow(at: indexPath, animated: true)
//        let storyboard = UIStoryboard(name: "Main", bundle: nil)
//        let vc = storyboard.instantiateViewController(withIdentifier: "projectLifeController") as! CountersVC
//        vc.modalPresentationStyle = .fullScreen
//        vc.currentProject = project
//        self.navigationController?.pushViewController(vc, animated: true)
//    }
//
////Sorting
////      func sorting() {
////          projects = projects.sorted(byKeyPath: "date", ascending: false)
////          tableView.reloadData()
////      }
//}
