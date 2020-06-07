//
//  GallaryCollectionView.swift
//  knitting
//
//  Created by Павел Кузин on 22.05.2020.
//  Copyright © 2020 Павел Кузин. All rights reserved.
//

import UIKit

class GallaryCollectionView: UICollectionView, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    
    init() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        super.init(frame: .zero, collectionViewLayout: layout)
        backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        delegate = self
        dataSource = self
        register(GalleryCell.self, forCellWithReuseIdentifier: "GalleryCell")
        
        layout.minimumLineSpacing = 10
        contentInset = UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20)
        clipsToBounds = false
        showsHorizontalScrollIndicator = false
        showsVerticalScrollIndicator = false
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 6
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = dequeueReusableCell(withReuseIdentifier: "GalleryCell", for: indexPath)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: Constants.galleryItemWidth, height: (UIScreen.main.bounds.height / 4) - 40)
    }
}
struct Constants {
    static let leftDistanceToView: CGFloat = 40
    static let rightDistanceToView: CGFloat = 40
    static let galleryMinimumLineSpacing: CGFloat = 10
    static let galleryItemWidth = (UIScreen.main.bounds.width - Constants.leftDistanceToView - Constants.rightDistanceToView - (Constants.galleryMinimumLineSpacing / 2)) / 3
}
