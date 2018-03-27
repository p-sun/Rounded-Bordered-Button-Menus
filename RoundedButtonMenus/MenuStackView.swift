//
//  MenuStack.swift
//  RoundedButtonMenus
//
//  Created by TSD040 on 2018-03-26.
//  Copyright © 2018 Paige Sun. All rights reserved.
//

import UIKit

protocol MenuStackDelegate: class {
    func menuStack(didSelectAtIndex index: Int)
}

class MenuStack: UIScrollView {
    
    weak var menuStackDelegate: MenuStackDelegate?
    
    var interitemSpacing: CGFloat = 10 {
        didSet {
            stackView.spacing = interitemSpacing
        }
    }
    
    private let stackView = UIStackView()
    
    init() {
        super.init(frame: CGRect.zero)
        stackView.backgroundColor = .green
        
        showsHorizontalScrollIndicator = false
        showsVerticalScrollIndicator = false
        
        self.addSubview(stackView)
        stackView.axis = .vertical
        stackView.constrainEdges(to: self)
        stackView.spacing = interitemSpacing
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(menuItems: [MenuItem]) {
        for arrangeSubview in stackView.arrangedSubviews {
            arrangeSubview.removeFromSuperview()
        }
        
        for (index, menuItem) in menuItems.enumerated() {
            let button = RoundedButton(hasBlurEffect: true)
            button.tag = index
            button.setTitle(menuItem.name)
            button.delegate = self
            stackView.addArrangedSubview(button)
        }
    }    
}

extension MenuStack: RoundedButtonDelegate {
    func roundedButton(didTap button: RoundedButton) {
        menuStackDelegate?.menuStack(didSelectAtIndex: button.tag)
    }
}
