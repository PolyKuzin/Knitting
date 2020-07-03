//
//  CounersViewCell.swift
//  knitting
//
//  Created by Павел Кузин on 01.05.2020.
//  Copyright © 2020 Павел Кузин. All rights reserved.
//

import UIKit

class CountersViewCell: UITableViewCell {
    
    @IBOutlet weak var cellView         : UIView!
    @IBOutlet weak var counterName      : UILabel!
    @IBOutlet weak var counterNumbers   : UILabel!
    @IBOutlet weak var plusBtn          : UIButton!
    @IBOutlet weak var minusBtn         : UIButton!
    
//    func setShadows(){
//        contentView.bringSubviewToFront(cellView)
//        let newLayer = CALayer()
//        let shadowPath0 = UIBezierPath(roundedRect: cellView.bounds, cornerRadius: 30)
//        cellView.layer.insertSublayer(newLayer, at: 0)
//        newLayer.shadowPath                  = shadowPath0.cgPath
//        newLayer.shadowRadius                = 20
//        newLayer.shadowColor                 = UIColor(red: 0, green: 0, blue: 0, alpha: 0.12).cgColor
//        newLayer.shadowOpacity               = 1
//        newLayer.bounds                      = cellView.bounds
//        newLayer.shadowOffset                = CGSize(width: 0, height: 8)
//        newLayer.position                    = cellView.center
//        cellView.clipsToBounds                     = false
//        
//    }
    
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
