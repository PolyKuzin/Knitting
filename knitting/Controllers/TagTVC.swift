//
//  TagTVC.swift
//  knitting
//
//  Created by Павел Кузин on 29.04.2020.
//  Copyright © 2020 Павел Кузин. All rights reserved.
//

import UIKit

class TagTVC: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "tagCell", for: indexPath) as! TagTableViewCell
        cell.projectTag.layer.cornerRadius = 10
        cell.projectTag.backgroundColor = #colorLiteral(red: 1, green: 0.3290538788, blue: 0.4662155509, alpha: 1)
        
        return cell
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 1
    }
}
