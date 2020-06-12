//
//  CustomTextField.swift
//  knitting
//
//  Created by Павел Кузин on 12.06.2020.
//  Copyright © 2020 Павел Кузин. All rights reserved.
//

import Foundation
import UIKit

class CustomTextField: UITextField {
    
    let insets: UIEdgeInsets
    
    init(insets: UIEdgeInsets = UIEdgeInsets(top: 0, left: 12, bottom: 0, right: 12)) {
        self.insets = insets
        super.init(frame: .zero)
        
        layer.cornerRadius = 15
        layer.borderWidth = 0.5
        
        layer.borderColor = Colors.borderСolorForTextField.cgColor
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: insets)
    }
    
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: insets)
    }
}
