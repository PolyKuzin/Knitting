//
//  ViewController.swift
//  knitting
//
//  Created by Павел Кузин on 26.04.2020.
//  Copyright © 2020 Павел Кузин. All rights reserved.
//

import UIKit
import RealmSwift

class ProjectsController: UIViewController{
    
    let cellIdentifire: String = "cell"
    var projects: Results<Project>!
    var tableView = UITableView()
    
    @IBOutlet weak var addButton: UIButton!
    @IBOutlet weak var workingOnThese: UILabel!
    
    private var galeryCollectionView = GallaryCollectionView()
    
    override func viewDidLoad() {
          super.viewDidLoad()
        view.addSubview(galeryCollectionView)
        
        
        projects = realm.objects(Project.self)
        addButton.layer.cornerRadius = addButton.intrinsicContentSize.height / 2
        sorting()
        
        
        projects = realm.objects(Project.self)
        configureTableView()
        collectionViewConstraints()
      }
    func configureTableView() {
        
        view.addSubview(tableView)
        setTableViewDetegates()
        tableView.rowHeight = 80
        tableView.setConstraints(to: view)
        tableView.register(ProjectsCell.self, forCellReuseIdentifier: "ProjectCell")
        view.sendSubviewToBack(tableView)
    }
    
    func configureCollectionView(){
        
    }
    
    func setTableViewDetegates (){
        
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    //MARK: UnwindSegue
    @IBAction func unwindSegue(_ segue: UIStoryboardSegue) {
        guard let newProjectVC = segue.source as? NewProjectViewController else { return }
        newProjectVC.saveProject()
        newProjectVC.saveCounter()
        tableView.reloadData()
    }
    
    //MARK: Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showDetail" {
            guard let indexPath = tableView.indexPathForSelectedRow else {return print("ERROR IN PASSING DATA")}
            let project = projects[indexPath.row]
            let lifeProjectVC = segue.destination as! ProjectLifeController
            lifeProjectVC.currentProject = project
            tableView.cellForRow(at: indexPath)?.isSelected = false
        }
    }
}

extension ProjectsController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return projects.isEmpty ? 0 : projects.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ProjectCell") as! ProjectsCell
        let project = projects[indexPath.row]
        cell.setCell(project: project)
        
        //        if !project.tags.isEmpty {
        //            cell.tagLabel.text = project.tags[0]
        //        } else {
        //            cell.tagLabel.isHidden = true
        //        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let project = projects[indexPath.row]
        let contextItem = UIContextualAction(style: .destructive, title: "Delete") {  (contextualAction, view, boolValue) in
            for counter in realm.objects(Counter.self).filter("projectID == %@", project.projectID as Any) {
                StorageManager.deleteCounters(counter)
            }
            StorageManager.deleteObject(project)
            tableView.deleteRows(at: [indexPath], with: .automatic)
        }
        let swipeActions = UISwipeActionsConfiguration(actions: [contextItem])
        return swipeActions
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let project = projects[indexPath.row]
        tableView.deselectRow(at: indexPath, animated: true)
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "projectLifeController") as! ProjectLifeController
        vc.modalPresentationStyle = .fullScreen
        vc.currentProject = project
        self.navigationController?.pushViewController(vc, animated: true)

        //self.present(vc, animated: true, completion: nil)
    }

    //MARK: Sorting
      func sorting() {
          projects = projects.sorted(byKeyPath: "date", ascending: false)
          tableView.reloadData()
      }
}

// MARK: Constraints
extension UIView {
    
    func setConstraints(to superview: UIView){
        translatesAutoresizingMaskIntoConstraints = false
        topAnchor.constraint(equalTo: superview.centerYAnchor).isActive = true
        leadingAnchor.constraint(equalTo: superview.leadingAnchor).isActive = true
        trailingAnchor.constraint(equalTo: superview.trailingAnchor).isActive = true
        bottomAnchor.constraint(equalTo: superview.bottomAnchor).isActive = true
    }
}

extension ProjectsController {
    
    func collectionViewConstraints(){
         galeryCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
         galeryCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
         galeryCollectionView.topAnchor.constraint(equalTo: view.topAnchor, constant: 80).isActive = true
         galeryCollectionView.bottomAnchor.constraint(equalTo: workingOnThese.topAnchor, constant: -10).isActive = true
         galeryCollectionView.heightAnchor.constraint(equalToConstant: 250).isActive = true
     }
}
