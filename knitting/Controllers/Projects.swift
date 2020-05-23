////
////  Projects.swift
////  knitting
////
////  Created by Павел Кузин on 22.05.2020.
////  Copyright © 2020 Павел Кузин. All rights reserved.
////
//
//import UIKit
//import RealmSwift
//
//class Projects: UIViewController {
//
//    var projects: Results<Project>!
//    var tableView = UITableView()
//    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        projects = realm.objects(Project.self)
//        configureTableView()
//    }
//    
//    func configureTableView() {
//        
//        view.addSubview(tableView)
//        setTableViewDetegates()
//        tableView.rowHeight = 80
//        tableView.setConstraints(to: view)
//        tableView.register(ProjectsCell.self, forCellReuseIdentifier: "ProjectCell")
//    }
//    
//    func setTableViewDetegates (){
//        
//        tableView.delegate = self
//        tableView.dataSource = self
//    }
//}
//
//extension Projects: UITableViewDelegate, UITableViewDataSource {
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return projects.isEmpty ? 0 : projects.count
//    }
//    
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        
//        let cell = tableView.dequeueReusableCell(withIdentifier: "ProjectCell") as! ProjectsCell
//        let project = projects[indexPath.row]
//        cell.setCell(project: project)
//        return cell
//    }
//    
//    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
//        let project = projects[indexPath.row]
//        let contextItem = UIContextualAction(style: .destructive, title: "Delete") {  (contextualAction, view, boolValue) in
//            for counter in realm.objects(Counter.self).filter("projectID == %@", project.projectID as Any) {
//                StorageManager.deleteCounters(counter)
//            }
//            StorageManager.deleteObject(project)
//            tableView.deleteRows(at: [indexPath], with: .automatic)
//        }
//        let swipeActions = UISwipeActionsConfiguration(actions: [contextItem])
//        return swipeActions
//    }
//    
//    //MARK: Sorting
//    
//      func sorting() {
//          projects = projects.sorted(byKeyPath: "date", ascending: false)
//          tableView.reloadData()
//      }
//}
//
//extension UIView {
//    
//    func setConstraints(to superview: UIView){
//        
//        translatesAutoresizingMaskIntoConstraints = false
//        topAnchor.constraint(equalTo: superview.centerYAnchor).isActive = true
//        leadingAnchor.constraint(equalTo: superview.leadingAnchor).isActive = true
//        trailingAnchor.constraint(equalTo: superview.trailingAnchor).isActive = true
//        bottomAnchor.constraint(equalTo: superview.bottomAnchor).isActive = true
//
//    }
//}
