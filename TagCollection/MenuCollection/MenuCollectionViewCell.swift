//
//  MenuCollectionViewCell.swift
//  TagCollection
//
//  Created by TSD040 on 2018-03-25.
//  Copyright © 2018 Paige Sun. All rights reserved.
//

import UIKit

class MenuCollectionViewCell: UICollectionViewCell {
    
    let button = RoundedButton()
    weak var delegate: MenuCollectionDelegate?
    
    var didTapCell: (() -> Void)?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        contentView.addSubview(button)
        button.constrainCenterX(to: contentView)
        button.constrainCenterY(to: contentView)
        button.delegate = self
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(title: String, font: UIFont, didTapCell: @escaping () -> Void) {
        self.didTapCell = didTapCell
        button.setFont(font)
        button.setTitle(title)
    }
}

extension MenuCollectionViewCell: RoundedButtonDelegate {
    func roundedButton(didTap button: RoundedButton) {
        didTapCell?()
    }
}
