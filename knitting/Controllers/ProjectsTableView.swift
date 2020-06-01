//
//  ProjectsTableView.swift
//  knitting
//
//  Created by Павел Кузин on 28.05.2020.
//  Copyright © 2020 Павел Кузин. All rights reserved.
//

import UIKit
import Firebase

class ProjectsCollectionView: UICollectionView, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    var projects                = Array<ProjectToKnit>()
    var ref                     : DatabaseReference!
    var user                    : Users!
    
    init() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        super.init(frame: .zero, collectionViewLayout: layout)
        backgroundColor = #colorLiteral(red: 0.2196078449, green: 0.007843137719, blue: 0.8549019694, alpha: 1)
        delegate = self
        dataSource = self
        register(ProjectCell.self, forCellWithReuseIdentifier: "ProjectCell")
        translatesAutoresizingMaskIntoConstraints = false
        
        layout.minimumLineSpacing = 10
        contentInset = UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20)
        
        showsHorizontalScrollIndicator = false
        showsVerticalScrollIndicator = false
        
    guard let currentUser = Auth.auth().currentUser else { return }
    user = Users(user: currentUser)
    ref = Database.database().reference(withPath: "users").child(String(user.uid)).child("projects")
        ref.observe(.value, with: { [weak self] (snapshot) in
            var _projects = Array<ProjectToKnit>()
            for item in snapshot.children {
                let task = ProjectToKnit(snapshot: item as! DataSnapshot)
                _projects.append(task)
            }
            self?.projects = _projects
            self?.reloadData()
        })
        print("Inition complete")
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        print(projects.count)
        return projects.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = dequeueReusableCell(withReuseIdentifier: "ProjectCell", for: indexPath)  as! ProjectCell
        let project = projects[indexPath.row]
        cell.setCell(project: project, indexPath : indexPath.row)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: UIScreen.main.bounds.width - 40, height: UIScreen.main.bounds.height / 5.2)
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = dequeueReusableCell(withReuseIdentifier: "ProjectCell", for: indexPath)  as! ProjectCell
        let project = projects[indexPath.row]
        self.deselectItem(at: indexPath, animated: true)
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "projectLifeController") as! CountersVC
        vc.modalPresentationStyle = .fullScreen
        vc.currentProject = project
        
        print("!!!!")
    }
}



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
