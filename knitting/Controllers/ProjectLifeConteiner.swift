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
    
    @IBOutlet weak var counterTable: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        counterTable.reloadData()
        // Do any additional setup after loading the view.
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return counterProject!.countersNames.isEmpty ? 0 : counterProject!.countersNames.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = counterTable.dequeueReusableCell(withIdentifier: "counterCell", for: indexPath) as! CountersViewCell
        cell.counterName.text = counterProject?.countersNames[indexPath.row]
        cell.viewWithTag(1)?.layer.cornerRadius = 10
    return cell
    }

    /*
    // MARK: - Navigation

     
     
         
    
     
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
