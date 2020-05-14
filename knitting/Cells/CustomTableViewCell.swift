//
//  RecentTableViewCell.swift
//  knitting
//
//  Created by Павел Кузин on 27.04.2020.
//  Copyright © 2020 Павел Кузин. All rights reserved.
//

import UIKit

class CustomTableViewCell: UITableViewCell {
    @IBOutlet weak var imageOfProject: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var tagLabel: UILabel!
    @IBOutlet weak var editButton: UIImageView!
    @IBOutlet weak var tagView: UIView!
    
    func setUpCell(){
        
        tagLabel.layer.cornerRadius = tagLabel.frame.size.height / 2
        tagLabel.clipsToBounds = true

        imageOfProject.layer.cornerRadius = 15
        imageOfProject.clipsToBounds = true
    }
    
    func setConstraints() {
        
    }
}
