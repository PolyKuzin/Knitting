//
//  EditProjectController.swift
//  knitting
//
//  Created by Павел Кузин on 28.04.2020.
//  Copyright © 2020 Павел Кузин. All rights reserved.
//

import UIKit
import RealmSwift

class ProjectLifeController: UIViewController, UITableViewDataSource, UITableViewDelegate  {

    let cellIdentifire: String = "tagCell"
    let counterCellIdentifire: String = "counterCell"
    let currentID = Int(Date().timeIntervalSince1970)

    var effect: UIVisualEffect?
    var currentProject: Project?
    var counter: Counter?
    var tagLabel: String?
    var countersRows: Int?
    
    @IBOutlet weak var visualEffectView: UIVisualEffectView!
    @IBOutlet weak var addCounterView: UIView!
    @IBOutlet weak var countersView: UIView!
    @IBOutlet weak var addCounterBTN: UIButton!
    @IBOutlet weak var tagTable: UITableView!
    @IBOutlet weak var projectImage: UIImageView!
    @IBOutlet weak var countersNameField: UITextField!
    @IBOutlet weak var countersRowsField: UITextField!
    
    //MARK: PopUP
    @IBAction func addCounter (_ sender: Any){
         animateIn()
    }
    @IBAction func dismissPopUp(_ sender: Any) {
        if !countersNameField.text!.isEmpty {
            saveProject()
        }
        animatedOut()
        countersNameField.text = ""
        countersRowsField.text = ""
    }
    @IBAction func cancelCounter(_ sender: Any) {
        animatedOut()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupLifeScreen()
        projectImage.layer.cornerRadius = 15
    }
    
    //MARK: TagTableView
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return currentProject!.tags.isEmpty ? 0 : currentProject!.tags.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
            let cell = tagTable.dequeueReusableCell(withIdentifier: cellIdentifire, for: indexPath) as! TagTableViewCell
            cell.projectTag1Cell.text = currentProject?.tags[indexPath.row]
            cell.projectTag1Cell.backgroundColor = #colorLiteral(red: 1, green: 0.3290538788, blue: 0.4662155509, alpha: 1)
            cell.projectTag1Cell.layer.cornerRadius = cell.projectTag1Cell.frame.size.height / 2
            cell.projectTag1Cell.layer.masksToBounds = true
        return cell

    }

    //MARK: Seting UP
    private func setupLifeScreen() {
        if currentProject != nil {
            setUpNavigationBar()
            
            effect = visualEffectView.effect
            visualEffectView.effect = nil
            addCounterView.layer.cornerRadius = 10
            
            guard let data = currentProject?.imageData, let image = UIImage(data: data) else {return}

            projectImage.image = image
            tagTable.tableFooterView = UIView()
            
            if !currentProject!.tags.isEmpty {
                tagTable.isHidden = false
            }
        }
    }
    private func setUpNavigationBar() {
        
        if let topItem = navigationController?.navigationBar.topItem {
            topItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        }
        let title = UIBarButtonItem(title: currentProject?.name, style: .plain, target: self, action: nil)
        navigationItem.rightBarButtonItems?.append(title)
        navigationItem.leftBarButtonItem = nil
    }
    
    //MARK: PopUP Animation
    func animateIn() {
        self.view.addSubview(addCounterView)
        addCounterView.center = self.view.center
        
        addCounterView.transform = CGAffineTransform(scaleX: 1.3, y: 1.3)
        addCounterView.alpha = 0
        
        UIView.animate(withDuration: 0.4) {
            self.visualEffectView.isHidden = false
            self.visualEffectView.effect = self.effect
            self.addCounterView.alpha = 1
            self.addCounterView.transform = CGAffineTransform.identity
        }
    }
    func animatedOut() {
        UIView.animate(withDuration: 0.4, animations: {
            self.addCounterView.transform = CGAffineTransform(scaleX: 1.3, y: 1.3)
            self.addCounterView.alpha = 0
            self.visualEffectView.isHidden = true
            self.visualEffectView.effect = nil
        }) { (success: Bool) in
            self.addCounterView.removeFromSuperview()
        }
    }
    
    //MARK: Saving New Counters
    func saveProject() {
            
       let newCounter = Counter(name: countersNameField.text!,
                                rows: 0,
                                rowsMax: Int(countersRowsField.text!)!,
                                projectID: currentProject!.projectID,
                                counterID: currentID)
        StorageManager.saveCounter(newCounter)
        
    }
    
    // MARK: Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "edit"{
            let editingProjectVC = segue.destination as! NewProjectViewController
            editingProjectVC.editingProject = currentProject
        }
        
        if segue.identifier == "counters" {
            let project = currentProject
            let counterVC = segue.destination as! ProjectLifeConteiner
            counterVC.counterProject = project
            counterVC.view.backgroundColor = #colorLiteral(red: 1, green: 0.3290538788, blue: 0.4662155509, alpha: 1)
            counterVC.counterTable.reloadData()
        }
    }
}

