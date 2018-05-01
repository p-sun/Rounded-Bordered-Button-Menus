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
            
            print("layout attributes frame \(layoutAttribute.frame) current margin \(leftMargin) \(sectionInset.left)")

            // If the current item i
            if layoutAttribute.frame.origin.y >= maxY {
                leftMargin = sectionInset.left
            }

            layoutAttribute.frame.origin.x = leftMargin

            leftMargin += layoutAttribute.frame.width + minimumInteritemSpacing

            maxY = max(layoutAttribute.frame.maxY, maxY)

            print("new maxY \(maxY) left margin \(leftMargin)")

        }
        
        return attributes
    }
}

//class LeftAlignedFlowLayout: UICollectionViewLayout {
//
//    private var cache = [UICollectionViewLayoutAttributes]()
//
//    private var contentHeight: CGFloat = 0
//    private var contentWidth: CGFloat {
//        guard let collectionView = collectionView else {
//            return 0
//        }
//        let insets = collectionView.contentInset
//        return collectionView.bounds.width - (insets.left + insets.right)
//    }
//
//
//    let cellDim: CGFloat = 200
//    let interItemSpacing: CGFloat = 10
//
//
//    override var collectionViewContentSize: CGSize {
//        return CGSize(width: contentWidth, height: contentHeight)
//    }
//
//    override func prepare() {
//        guard cache.isEmpty == true, let collectionView = collectionView else {
//            return
//        }
//
//        for item in 0 ..< collectionView.numberOfItems(inSection: 0) {
//            //TODO: 1. Calulate Frame for each item
//            let indexPath = IndexPath(item: item, section: 0)
//
//            let position = positionForIndex(index: indexPath.row)
//
//            let numberOfCellsInRow: CGFloat = position.row % 2 == 0 ? 3 : 2
//            let spacingLeftAndRightOfCircles = contentWidth - (cellDim * numberOfCellsInRow) - (interItemSpacing * (numberOfCellsInRow - 1))
//            let spacingLeftOfCircles = spacingLeftAndRightOfCircles / 2
//            let xPosition = spacingLeftOfCircles + CGFloat(position.column) * (cellDim + interItemSpacing)
//            let yPosition = cellDim * CGFloat(position.row)
//
//            let newFrame = CGRect(x: xPosition, y: yPosition, width: cellDim, height: cellDim)
//
//            let attributes = UICollectionViewLayoutAttributes(forCellWith: indexPath)
//            attributes.frame = newFrame//CGRect(x: 0, y: 0, width: 300, height: 300) // Insert frame here
//            cache.append(attributes)
//
//            //TODO: 2. Update Content Height
//            contentHeight = max(contentHeight, CGFloat(position.row + 1) * cellDim)
//        }
//
//    }
//
//    private struct Position {
//        let row: Int
//        let column: Int
//    }
//
//    private func positionForIndex(index: Int) -> Position {
//        let numberOfGroups = index / 5
//        let itemPositionInGroup = index % 5
//        let rowInGroup = itemPositionInGroup > 2 ? 1 : 0
//        let row = numberOfGroups * 2 + rowInGroup
//        let column = itemPositionInGroup % 3
//        let pos = Position(row: row, column: column)
//        print(pos)
//        return pos
//    }
//
//    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
//
//        var visibleLayoutAttributes = [UICollectionViewLayoutAttributes]()
//
//        // Loop through the cache and look for items in the rect
//        for attributes in cache {
//            if attributes.frame.intersects(rect) {
//                visibleLayoutAttributes.append(attributes)
//            }
//        }
//        return visibleLayoutAttributes
//    }
//
//    override func layoutAttributesForItem(at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
//        return cache[indexPath.item]
//    }
//
//}
//
