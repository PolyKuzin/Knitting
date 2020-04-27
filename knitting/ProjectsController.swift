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
    let projectsNames = [
        "Варежки", "Слоник", "Медведь", "Овоська", "Цыплёнок", "Шарф"
    ]
    
    @IBOutlet weak var table1: UITableView!
    @IBOutlet weak var table2: UITableView!
    
    @IBOutlet weak var addButton: UIButton!
    @IBOutlet weak var profileImage: UIImageView!
        
    override func viewDidLoad() {
          super.viewDidLoad()
          // Do any additional setup after loading the view.

        addButton.layer.cornerRadius = addButton.intrinsicContentSize.height / 2
        profileImage.layer.cornerRadius = profileImage.intrinsicContentSize.height / 2
      }
    
    // MARK: Table Veiw DataSourse
    
    // Количество строк в таблице -> возвращаем количество элементов в массиве
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if tableView.tag == 1 {
            
            return projectsNames.count
        } else if tableView.tag == 2 {
            
            return projectsNames.count
        }
        else { return 0 }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifire, for: indexPath)
        
        if (tableView.tag == 1) {
            
            cell.textLabel?.text = projectsNames[indexPath.row]
            cell.imageView?.image = UIImage(named: projectsNames[indexPath.row])
            return cell
        } else if (tableView.tag == 2) {
            
            cell.textLabel?.text = projectsNames[indexPath.row]
            return cell
        }
        
        return cell
    }
}

