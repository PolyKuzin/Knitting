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

    let cellIdentifire              = "cell"
    var cardView                    = UIView()
    var tableView                   = UITableView()
    var workingOnThese              = UILabel()
    var addProject                  = UIButton()
    var viewToBtn                   = UIView()
    var profileImage                = UIImageView()
    var upStorysCollectionView      = GallaryCollectionView()
    let layout                      = UICollectionViewFlowLayout()
    var collectionViewForProjects   = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
    var projects                    = Array<ProjectToKnit>()
    
    let darkBackground = UIView()
    let closeLabel = UILabel()

    @IBOutlet weak var profileView   : UIView!
    @IBOutlet weak var nameAccount   : UILabel!
    @IBOutlet weak var emailAccount  : UILabel!
    @IBOutlet weak var signOutBtn    : UIButton!
    @IBOutlet weak var deleteAccount : UIButton!
    
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
                let project = ProjectToKnit(snapshot: item as! DataSnapshot)
                _projects.append(project)
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
        setStorysCollectionView()
        configuratingCardView()
        configureLabel()
        configuringProfileImage()
        configureAddProjectBtn()
        configureCollectionViewForProjects()
    }
    
    func setStorysCollectionView(){
        view.addSubview(upStorysCollectionView)
        view.sendSubviewToBack(upStorysCollectionView)
        collectionViewConstraints()
    }
    
    func configuratingCardView(){
        cardView.backgroundColor        = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        cardView.frame                  = .zero
        cardView.layer.shadowColor      = UIColor(red: 0, green: 0, blue: 0, alpha: 0.2).cgColor
        cardView.layer.shadowOpacity    = 0.3
        cardView.layer.shadowOffset     = CGSize(width: 0, height: -20)
        cardView.layer.shadowRadius     = 4
        cardView.layer.shouldRasterize  = true
        cardView.layer.masksToBounds    = false
        cardView.layer.maskedCorners    = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
        
        cardView.layer.cornerRadius     = 30
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
        profileImage.image = #imageLiteral(resourceName: "Profile-1")
        profileImage.frame = .zero
        cardView.addSubview(profileImage)
        cardView.bringSubviewToFront(profileImage)
        profileImageConstraints()
        profileImage.isUserInteractionEnabled = true
        let profileTap = UITapGestureRecognizer(target: self, action: #selector(showProfileView))
        profileImage.addGestureRecognizer(profileTap)
        
//        let outProfile = UITapGestureRecognizer(target: self, action: #selector(outProfileView))
//        self.view.addGestureRecognizer(outProfile)
    }
    
    @objc func showProfileView() {
        animateIn()
    }
    
    @objc func outProfileView() {
        animatedOut()
    }
    
    func animateIn() {
        self.view.addSubview(profileView)
        setProfileViewConstraints()
        darkBackground.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1)
        darkBackground.alpha = 0.7
        self.view.addSubview(darkBackground)
        darkBackground.addSubview(closeLabel)
        setDarkBackGroundConstraints()
        
        self.view.bringSubviewToFront(profileView)
        profileView.transform = CGAffineTransform(translationX: 0, y: profileView.frame.height)
        profileView.alpha                  = 0
        profileView.layer.cornerRadius     = 20
        profileView.layer.masksToBounds    = false
        profileView.layer.maskedCorners    = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
            
        UIView.animate(withDuration: 0.3) {
            self.darkBackground.alpha = 0.7
            self.profileView.alpha = 1
            self.profileView.transform = CGAffineTransform.identity
            }
        }
        
        func animatedOut() {
            UIView.animate(withDuration: 0.4, animations: {
                self.profileView.transform = CGAffineTransform(scaleX: 1.3, y: 1.3)
                self.profileView.alpha = 0
    //            self.visualEffectView.isHidden = true
    //            self.visualEffectView.effect = nil
            }) { (success: Bool) in
                self.profileView.removeFromSuperview()
            }
        }
    
    func configureAddProjectBtn(){
    
        viewToBtn.addSubview(addProject)
        view.addSubview(viewToBtn)
        viewToBtn.bringSubviewToFront(addProject)
        view.bringSubviewToFront(viewToBtn)
        setViewToBtnConstraints()
        setAddProjectConstraints()

        addProject.setImage(#imageLiteral(resourceName: "Add"), for: .normal)
        addProject.addTarget(self, action: #selector(showNewProjectVC), for: .touchUpInside)
       
        viewToBtn.frame = CGRect(x: 0, y: 0, width: 110, height: 60)
        viewToBtn.backgroundColor = .white
        viewToBtn.layer.cornerRadius = viewToBtn.frame.size.height / 2
        viewToBtn.clipsToBounds = true
        addProject.frame = viewToBtn.frame
        
        viewToBtn.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.2).cgColor
        viewToBtn.layer.shadowOpacity = 1
        viewToBtn.layer.shadowOffset = CGSize.zero
        viewToBtn.layer.shadowRadius = 10
        viewToBtn.layer.shouldRasterize = true
        viewToBtn.layer.masksToBounds = false
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(showNewProjectVC))
        viewToBtn.addGestureRecognizer(tap)

    }
    
    @objc func showNewProjectVC(){
        viewToBtn.springAnimation(viewToBtn)
        addProject.springAnimation(addProject)
        let viewController : UIViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "CreateProjectVC") as! CreateProjectVC
        self.present(viewController, animated: true, completion: nil)
    }

//MARK: Activity Indicator
    func activiryIndicator(){
        
        ai.center = self.view.center
        ai.hidesWhenStopped = true
        ai.style = UIActivityIndicatorView.Style.large
        ai.color = .black
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
