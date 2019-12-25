//
//  UICollectionViewExtension.swift
//  AAACOMP
//
//  Created by Rafael Escaleira on 17/12/19.
//  Copyright © 2019 Rafael Escaleira. All rights reserved.
//

import UIKit
import Blueprints

extension UICollectionView {
    
    func setHorizontalCollectionViewLayout(itemsPerRow: CGFloat, height: CGFloat, minimumInteritemSpacing: CGFloat, minimumLineSpacing: CGFloat, sectionInset: UIEdgeInsets) {
        
        let layout = HorizontalBlueprintLayout(itemsPerRow: itemsPerRow, height: height, minimumInteritemSpacing: minimumInteritemSpacing, minimumLineSpacing: minimumLineSpacing, sectionInset: sectionInset)
        self.collectionViewLayout = layout
    }
    
    func setVerticalCollectionViewLayout(itemsPerRow: CGFloat, height: CGFloat, minimumInteritemSpacing: CGFloat, minimumLineSpacing: CGFloat, sectionInset: UIEdgeInsets) {
        
        let layout = VerticalBlueprintLayout(itemsPerRow: itemsPerRow, height: height, minimumInteritemSpacing: minimumInteritemSpacing, minimumLineSpacing: minimumLineSpacing, sectionInset: sectionInset)
        self.collectionViewLayout = layout
    }
}
