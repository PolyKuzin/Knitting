//
//  CounersViewCell.swift
//  knitting
//
//  Created by Павел Кузин on 01.05.2020.
//  Copyright © 2020 Павел Кузин. All rights reserved.
//

import UIKit
import RealmSwift

class CountersViewCell: UITableViewCell {

    var counterInCell: Results<Counter>!
    
    @IBOutlet weak var counterName: UILabel!
    @IBOutlet weak var stepper: UIStepper!
    @IBOutlet weak var counterNumbers: UILabel!
    
    @IBAction func stepperAct(_ sender: UIStepper) {
        counterNumbers.text = String(sender.value)
    }
}
