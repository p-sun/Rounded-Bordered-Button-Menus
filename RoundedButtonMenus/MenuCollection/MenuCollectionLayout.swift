//
//  MenuCollectionLayout.swift
//  RoundedButtonMenus
//
//  Created by TSD064 on 2018-05-01.
//  Copyright © 2018 Paige Sun. All rights reserved.
//

import UIKit

class LeftAlignedCollectionViewFlowLayout: UICollectionViewFlowLayout {
    
    override init() {
        super.init()
        minimumInteritemSpacing = 5
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        let attributes = super.layoutAttributesForElements(in: rect)
        
        var leftMargin = sectionInset.left
        var maxY: CGFloat = -1.0
        attributes?.forEach { layoutAttribute in
            
            // If THIS item is on the next row, reset its leftMargin
            if layoutAttribute.frame.origin.y >= maxY {
                leftMargin = sectionInset.left
            }
            // Get the maxY for all items
            maxY = max(layoutAttribute.frame.maxY, maxY)
            
            // Set THIS item's origin.x to leftMargin. Note that the original origin.y is unchanged.
            layoutAttribute.frame.origin.x = leftMargin

            // Calculate NEXT item's leftMargin by adding this item's width
            leftMargin += layoutAttribute.frame.width + minimumInteritemSpacing
        }
        
        return attributes
    }
}
