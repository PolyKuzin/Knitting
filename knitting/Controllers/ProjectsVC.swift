//
//  ViewController.swift
//  knitting
//
//  Created by Павел Кузин on 26.04.2020.
//  Copyright © 2020 Павел Кузин. All rights reserved.
//

import UIKit
import Firebase

class ProjectsVC: UIViewController {
    
    var ai              : UIActivityIndicatorView = UIActivityIndicatorView()
    var ref             : DatabaseReference!
    var user            : Users!

    let cellIdentifire          = "cell"
    var cardView                = UIView()
    var tableView               = UITableView()
    var workingOnThese          = UILabel()
    var addProject              = UIButton()
    var profileImage            = UIImageView()
    var upStorysCollectionView  = GallaryCollectionView()
    var projectsCollectionView  = ProjectsCollectionView()
    var projects                = Array<ProjectToKnit>()

    
    @IBOutlet weak var addButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        activiryIndicator()
        guard let currentUser = Auth.auth().currentUser else { return }
        user = Users(user: currentUser)
        ref = Database.database().reference(withPath: "users").child(String(user.uid)).child("projects")
        configureAllUI()
      }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        activiryIndicator()

        ref.observe(.value, with: { [weak self] (snapshot) in
            var _projects = Array<ProjectToKnit>()
            for item in snapshot.children {
                let task = ProjectToKnit(snapshot: item as! DataSnapshot)
                _projects.append(task)
            }
            self?.projects = _projects
            self?.tableView.reloadData()
        })
        stopActivityIndicator()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        ref.removeAllObservers()
    }
    
    
//MARK: Configuring
    
    func configureAllUI(){
        configureCollectionView()
        configuratingCardView()
        configureLabel()
        configuringProfileImage()
        configureProjectsCollectionView()
        configureAddProjectBtn()
    }
    
    func configureCollectionView(){
        view.addSubview(upStorysCollectionView)
        collectionViewConstraints()
    }
    
    func configuratingCardView(){
        shadowsToView(view: cardView)
        cardView.backgroundColor = .white
        cardView.layer.cornerRadius = 20
        cardView.clipsToBounds = true
        view.addSubview(cardView)
        view.sendSubviewToBack(cardView)
        cardViewConstraints()
    }
    
    func configureLabel(){
        cardView.addSubview(workingOnThese)
        labelConstraints()
        workingOnThese.text = "Working on this?"
        workingOnThese.font = UIFont(name: "Helvetica", size: 25)
    }
    
    func configuringProfileImage(){
        
        profileImage.backgroundColor = .black
        profileImage.frame = CGRect(x: 0, y: 0, width: 40, height: 40)
        cardView.addSubview(profileImage)
        profileImageConstraints()
    }
    
    func configureProjectsCollectionView(){
        
        cardView.addSubview(projectsCollectionView)
        setProjectsCollectionViewConstraints()
//        setTableViewDetegates()
//        sorting()
//        tableView.backgroundView?.isOpaque = true
//        tableView.backgroundColor = .white
//        tableView.separatorStyle = .none
//        tableView.rowHeight = UIScreen.main.bounds.height / 6
//        cardView.bringSubviewToFront(projectsCollectionView)
//        tableViewConstraints()
//        tableView.register(ProjectsCell.self, forCellReuseIdentifier: "ProjectCell")
    }
    
    func configureAddProjectBtn(){
        
        addProject.setImage(#imageLiteral(resourceName: "Add"), for: .normal)
        //addProject.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width - 500, height: UIScreen.main.bounds.size.height / 2)
        addProject.addTarget(self, action: #selector(showNewProjectVC), for: .touchUpInside)
        view.addSubview(addProject)
        setAddProjectConstraints()
    }
    
    @objc func showNewProjectVC(){
        let viewController : UIViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "CreateProjectVC") as! CreateProjectVC
        self.present(viewController, animated: true, completion: nil)
    }

//MARK: Activity Indicator
    func activiryIndicator(){
        
        ai.center = self.view.center
        ai.hidesWhenStopped = true
        ai.style = UIActivityIndicatorView.Style.large
        view.addSubview(ai)
        ai.startAnimating()
    }
    func stopActivityIndicator(){
        ai.stopAnimating()
    }
    
    @IBAction func signOut(_ sender: UIBarButtonItem) {
        do {
            try Auth.auth().signOut()
        } catch {
            print(error.localizedDescription)
        }
        dismiss(animated: true, completion: nil)
    }
    
//MARK: Navigation
    @IBAction func unwindSegue(_ segue: UIStoryboardSegue) {
        guard let newProjectVC = segue.source as? CreateProjectVC else { return }
        newProjectVC.saveProject()
        newProjectVC.saveCounter()
        tableView.reloadData()
    }
}
