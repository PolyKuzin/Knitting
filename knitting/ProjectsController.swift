//
//  ViewController.swift
//  knitting
//
//  Created by Павел Кузин on 26.04.2020.
//  Copyright © 2020 Павел Кузин. All rights reserved.
//

import UIKit

class ProjectsController: UIViewController, UITableViewDelegate, UITableViewDataSource{
    
    let cellIdentifire: String = "cell"
    
    let projects = Project.getProjects()
    let projectsMirr = ProjectMirr.getProjectsMirr()
    
    @IBOutlet weak var table1: UITableView!
    @IBOutlet weak var table2: UITableView!
    
    @IBOutlet weak var darkBackGround: UIView!
    
    @IBOutlet weak var addButton: UIButton!
   // @IBOutlet weak var profileImage: UIImageView!
        
    override func viewDidLoad() {
          super.viewDidLoad()

        addButton.layer.cornerRadius = addButton.intrinsicContentSize.height / 2
      //  profileImage.layer.cornerRadius = profileImage.intrinsicContentSize.height / 2
        darkBackGround.layer.cornerRadius = 30
      }
    
    // MARK: Table Veiw DataSourse
    
    // Количество строк в таблице -> возвращаем количество элементов в массиве
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if tableView.tag == 1 {
            
            return projects.count
        } else if tableView.tag == 2 {
            
            return projects.count
        }
        else { return 0 }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifire, for: indexPath) as! CustomTableViewCell
        
        if (tableView.tag == 1) {
            
            cell.nameLabel.text = projects[indexPath.row].name
            cell.tagLabel.text = projects[indexPath.row].tag
            cell.imageOfProject.image = UIImage(named: projects[indexPath.row].name)
            cell.imageOfProject.layer.cornerRadius = cell.imageOfProject.frame.size.height / 2
            cell.imageOfProject.clipsToBounds = true
            
            return cell
        } else if (tableView.tag == 2) {
            
            cell.nameMirrLabel.text = projectsMirr[indexPath.row].nameMirr
            cell.tagMirrLabel.text = projectsMirr[indexPath.row].tagMirr
            cell.imageMirrOfProject.image = UIImage(named: projectsMirr[indexPath.row].nameMirr)
            cell.imageMirrOfProject.layer.cornerRadius = cell.imageMirrOfProject.frame.size.height / 2
            cell.imageMirrOfProject.clipsToBounds = true
            
            return cell
        }
        
        return cell
    }
    
    @IBAction func cancelAction(_ segue: UIStoryboardSegue) {}
}

