//
//  ProjectLifeConteinerViewController.swift
//  knitting
//
//  Created by Павел Кузин on 01.05.2020.
//  Copyright © 2020 Павел Кузин. All rights reserved.
//

import UIKit
import RealmSwift

class ProjectLifeConteiner: UIViewController, UITableViewDataSource, UITableViewDelegate {

    var counterProject: Project?
    var counters: Counter?
    var currentRow: Int?
    
    let myRefreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(refresh), for: .valueChanged)
        return refreshControl
    }()
    
    @IBOutlet weak var counterTable: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        counterTable.refreshControl = myRefreshControl
        counterTable.reloadData()
    }
    
    @objc private func refresh(sender: UIRefreshControl){
        counterTable.reloadData()
        sender.endRefreshing()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let cellRows = realm.objects(Counter.self).filter("projectID == %@", counterProject?.projectID as Any).count
        return cellRows
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = counterTable.dequeueReusableCell(withIdentifier: "counterCell", for: indexPath) as! CountersViewCell
        let counter = realm.objects(Counter.self).filter("projectID == %@", counterProject?.projectID as Any)[indexPath.row]
        cell.counterName.text = counter.name
        cell.stepper.value = Double(counter.rows)
        cell.stepperAct(cell.stepper)
        cell.viewWithTag(1)?.layer.cornerRadius = 10
    return cell
    }
    
    //MARK: DeleteAction
     func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let currentCounter = realm.objects(Counter.self).filter("projectID == %@", counterProject?.projectID as Any)[indexPath.row]
        let contextItem = UIContextualAction(style: .destructive, title: "Delete") {  (contextualAction, view, boolValue) in
            StorageManager.deleteCounters(currentCounter)
            tableView.deleteRows(at: [indexPath], with: .automatic)
        }
        let swipeActions = UISwipeActionsConfiguration(actions: [contextItem])
        return swipeActions
    }
    func savingRows(_ counter: Counter,_ rowNumb: Int){
        try! realm.write {
            counter.rows = rowNumb
        }
    }
}
