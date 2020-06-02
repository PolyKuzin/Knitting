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
    let layout = UICollectionViewFlowLayout()
    var collectionViewForProjects = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
//    var projectsCollectionView  = ProjectsCollectionView()
    //var collectionViewForProjects = UICollectionView()
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
            self?.collectionViewForProjects.reloadData()
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
//        configureProjectsCollectionView()
        configureAddProjectBtn()
        configureCollectionViewForProjects()
        
    }
    
    func configureCollectionView(){
        view.addSubview(upStorysCollectionView)
        view.sendSubviewToBack(upStorysCollectionView)
        collectionViewConstraints()
    }
    
    func configuratingCardView(){
        //shadowsToView(view: cardView)
        cardView.backgroundColor = .white
//        cardView.layer.cornerRadius = 40
//        //cardView.layer.shadowRadius = 5
//        cardView.layer.shadowOpacity = 1
//        cardView.layer.shadowColor =  UIColor(red: 1, green: 1, blue: 1, alpha: 0.12).cgColor
//        cardView.layer.shadowOffset = CGSize(width: 0, height: 8)
//        cardView.layer.bounds = cardView.bounds
//        cardView.layer.position = cardView.center
//        cardView.clipsToBounds = false
        view.addSubview(cardView)
        view.bringSubviewToFront(cardView)
        cardViewConstraints()
    }
    
    func configureLabel(){
        cardView.addSubview(workingOnThese)
        labelConstraints()
        cardView.bringSubviewToFront(workingOnThese)
        workingOnThese.text = "Working on this?"
        workingOnThese.font = UIFont(name: "SF Pro Rounded", size: 28)
    }
    
    func configuringProfileImage(){
        
        profileImage.backgroundColor = .black
        profileImage.frame = CGRect(x: 0, y: 0, width: 40, height: 40)
        cardView.addSubview(profileImage)
        cardView.bringSubviewToFront(profileImage)
        profileImageConstraints()
    }
    
//    func configureProjectsCollectionView(){
//
//        cardView.addSubview(projectsCollectionView)
//        cardView.sendSubviewToBack(projectsCollectionView)
//        setProjectsCollectionViewConstraints()
//    }
    
    func configureAddProjectBtn(){
        
        addProject.setImage(#imageLiteral(resourceName: "Add"), for: .normal)
        addProject.addTarget(self, action: #selector(showNewProjectVC), for: .touchUpInside)
        view.addSubview(addProject)
        let shadowPath0 = UIBezierPath(roundedRect: addProject.bounds, cornerRadius: 37)
        let layer0 = CALayer()
        layer0.shadowPath = shadowPath0.cgPath
        layer0.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.2).cgColor
        layer0.shadowOpacity = 1
        layer0.shadowRadius = 10
        layer0.shadowOffset = CGSize(width: 0, height: 4)
        layer0.bounds = addProject.bounds
        layer0.position = addProject.center
        addProject.layer.addSublayer(layer0)
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
