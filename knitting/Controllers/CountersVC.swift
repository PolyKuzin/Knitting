//
//  EditProjectController.swift
//  knitting
//
//  Created by Павел Кузин on 28.04.2020.
//  Copyright © 2020 Павел Кузин. All rights reserved.
//

import UIKit
import Firebase

class CountersVC: UIViewController, UITableViewDataSource, UITableViewDelegate  {

    let cellIdentifire: String = "tagCell"
    let counterCellIdentifire: String = "counterCell"

    var ref : DatabaseReference!
    var user: Users!
    
    var effect: UIVisualEffect?
    var currentProject: ProjectToKnit?
    var counters = Array<CounterToKnit>()
    
//MARK: OUTLETS
    @IBOutlet weak var visualEffectView: UIVisualEffectView!
    @IBOutlet weak var addCounterView: UIView!
    @IBOutlet weak var addCounterBTN: UIButton!
    @IBOutlet weak var congratilationsGifView: UIImageView!
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
    
//MARK: Actions
    @IBAction func addCounter (_ sender: Any){
         animateIn()
    }
    @IBAction func dismissPopUp(_ sender: Any) {
        if !countersNameField.text!.isEmpty && !countersRowsField.text!.isEmpty {
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
        
        print(counters.count)
        
        guard let currentUser = Auth.auth().currentUser else { return }
        user = Users(user: currentUser)
        ref = Database.database().reference().child("users").child(user.uid).child("counters")
        
        setupLifeScreen()
        setUpNavigationBar()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        ref.queryOrdered(byChild: "projectID").queryEqual(toValue: currentProject?.projectID).observe(.value, with: { [weak self] (snapshot) in
            var _counters = Array<CounterToKnit>()
            for item in snapshot.children {
                
                let counter = CounterToKnit(snapshot: item as! DataSnapshot)
//
                _counters.append(counter)
            }
            self?.counters = _counters
            self?.counterTable.reloadData()
        })
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        ref.removeAllObservers()
    }
    
    //MARK: CounterTableView
    
    func tableView(_ counterTable: UITableView, numberOfRowsInSection section: Int) -> Int {
        return counters.count
    }
    
    func tableView(_ counterTable: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = counterTable.dequeueReusableCell(withIdentifier: "counterCell", for: indexPath) as! CountersViewCell
        let counter = counters[indexPath.row]
        cell.layer.cornerRadius = 10
        cell.counterName.text = counter.name
        cell.counterNumbers.text = String(counter.rows)
        cell.plusBtn.tag = indexPath.row
        cell.minusBtn.tag = indexPath.row
        cell.plusBtn.addTarget(self, action: #selector(self.plusBtnTaped(_:)), for: .touchUpInside)
        cell.minusBtn.addTarget(self, action: #selector(self.minusBtnTaped(_:)), for: .touchUpInside)
        cell.plusBtn.isUserInteractionEnabled = true
        cell.minusBtn.isUserInteractionEnabled = true
        cell.isSelected = false
    return cell
    }
    
    @objc func plusBtnTaped (_ sender: UIButton) {
        let tag = sender.tag
        let indexPath = IndexPath(row: tag, section: 0)
        let cell = counterTable.dequeueReusableCell(withIdentifier: "counterCell", for: indexPath) as! CountersViewCell
        let currentCounter = counters[indexPath.row]
        cell.counterNumbers.text = String(currentCounter.rows + 1)
        currentCounter.ref?.updateChildValues(["rows": Int(cell.counterNumbers.text!)!])
        if Int(cell.counterNumbers.text!)! == currentCounter.rowsMax && currentCounter.congratulations == false {
            congatulatuionsIn()
            currentCounter.ref?.updateChildValues(["congratulations" : true])
        }
    }
    @objc func minusBtnTaped(_ sender: UIButton){
        let tag = sender.tag
        let indexPath = IndexPath(row: tag, section: 0)
        let cell = counterTable.dequeueReusableCell(withIdentifier: "counterCell", for: indexPath) as! CountersViewCell
        let currentCounter = counters[indexPath.row]
        cell.counterNumbers.text = String(currentCounter.rows - 1)
        currentCounter.ref?.updateChildValues(["rows": Int(cell.counterNumbers.text!)!])
        if currentCounter.rows <= 0 {
            currentCounter.ref?.updateChildValues(["rows": 0])
        }
    }
    
    // DeleteAction
    func tableView(_ counterTable: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    func tableView(_ counterTable: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let counter = counters[indexPath.row]
            counter.ref?.removeValue()
        }
    }
    
    func insertNewCounter() {
        saveCounter()
//        let indexPath = IndexPath(row: counters.count - 1, section: 0)
//        counterTable.beginUpdates()
//        counterTable.insertRows(at: [indexPath], with: .automatic)
//        counterTable.endUpdates()
        countersNameField.text = ""
        countersRowsField.text = ""
//        view.endEditing(true)
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
    func congatulatuionsIn() {
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
        congratilationsGifView.loadGif(name: "congratulations")
    }
    
    @objc func congratulationsOut() {
        UIView.animate(withDuration: 0.4, animations: {
            self.conratulationView.transform = CGAffineTransform(scaleX: 1.3, y: 1.3)
            self.conratulationView.alpha = 0
            self.visualEffectView.isHidden = true
            self.visualEffectView.effect = nil
        }) { (success: Bool) in
            self.conratulationView.removeFromSuperview()
        }
        congratilationsGifView.image = nil
    }
    
    //MARK: Saving New Counters
    func saveCounter() {
        let newCounter = CounterToKnit(userID: user.uid,
                                       projectID: currentProject!.projectID,
                                       name: countersNameField.text!,
                                       rows: 0,
                                       rowsMax: Int(countersRowsField.text!)!)
        
        let counterRef = self.ref.child(newCounter.name.lowercased())
        counterRef.setValue(newCounter.counterToDictionary())
    }
    
    // MARK: Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "edit"{
            let editingProjectVC = segue.destination as! CreateProjectVC
            editingProjectVC.editingProject = currentProject
        }
    }
}

extension CountersVC {
    //MARK: Seting UP
    private func setupLifeScreen() {
        if currentProject != nil {
            projectImage.layer.cornerRadius = 15
            addCounterView.layer.cornerRadius = 5
            conratulationView.layer.cornerRadius = 5
            tag1LabelView.layer.cornerRadius = 5
            tag1LabelView.clipsToBounds = true
            tag2LabelView.layer.cornerRadius = 5
            tag2LabelView.clipsToBounds = true
            tag3LabelView.layer.cornerRadius = 5
            tag3LabelView.clipsToBounds = true
            
            effect = visualEffectView.effect
            visualEffectView.effect = nil
            addCounterView.layer.cornerRadius = 10
            
            guard let image = currentProject?.imageData.toImage() else {return}

            projectImage.image = image
            counterTable.tableFooterView = UIView()
// TODO: Rewrite it in For - in cicle
                switch currentProject!.tags.count {
                case 1,2,3:
                    tag1Label.text = currentProject?.tags
                    tag1Label.isHidden = false
                    tag1LabelView.isHidden = false
//                case 2:
////                    tag1Label.text = currentProject?.tags[0]
////                    tag2Label.text = currentProject?.tags[1]
//                    tag1Label.isHidden = false
//                    tag1LabelView.isHidden = false
//                    tag2Label.isHidden = false
//                    tag2LabelView.isHidden = false
//                case 3:
////                    tag1Label.text = currentProject?.tags[0]
////                    tag2Label.text = currentProject?.tags[1]
////                    tag3Label.text = currentProject?.tags[2]
//                    tag1Label.isHidden = false
//                    tag1LabelView.isHidden = false
//                    tag2Label.isHidden = false
//                    tag2LabelView.isHidden = false
//                    tag3Label.isHidden = false
//                    tag3LabelView.isHidden = false
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
    
}
