//
//  ViewController.swift
//  knitting
//
//  Created by Павел Кузин on 26.04.2020.
//  Copyright © 2020 Павел Кузин. All rights reserved.
//

import UIKit
import RealmSwift

class ProjectsController: UIViewController, UITableViewDelegate, UITableViewDataSource{
    
    let cellIdentifire: String = "cell"
    var projects: Results<Project>!
    
    
    @IBOutlet weak var table1: UITableView!
    @IBOutlet weak var addButton: UIButton!

    override func viewDidLoad() {
          super.viewDidLoad()
        projects = realm.objects(Project.self)

        addButton.layer.cornerRadius = addButton.intrinsicContentSize.height / 2
        
        sorting()
      }
    
    // MARK: Table Veiw DataSourse
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return projects.isEmpty ? 0 : projects.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifire, for: indexPath) as! CustomTableViewCell
        let project = projects[indexPath.row]
        cell.nameLabel.text = project.name
        
        if !project.tags.isEmpty {
            cell.tagLabel.text = project.tags[0]
        } else {
            cell.tagLabel.text = ""
        }
        
        cell.imageOfProject.layer.cornerRadius = cell.imageOfProject.frame.size.height / 2
        cell.imageOfProject.clipsToBounds = true
        cell.imageOfProject.image = UIImage(data: project.imageData!)
            return cell
    }
    
    //MARK: DeleteAction
     func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let project = projects[indexPath.row]
        let contextItem = UIContextualAction(style: .destructive, title: "delete") {  (contextualAction, view, boolValue) in
            StorageManager.deleteObject(project)
            tableView.deleteRows(at: [indexPath], with: .automatic)
        }
        let swipeActions = UISwipeActionsConfiguration(actions: [contextItem])
        return swipeActions
    }
    
    //MARK: Sorting
    
      func sorting() {
          projects = projects.sorted(byKeyPath: "date", ascending: false)
          table1.reloadData()
      }
    
    //MARK: UnwindSegue
    @IBAction func unwindSegue(_ segue: UIStoryboardSegue) {
        guard let newProjectVC = segue.source as? NewProjectViewController else { return }
        newProjectVC.saveProject()
        newProjectVC.saveCounter()
        table1.reloadData()
    }
    
    //MARK: Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showDetail" {
            guard let indexPath = table1.indexPathForSelectedRow else {return print("ERROR IN PASSING DATA")}
            let project = projects[indexPath.row]
            let lifeProjectVC = segue.destination as! ProjectLifeController
            lifeProjectVC.currentProject = project
        }
    }
}

