//
//  EditProjectController.swift
//  knitting
//
//  Created by Павел Кузин on 28.04.2020.
//  Copyright © 2020 Павел Кузин. All rights reserved.
//

import UIKit

class ProjectLifeController: UIViewController, UITableViewDataSource, UITableViewDelegate  {

    let cellIdentifire: String = "tagCell"
    
    var currentProject: Project?
    var tags: [String?] = [""]
    var nameLabel: String?
    var tagLabel: String?
    
    @IBOutlet weak var tagTable: UITableView!
    @IBOutlet weak var projectImage: UIImageView!
    @IBOutlet weak var projectName: UILabel!
    @IBOutlet weak var projectTag: UILabel!

    @IBOutlet weak var stepper: UIStepper!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupLifeScreen()
        projectImage.layer.cornerRadius = projectImage.frame.size.height / 2
    }
    
    //MARK: TableView
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tagTable.dequeueReusableCell(withIdentifier: cellIdentifire, for: indexPath) as! TagTableViewCell
        cell.projectTagCell.text = currentProject?.tag
        cell.projectTagCell.backgroundColor = #colorLiteral(red: 1, green: 0.3290538788, blue: 0.4662155509, alpha: 1)
        cell.projectTagCell.layer.cornerRadius = cell.projectTagCell.frame.size.height / 2
        cell.projectTagCell.layer.masksToBounds = true
        return cell
    }
    

    //MARK: Seting UP
    private func setupLifeScreen() {
        if currentProject != nil {
            setUpNavigationBar()
            guard let data = currentProject?.imageData, let image = UIImage(data: data) else {return}

            projectImage.image = image
            nameLabel = String(currentProject!.name)
            projectName.text = nameLabel
            tagLabel = String(currentProject?.tag ?? "Для себя")
            //projectTag.text = tagLabel
            tagTable.tableFooterView = UIView()
            
        }
    }
    
    private func setUpNavigationBar() {
        
        if let topItem = navigationController?.navigationBar.topItem {
            topItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        }
        navigationItem.leftBarButtonItem = nil
    }
    
    // MARK: Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     
        let editingProjectVC = segue.destination as! NewProjectViewController
        editingProjectVC.editingProject = currentProject
    }

}

