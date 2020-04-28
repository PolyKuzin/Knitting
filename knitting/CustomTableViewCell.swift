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
    @IBOutlet weak var playButton: UIButton!
    
    @IBOutlet weak var imageMirrOfProject: UIImageView!
    @IBOutlet weak var nameMirrLabel: UILabel!
    @IBOutlet weak var tagMirrLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    
}
