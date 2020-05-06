//
//  CounersViewCell.swift
//  knitting
//
//  Created by Павел Кузин on 01.05.2020.
//  Copyright © 2020 Павел Кузин. All rights reserved.
//

import UIKit

class CountersViewCell: UITableViewCell {

    var rowNumbs: Int?
    
    @IBOutlet weak var counterName: UILabel!
    @IBOutlet weak var stepper: UIStepper!
    @IBOutlet weak var counterNumbers: UILabel!
    @IBOutlet weak var countersMax: UILabel!
    
    @IBAction func stepperAct(_ sender: UIStepper) {
        counterNumbers.text = String(Int(sender.value))
        rowNumbs = Int(sender.value)
//        func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//            
//            let newRowNumb = segue.destination as! ProjectLifeConteiner
//            newRowNumb.rowNumb = rowNumbs
//            newRowNumb.saveProject()
//        }
    }
}
