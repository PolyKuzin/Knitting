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
    //@IBOutlet weak var countersView: UIView!
    @IBOutlet weak var addCounterBTN: UIButton!
    //@IBOutlet weak var tagTable: UITableView!
    
    @IBOutlet weak var tag1Label: UILabel!
    @IBOutlet weak var tag2Label: UILabel!
    @IBOutlet weak var tag3Label: UILabel!

    @IBOutlet weak var projectImage: UIImageView!
    @IBOutlet weak var countersNameField: UITextField!
    @IBOutlet weak var countersRowsField: UITextField!
    
    @IBOutlet weak var counterTable: UITableView!
    
    //MARK: PopUP
    @IBAction func addCounter (_ sender: Any){
         animateIn()
    }
    @IBAction func dismissPopUp(_ sender: Any) {
        if !countersNameField.text!.isEmpty {
            insertNewCounter()
        }
        animatedOut()
    }
    @IBAction func cancelCounter(_ sender: Any) {
        animatedOut()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupLifeScreen()
        projectImage.layer.cornerRadius = 15
    }
    
    //MARK: CounterTableView
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let cellRows = realm.objects(Counter.self).filter("projectID == %@", currentProject?.projectID as Any).count
        return cellRows
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = counterTable.dequeueReusableCell(withIdentifier: "counterCell", for: indexPath) as! CountersViewCell
        let counter = realm.objects(Counter.self).filter("projectID == %@", currentProject?.projectID as Any)[indexPath.row]
        cell.counterName.text = counter.name
        cell.plusButt(cell as Any)
        cell.counterNumbers.text = String(counter.rows)
        cell.viewWithTag(1)?.layer.cornerRadius = 10
        
    return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let currentCounter = realm.objects(Counter.self).filter("projectID == %@", currentProject?.projectID as Any)[indexPath.row]
        let cell = counterTable.cellForRow(at: indexPath) as? CountersViewCell
        let rows = Int((cell?.counterNumbers.text!)!)
        
        StorageManager.saveRowsInCounter(currentCounter, rows!)
    }
    
    // DeleteAction
     func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let currentCounter = realm.objects(Counter.self).filter("projectID == %@", currentProject?.projectID as Any)[indexPath.row]
        let contextItem = UIContextualAction(style: .destructive, title: "Delete") {  (contextualAction, view, boolValue) in
            StorageManager.deleteCounters(currentCounter)
            tableView.deleteRows(at: [indexPath], with: .automatic)
        }
        let swipeActions = UISwipeActionsConfiguration(actions: [contextItem])
        return swipeActions
    }
    
    func insertNewCounter() {
        saveCounter()

        let indexPath = IndexPath(row: realm.objects(Counter.self).filter("projectID == %@", currentProject?.projectID as Any).count - 1, section: 0)
        counterTable.beginUpdates()
        counterTable.insertRows(at: [indexPath], with: .automatic)
        counterTable.endUpdates()
        
        countersNameField.text = ""
        countersRowsField.text = ""
        
        view.endEditing(true)
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
            counterTable.tableFooterView = UIView()
            
            if !currentProject!.tags.isEmpty {
            // TODO: Rewrite it in For - in cicle
                switch currentProject!.tags.count {
                case 0:
                    break
                case 1:
                    tag1Label.text = currentProject?.tags[0]
                    tag1Label.isHidden = false
                case 2:
                    tag1Label.text = currentProject?.tags[0]
                    tag2Label.text = currentProject?.tags[1]
                    tag1Label.isHidden = false
                    tag2Label.isHidden = false
                case 3:
                    tag1Label.text = currentProject?.tags[0]
                    tag2Label.text = currentProject?.tags[1]
                    tag3Label.text = currentProject?.tags[2]
                    tag1Label.isHidden = false
                    tag2Label.isHidden = false
                    tag3Label.isHidden = false
                default:
                    tag1Label.isHidden = true
                    tag2Label.isHidden = true
                    tag3Label.isHidden = true
                }
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
    func saveCounter() {
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
    }
}

