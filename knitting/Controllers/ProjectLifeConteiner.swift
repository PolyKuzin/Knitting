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
    var counters: Counter?
    
    
    @IBOutlet weak var counterTable: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        counterTable.reloadData()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let currentID = counterProject?.id
        let cellRows = realm.objects(Counter.self).filter("id == %@", currentID).count

        return cellRows//counterProject!.countersNames.isEmpty ? 0 : counterProject!.countersNames.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = counterTable.dequeueReusableCell(withIdentifier: "counterCell", for: indexPath) as! CountersViewCell
        cell.stepperAct(cell.stepper)
        cell.viewWithTag(1)?.layer.cornerRadius = 10
        
    return cell
    }
}
