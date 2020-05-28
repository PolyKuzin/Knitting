//
//  ViewController.swift
//  knitting
//
//  Created by Павел Кузин on 26.04.2020.
//  Copyright © 2020 Павел Кузин. All rights reserved.
//

import UIKit
import Firebase

class ProjectsController: UIViewController{
    
    var ref : DatabaseReference!
    var user: Users!
    let cellIdentifire: String = "cell"
    var tableView = UITableView()
    var workingOnThese = UILabel()
    var projects = Array<ProjectToKnit>()

    
    @IBOutlet weak var addButton: UIButton!
    
    private var galeryCollectionView = GallaryCollectionView()
    
    override func viewDidLoad() {
          super.viewDidLoad()
        addButton.layer.cornerRadius = addButton.intrinsicContentSize.height / 2
        guard let currentUser = Auth.auth().currentUser else { return }
        user = Users(user: currentUser)
        ref = Database.database().reference(withPath: "users").child(String(user.uid)).child("projects")
        
        configureTableView()
        configureCollectionView()
        configureLabel()
      }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        ref.observe(.value, with: { [weak self] (snapshot) in
            var _projects = Array<ProjectToKnit>()
            for item in snapshot.children {
                let task = ProjectToKnit(snapshot: item as! DataSnapshot)
                _projects.append(task)
            }
            self?.projects = _projects
            self?.tableView.reloadData()
        })
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        ref.removeAllObservers()
    }
    func configureTableView() {
        
        view.addSubview(tableView)
        setTableViewDetegates()
//        sorting()
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
        return projects.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ProjectCell") as! ProjectsCell
        let project = projects[indexPath.row]
        cell.setCell(project: project, indexPath : indexPath.row)
        return cell
    }
//Delete Action

    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let project = projects[indexPath.row]
            project.ref?.removeValue()
        }
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

//Sorting
//      func sorting() {
//          projects = projects.sorted(byKeyPath: "date", ascending: false)
//          tableView.reloadData()
//      }
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
