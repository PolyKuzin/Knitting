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
    var currentNumber: Int? = 5

    var effect: UIVisualEffect?
    var currentProject: Project?
    var counter: Counter?
    var tagLabel: String?
    var countersRows: Int?
    
    @IBOutlet weak var visualEffectView: UIVisualEffectView!
    @IBOutlet weak var addCounterView: UIView!
    @IBOutlet weak var addCounterBTN: UIButton!
    
    @IBOutlet weak var conratulationView: UIView!
    @IBOutlet weak var imGoodBtn: UIButton!
    
    @IBOutlet weak var tag1Label: UILabel!
    @IBOutlet weak var tag2Label: UILabel!
    @IBOutlet weak var tag3Label: UILabel!
    @IBOutlet weak var tag1LabelView: UIView!
    @IBOutlet weak var tag2LabelView: UIView!
    @IBOutlet weak var tag3LabelView: UIView!

    
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
    @IBAction func imGoodButt(_ sender: Any) {
        congratulationsOut()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupLifeScreen()
        projectImage.layer.cornerRadius = 15
        
        addCounterView.layer.cornerRadius = 5
        conratulationView.layer.cornerRadius = 5
        
        tag1LabelView.layer.cornerRadius = 5
        tag1LabelView.clipsToBounds = true
        tag2LabelView.layer.cornerRadius = 5
        tag2LabelView.clipsToBounds = true
        tag3LabelView.layer.cornerRadius = 5 //tag3Label.frame.size.height / 2
        tag3LabelView.clipsToBounds = true
    }
    
    //MARK: CounterTableView
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let cellRows = realm.objects(Counter.self).filter("projectID == %@", currentProject?.projectID as Any).count
        return cellRows
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = counterTable.dequeueReusableCell(withIdentifier: "counterCell", for: indexPath) as! CountersViewCell
        let counter = realm.objects(Counter.self).filter("projectID == %@", currentProject?.projectID as Any)[indexPath.row]
       cell.viewWithTag(1)?.layer.cornerRadius = 10
        cell.counterName.text = counter.name
        cell.plusButt(cell as Any)
        cell.counterNumbers.text = String(counter.rows)
        currentNumber = Int(cell.counterNumbers.text!)!
        cell.plusBtn.tag = indexPath.row
        cell.plusBtn.addTarget(self, action: #selector(self.plusBtnTaped(_:)), for: .touchUpInside)
        cell.minusBtn.addTarget(self, action: #selector(self.minusBtnTaped(_:)), for: .touchUpInside)
        cell.plusBtn.isUserInteractionEnabled = true
        cell.isSelected = false
        
    return cell
    }
     @objc func plusBtnTaped (_ sender: UIButton) {
            let tag = sender.tag
            let indexPath = IndexPath(row: tag, section: 0)
            let cell = counterTable.dequeueReusableCell(withIdentifier: "counterCell", for: indexPath) as! CountersViewCell
            let currentCounter = realm.objects(Counter.self).filter("projectID == %@", currentProject?.projectID as Any)[indexPath.row]
            cell.counterNumbers.text = String(currentCounter.rows + 1)
            StorageManager.saveRowsInCounter(currentCounter, Int(cell.counterNumbers.text!)!)
            if currentCounter.rows >= currentCounter.rowsMax {
                congatulatuions()
            }
        }
    @objc func minusBtnTaped(_ sender: UIButton){
        let tag = sender.tag
        let indexPath = IndexPath(row: tag, section: 0)
        let cell = counterTable.dequeueReusableCell(withIdentifier: "counterCell", for: indexPath) as! CountersViewCell
        let currentCounter = realm.objects(Counter.self).filter("projectID == %@", currentProject?.projectID as Any)[indexPath.row]
        cell.counterNumbers.text = String(currentCounter.rows - 1)
        StorageManager.saveRowsInCounter(currentCounter, Int(cell.counterNumbers.text!)!)
        if currentCounter.rows >= currentCounter.rowsMax {
            congatulatuions()
        }
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
                case 1:
                    tag1Label.text = currentProject?.tags[0]
                    tag1Label.isHidden = false
                    tag1LabelView.isHidden = false
                case 2:
                    tag1Label.text = currentProject?.tags[0]
                    tag2Label.text = currentProject?.tags[1]
                    tag1Label.isHidden = false
                    tag1LabelView.isHidden = false
                    tag2Label.isHidden = false
                    tag2LabelView.isHidden = false
                case 3:
                    tag1Label.text = currentProject?.tags[0]
                    tag2Label.text = currentProject?.tags[1]
                    tag3Label.text = currentProject?.tags[2]
                    tag1Label.isHidden = false
                    tag1LabelView.isHidden = false
                    tag2Label.isHidden = false
                    tag2LabelView.isHidden = false
                    tag3Label.isHidden = false
                    tag3LabelView.isHidden = false
                default:
                    tag1Label.isHidden = true
                    tag1LabelView.isHidden = true
                    tag2Label.isHidden = true
                    tag2LabelView.isHidden = true
                    tag3Label.isHidden = true
                    tag3LabelView.isHidden = true
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
        navigationItem.rightBarButtonItems?[1].isEnabled = false
        //navigationItem.rightBarButtonItem?.isEnabled = true
        navigationItem.leftBarButtonItem = nil
    }
    
    //MARK: PopUP Animation
    //ADITING new counter
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
    
    //Congratulatuons
    func congatulatuions() {
        
        self.view.addSubview(conratulationView)
        conratulationView.center = self.view.center
        
        conratulationView.transform = CGAffineTransform(scaleX: 1.3, y: 1.3)
        conratulationView.alpha = 0
        
        UIView.animate(withDuration: 0.4) {
            self.visualEffectView.isHidden = false
            self.visualEffectView.effect = self.effect
            self.conratulationView.alpha = 1
            self.conratulationView.transform = CGAffineTransform.identity
        }
    }
    
    func congratulationsOut() {
        
        UIView.animate(withDuration: 0.4, animations: {
            self.conratulationView.transform = CGAffineTransform(scaleX: 1.3, y: 1.3)
            self.conratulationView.alpha = 0
            self.visualEffectView.isHidden = true
            self.visualEffectView.effect = nil
        }) { (success: Bool) in
            self.conratulationView.removeFromSuperview()
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

