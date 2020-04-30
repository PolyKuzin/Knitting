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
    var tagLabel: String?
    
    @IBOutlet weak var tagTable: UITableView!
    @IBOutlet weak var projectImage: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupLifeScreen()
        projectImage.layer.cornerRadius = projectImage.frame.size.height / 2
    }
    
    //MARK: TableView
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return currentProject!.tags.isEmpty ? 0 : currentProject!.tags.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tagTable.dequeueReusableCell(withIdentifier: cellIdentifire, for: indexPath) as! TagTableViewCell

            cell.projectTag1Cell.text = currentProject?.tags[indexPath.row]
        cell.projectTag1Cell.backgroundColor = #colorLiteral(red: 1, green: 0.3290538788, blue: 0.4662155509, alpha: 1) //UIColor(CGColor: currentProject?.tagColor)
            cell.projectTag1Cell.layer.cornerRadius = cell.projectTag1Cell.frame.size.height / 2
            cell.projectTag1Cell.layer.masksToBounds = true

        return cell
    }
    

    //MARK: Seting UP
    private func setupLifeScreen() {
        if currentProject != nil {
            setUpNavigationBar()
            guard let data = currentProject?.imageData, let image = UIImage(data: data) else {return}

            projectImage.image = image
            tagLabel = String(currentProject?.tags[0] ?? "Для себя")
            tagTable.tableFooterView = UIView()
            
        }
    }
    
    private func setUpNavigationBar() {
        
        if let topItem = navigationController?.navigationBar.topItem {
            topItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        }
        let title = UIBarButtonItem(title: currentProject?.name, style: .plain, target: self, action: nil)
        navigationItem.rightBarButtonItems?.append(title)
        navigationItem.leftBarButtonItem = nil
    }
    
    // MARK: Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     
        let editingProjectVC = segue.destination as! NewProjectViewController
        editingProjectVC.editingProject = currentProject
    }

}

