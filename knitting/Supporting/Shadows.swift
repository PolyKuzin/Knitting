//
//  Shadows.swift
//  knitting
//
//  Created by Павел Кузин on 30.05.2020.
//  Copyright © 2020 Павел Кузин. All rights reserved.
//

import UIKit

extension UIViewController {
    
    func shadowsToView(view: UIView){
        let shadows = UIView()
        shadows.frame = view.frame
        shadows.clipsToBounds = false
        view.addSubview(shadows)

        let shadowPath0 = UIBezierPath(roundedRect: shadows.bounds, cornerRadius: 29)
        let layer0 = CALayer()
        layer0.shadowPath = shadowPath0.cgPath
        layer0.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.12).cgColor
        layer0.shadowOpacity = 1
        layer0.shadowRadius = 30
        layer0.shadowOffset = CGSize(width: 0, height: -8)
        layer0.bounds = shadows.bounds
        layer0.position = shadows.center
        shadows.layer.addSublayer(layer0)
    }
}
