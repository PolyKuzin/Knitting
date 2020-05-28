//
//  ProjectsTableView.swift
//  knitting
//
//  Created by Павел Кузин on 28.05.2020.
//  Copyright © 2020 Павел Кузин. All rights reserved.
//

import Foundation
import UIKit

extension ProjectsVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return projects.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ProjectCell") as! ProjectsCell
        let project = projects[indexPath.row]
        cell.setCell(project: project, indexPath : indexPath.row)
        return cell
    }
//Delete Action

    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let project = projects[indexPath.row]
            project.ref?.removeValue()
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let project = projects[indexPath.row]
        tableView.deselectRow(at: indexPath, animated: true)
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "projectLifeController") as! CountersVC
        vc.modalPresentationStyle = .fullScreen
        vc.currentProject = project
        self.navigationController?.pushViewController(vc, animated: true)
    }

//Sorting
//      func sorting() {
//          projects = projects.sorted(byKeyPath: "date", ascending: false)
//          tableView.reloadData()
//      }
}
