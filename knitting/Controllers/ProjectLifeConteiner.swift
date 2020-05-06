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
    var rowNumb: Int?
    
    @IBOutlet weak var counterTable: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        counterTable.reloadData()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return counterProject!.countersNames.isEmpty ? 0 : counterProject!.countersNames.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = counterTable.dequeueReusableCell(withIdentifier: "counterCell", for: indexPath) as! CountersViewCell
        cell.counterName.text = counterProject?.countersNames[indexPath.row]
        cell.stepper.value = Double((counterProject?.countersRows[indexPath.row])!)
        cell.stepperAct(cell.stepper)
        cell.countersMax.text = "|\(counterProject!.countersRowsMax[indexPath.row] ?? 250)"
        cell.viewWithTag(1)?.layer.cornerRadius = 10
        rowNumb = Int(cell.stepper.value)
        cell.counterNumbers.text = String(rowNumb!)
    return cell
    }
    //MARK: Saving New Rows
//    func saveProject() {
//        let imageData = counterProject?.imageData
//        let newProject = Project(name: counterProject!.name,
//                                 tag1: counterProject?.tags[0],
//                                 tag2: counterProject?.tags[1],
//                                 tag3: counterProject?.tags[2],
//                                 counterName: counterProject?.name,
//                                 countersRowsMax: counterProject?.countersRowsMax[0],
//                                 countersRows: counterProject!.countersRows[rowNumb!],
//                                 imageData: imageData)
//        
//        if counterProject != nil {
//            try! realm.write {
//                counterProject?.name = newProject.name
//                counterProject?.tags.removeAll()
//                
//                for str in newProject.tags {
//                    counterProject?.tags.append(str)
//                    if str!.isEmpty {counterProject?.tags.removeLast()}
//                }
//                for counter in newProject.countersRows {
//                    counterProject?.countersRows.append(counter)
//                }
//                //counterProject?.countersNames.append(countersNameField.text)
//                counterProject?.imageData = newProject.imageData
//                counterProject?.date = Date()
//            }
//        }
//    }
    //MARK: UnwindSegue
     
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {    }

}
