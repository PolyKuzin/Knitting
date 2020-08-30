//
//  Animations.swift
//  knitting
//
//  Created by Павел Кузин on 13.08.2020.
//  Copyright © 2020 Павел Кузин. All rights reserved.
//

import UIKit

//MARK: Animation
extension UIView {
    func springAnimation(_ viewToAnimate: UIView){
        UIView.animate(withDuration: 0.15, delay: 0, usingSpringWithDamping: 0.2, initialSpringVelocity: 0.5, options: .curveEaseIn, animations: {
            viewToAnimate.transform = CGAffineTransform(scaleX: 0.92, y: 0.92)
        }) { (_) in
            UIView.animate(withDuration: 0.15, delay: 0, usingSpringWithDamping: 0.4, initialSpringVelocity: 2, options: .curveEaseIn, animations: {
                viewToAnimate.transform = CGAffineTransform(scaleX: 1, y: 1)
            }, completion: nil)
        }
    }
    
    func shakeAnimation(){
        let shake		= CABasicAnimation(keyPath: "position")
        let fromPoint	= CGPoint(x: center.x - 5, y: center.y)
        let fromValue	= NSValue(cgPoint: fromPoint)
        let toPoint		= CGPoint(x: center.x + 5, y: center.y)
        let toValue		= NSValue(cgPoint: toPoint)
        shake.duration	= 0.1
        shake.repeatCount = 2
        shake.autoreverses = true
        shake.fromValue = fromValue
        shake.toValue = toValue
        layer.add(shake, forKey: "position")
    }
}
