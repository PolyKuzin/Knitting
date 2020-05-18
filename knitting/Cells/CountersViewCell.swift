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
    @IBOutlet weak var counterNumbers: UILabel!
    @IBOutlet weak var plusBtn: UIButton!
    @IBOutlet weak var minusBtn: UIButton!
    
    @IBAction func plusButt(_ sender: Any) {
        counterNumbers.text = String(Int(counterNumbers.text!)! + 1)
    }
    @IBAction func minusButt(_ sender: Any) {
        counterNumbers.text = String(Int(counterNumbers.text!)! - 1)
        if Int(counterNumbers.text!)! <= 0 {
            counterNumbers.text = "0"
        }
    }
}
