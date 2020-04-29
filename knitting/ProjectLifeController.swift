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
    @IBOutlet weak var projectName: UILabel!
    @IBOutlet weak var projectTag: UILabel!
    var nameLabel: String?
    var tagLabel: String?
    @IBOutlet weak var stepper: UIStepper!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupLifeScreen()
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 4
    }

    
    private func setupLifeScreen() {
        
        if currentProject != nil {
            
            setUpNavigationBar()
            
            guard let data = currentProject?.imageData, let image = UIImage(data: data) else {return}

            projectImage.image = image
            nameLabel = String(currentProject!.name)
            projectName.text = nameLabel
            tagLabel = String(currentProject!.tag!)
            projectTag.text = tagLabel
        }
    }
    
    private func setUpNavigationBar() {
        
        if let topItem = navigationController?.navigationBar.topItem {
            topItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        }
        
        navigationItem.leftBarButtonItem = nil
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     
        let editingProjectVC = segue.destination as! NewProjectViewController
        editingProjectVC.editingProject = currentProject
    }

}
