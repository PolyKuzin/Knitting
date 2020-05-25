//
//  GallaryCollectionView.swift
//  knitting
//
//  Created by Павел Кузин on 22.05.2020.
//  Copyright © 2020 Павел Кузин. All rights reserved.
//

import UIKit

class GallaryCollectionView: UICollectionView, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    //let cells = [SushiModel]()
    
    init() {
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        super.init(frame: .zero, collectionViewLayout: layout)
        
        backgroundColor = #colorLiteral(red: 0.4666666687, green: 0.7647058964, blue: 0.2666666806, alpha: 1)
        
        delegate = self
        dataSource = self
        
        register(galleryCell.self, forCellWithReuseIdentifier: galleryCell.reusedID)
        
        translatesAutoresizingMaskIntoConstraints = false
        
        layout.minimumLineSpacing = 10
        contentInset = UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20)
        
        showsHorizontalScrollIndicator = false
        showsVerticalScrollIndicator = false
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = dequeueReusableCell(withReuseIdentifier: galleryCell.reusedID, for: indexPath)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: Constants.galleryItemWidth, height: frame.height * 0.8)
    }
}
