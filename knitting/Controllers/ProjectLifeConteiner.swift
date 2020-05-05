//
//  ProjectLifeConteinerViewController.swift
//  knitting
//
//  Created by Павел Кузин on 01.05.2020.
//  Copyright © 2020 Павел Кузин. All rights reserved.
//

import UIKit

class ProjectLifeConteiner: UIViewController, UITableViewDataSource, UITableViewDelegate {

    var counterProject: Project?
//    var rowNumb: Int?
    
    @IBOutlet weak var counterTable: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        counterTable.reloadData()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return counterProject!.countersNames.isEmpty ? 0 : counterProject!.countersNames.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //var rowNumb = counterProject?.counter
        let cell = counterTable.dequeueReusableCell(withIdentifier: "counterCell", for: indexPath) as! CountersViewCell
        cell.counterName.text = counterProject?.countersNames[indexPath.row]
        //rowNumb = Int(cell.stepper.value)
        cell.stepperAct(cell.stepper)
       // cell.counterNumbers.text = "\(rowNumb ?? 250) / \(counterProject!.countersRowsMax[indexPath.row] ?? 250)"
        cell.viewWithTag(1)?.layer.cornerRadius = 10
        
    return cell
    }
    

    
    //MARK: DeleteAction
//     func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
//        let project = counterProject!.countersNames[indexPath.row]
//        let contextItem = UIContextualAction(style: .destructive, title: "delete") {  (contextualAction, view, boolValue) in
//            StorageManager.deleteObject(counterProject!.countersNames[indexPath.row])
//            tableView.deleteRows(at: [indexPath], with: .automatic)
//        }
//        let swipeActions = UISwipeActionsConfiguration(actions: [contextItem])
//        return swipeActions
//    }
    /*
    // MARK: - Navigation

     
     
         
    
     
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
