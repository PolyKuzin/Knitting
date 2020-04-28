//
//  ViewController.swift
//  knitting
//
//  Created by Павел Кузин on 26.04.2020.
//  Copyright © 2020 Павел Кузин. All rights reserved.
//

import UIKit
import RealmSwift

class ProjectsController: UIViewController, UITableViewDelegate, UITableViewDataSource{
    
    let cellIdentifire: String = "cell"
    
    var projects: Results<Project>!
    
    @IBOutlet weak var table1: UITableView!
    @IBOutlet weak var table2: UITableView!
    
    @IBOutlet weak var darkBackGround: UIView!
    
    @IBOutlet weak var addButton: UIButton!
   // @IBOutlet weak var profileImage: UIImageView!
        
    override func viewDidLoad() {
          super.viewDidLoad()
        projects = realm.objects(Project.self)

        addButton.layer.cornerRadius = addButton.intrinsicContentSize.height / 2
      //  profileImage.layer.cornerRadius = profileImage.intrinsicContentSize.height / 2
        darkBackGround.layer.cornerRadius = 30
      }
    
    // MARK: Table Veiw DataSourse
    
    // Количество строк в таблице -> возвращаем количество элементов в массиве
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        if tableView.tag == 1 {

            return projects.isEmpty ? 0 : 3
        } else
    if tableView.tag == 2 {

            return projects.isEmpty ? 0 : projects.count
        }
        else { return 0 }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifire, for: indexPath) as! CustomTableViewCell

        if (tableView.tag == 1) {

            let project = projects[indexPath.row]

            cell.nameLabel.text = project.name
            cell.tagLabel.text = project.tag

            cell.imageOfProject.layer.cornerRadius = cell.imageOfProject.frame.size.height / 2
            cell.imageOfProject.clipsToBounds = true
            cell.imageOfProject.image = UIImage(data: project.imageData!)

            return cell
        } else
            if (tableView.tag == 2) {

            let project = projects[indexPath.row]

            cell.nameMirrLabel.text = project.name
            cell.tagMirrLabel.text = project.tag

            cell.imageMirrOfProject.layer.cornerRadius = cell.imageMirrOfProject.frame.size.height / 2
            cell.imageMirrOfProject.clipsToBounds = true
            cell.imageMirrOfProject.image = UIImage(data: project.imageData!)

            return cell
        }

        return cell
    }
    
    @IBAction func unwindSegue(_ segue: UIStoryboardSegue) {
        
        guard let newProjectVC = segue.source as? NewProjectViewController else { return }
        
        newProjectVC.saveNewProject()
        
        table1.reloadData()
        //table2.reloadData()
    }
}

