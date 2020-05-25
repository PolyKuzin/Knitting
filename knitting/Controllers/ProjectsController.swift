//
//  ViewController.swift
//  knitting
//
//  Created by Павел Кузин on 26.04.2020.
//  Copyright © 2020 Павел Кузин. All rights reserved.
//

import UIKit
import Firebase
import RealmSwift

class ProjectsController: UIViewController{
    
    let cellIdentifire: String = "cell"
    var projects: Results<Project>!
    var tableView = UITableView()
    var workingOnThese = UILabel()
    @IBOutlet weak var addButton: UIButton!
    //@IBOutlet weak var workingOnThese: UILabel!
    
    private var galeryCollectionView = GallaryCollectionView()
    
    override func viewDidLoad() {
          super.viewDidLoad()
        //checkAuth()
        
        projects = realm.objects(Project.self)
        addButton.layer.cornerRadius = addButton.intrinsicContentSize.height / 2
    
        configureTableView()
        configureCollectionView()
        configureLabel()
      }
    func configureTableView() {
        
        view.addSubview(tableView)
        setTableViewDetegates()
        sorting()
        tableView.rowHeight = 80
        tableViewConstraints()
        tableView.register(ProjectsCell.self, forCellReuseIdentifier: "ProjectCell")
        view.sendSubviewToBack(tableView)
    }
    
    func configureCollectionView(){
        view.addSubview(galeryCollectionView)

        collectionViewConstraints()
    }
    func configureLabel(){
        view.addSubview(workingOnThese)
        labelConstraints()
        workingOnThese.text = "Working on this?"
        
    }
    
    func setTableViewDetegates (){
        
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    @IBAction func signOut(_ sender: UIBarButtonItem) {
        do {
            try Auth.auth().signOut()
        } catch {
            print(error.localizedDescription)
        }
        dismiss(animated: true, completion: nil)
    }
    //MARK: UnwindSegue
    @IBAction func unwindSegue(_ segue: UIStoryboardSegue) {
        guard let newProjectVC = segue.source as? NewProjectViewController else { return }
        newProjectVC.saveProject()
        newProjectVC.saveCounter()
        tableView.reloadData()
    }
}
//MARK: TableView
extension ProjectsController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return projects.isEmpty ? 0 : projects.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ProjectCell") as! ProjectsCell
        let project = projects[indexPath.row]
        cell.setCell(project: project)
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
    }

    //MARK: Sorting
      func sorting() {
          projects = projects.sorted(byKeyPath: "date", ascending: false)
          tableView.reloadData()
      }
}

// MARK: Constraints
extension ProjectsController {
    
    func tableViewConstraints(){
        //let screenSize: CGRect = UIScreen.main.bounds
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.topAnchor.constraint(equalTo: view.centerYAnchor, constant: -80).isActive = true
        tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }
    
    func collectionViewConstraints(){
        galeryCollectionView.translatesAutoresizingMaskIntoConstraints = false
        galeryCollectionView.topAnchor.constraint(equalTo: view.topAnchor, constant: 80).isActive = true
        galeryCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        galeryCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        galeryCollectionView.heightAnchor.constraint(equalToConstant: 250).isActive = true
     }
    
    func labelConstraints() {
        workingOnThese.translatesAutoresizingMaskIntoConstraints = false
        workingOnThese.topAnchor.constraint(equalTo: galeryCollectionView.bottomAnchor, constant: 5).isActive = true
        workingOnThese.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
        workingOnThese.trailingAnchor.constraint(greaterThanOrEqualTo: view.trailingAnchor, constant: 20).isActive = true
    }
}
