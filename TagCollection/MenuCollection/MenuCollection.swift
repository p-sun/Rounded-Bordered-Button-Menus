//
//  MenuCollection.swift
//  TagCollection
//
//  Created by TSD040 on 2018-03-25.
//  Copyright © 2018 Paige Sun. All rights reserved.
//

import UIKit

protocol MenuCollectionDelegate: class {
    func menuCollection(didSelectItemAt index: Int)
}

private extension UICollectionViewCell {
    static func reuseId() -> String {
        return String(describing: self)
    }
}

class MenuCollection: UICollectionView {
    
    let menuItems: [MenuItem]
    
    private let cellItemHeight : CGFloat = 40
    private let cellMinLineSpacing : CGFloat = 5
    private let cellMinInteritemSpacing : CGFloat = 20
    private let cellFont = UIFont.boldSystemFont(ofSize: 16)
    
    weak var menuCollectionDelegate: MenuCollectionDelegate?
    
    init(menuItems: [MenuItem]) {
        self.menuItems = menuItems
        
        let layout = UICollectionViewFlowLayout()
        super.init(frame: CGRect.zero, collectionViewLayout: layout)
        
        register(MenuCollectionViewCell.self, forCellWithReuseIdentifier: MenuCollectionViewCell.reuseId())

        dataSource = self
        delegate = self
        
        backgroundColor = .clear
        showsVerticalScrollIndicator = false
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension MenuCollection: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        menuCollectionDelegate?.menuCollection(didSelectItemAt: indexPath.row)
    }
}

extension MenuCollection: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return menuItems.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MenuCollectionViewCell.reuseId(), for: indexPath) as! MenuCollectionViewCell
        let index = indexPath.row
        let menuItem = menuItems[index]
        cell.configure(title: menuItem.name, font: cellFont, didTapCell: { [weak self] in
            self?.menuCollectionDelegate?.menuCollection(didSelectItemAt: index)
        })
        return cell
    }
}

extension MenuCollection : UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 25)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return cellMinLineSpacing
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return cellMinInteritemSpacing
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return self.calculateCellSize(content: menuItems[indexPath.row].name as NSString)
    }
    
    private func calculateCellSize(content : NSString) -> CGSize {
        let size: CGSize = content.size(withAttributes: [NSAttributedStringKey.font : cellFont])
        return CGSize(width: size.width + 40, height: cellItemHeight)
    }
}
