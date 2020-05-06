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
    
    
    @IBOutlet weak var counterTable: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        counterTable.reloadData()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let cellRows = realm.objects(Counter.self).filter("id == %@", counterProject?.id as Any).count

        return cellRows//counterProject!.countersNames.isEmpty ? 0 : counterProject!.countersNames.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = counterTable.dequeueReusableCell(withIdentifier: "counterCell", for: indexPath) as! CountersViewCell
        cell.stepperAct(cell.stepper)
        cell.viewWithTag(1)?.layer.cornerRadius = 10
        
    return cell
    }
    
    //MARK: DeleteAction
     func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let currentCounter = realm.objects(Counter.self).filter("id == %@", counterProject?.id as Any)[indexPath.row]
        let contextItem = UIContextualAction(style: .destructive, title: "Delete") {  (contextualAction, view, boolValue) in
            StorageManager.deleteCounters(currentCounter)
            tableView.deleteRows(at: [indexPath], with: .automatic)
        }
        let swipeActions = UISwipeActionsConfiguration(actions: [contextItem])
        return swipeActions
    }
}
