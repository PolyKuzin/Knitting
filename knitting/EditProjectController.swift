//
//  EditProjectController.swift
//  knitting
//
//  Created by Павел Кузин on 28.04.2020.
//  Copyright © 2020 Павел Кузин. All rights reserved.
//

import UIKit

class ProjectLifeController: UITableViewController {

    var currentProject: Project?
    
    @IBOutlet weak var projectImage: UIImageView!
    @IBOutlet weak var projectName: UITextField!
    @IBOutlet weak var projectTag: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupEditScreen()
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 3
    }

    
    private func setupEditScreen() {
        
        if currentProject != nil {
            guard let data = currentProject?.imageData, let image = UIImage(data: data) else {return}

            projectImage.image = image
            projectName.text = currentProject?.name
        }
    }
    
    //MARK: Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "edit" {
            
            let project = currentProject
            
            let editProjectVC = segue.destination as! ProjectLifeController
            editProjectVC.currentProject = project
            
        }
    }
    
}
