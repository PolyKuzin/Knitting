//
//  galleryCell.swift
//  knitting
//
//  Created by Павел Кузин on 22.05.2020.
//  Copyright © 2020 Павел Кузин. All rights reserved.
//

import UIKit

class GalleryCell: UICollectionViewCell {
    
    static let reusedID = "GalleryCell"
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        layer.cornerRadius = 10
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        let shadowPath0 = UIBezierPath(roundedRect: self.bounds, cornerRadius: 10)
        self.layer.cornerRadius = 20
        self.layer.shadowRadius = 8
        self.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.12).cgColor
        layer.shadowPath = shadowPath0.cgPath
        layer.shadowOpacity = 1
        layer.bounds = self.bounds
        layer.shadowOffset = CGSize(width: 0, height: 4)
        layer.position = self.center

        self.clipsToBounds = false
    }
}
