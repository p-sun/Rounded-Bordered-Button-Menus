//
//  ViewController.swift
//  RoundedButtonMenus
//
//  Created by TSD040 on 2018-03-25.
//  Copyright © 2018 Paige Sun. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    let menuItems = MenuItem.testList

    var collectionView: MenuCollection!
    let menuStack = MenuStack()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupBackground()
        setupMenuCollection()
        setupPaigeButton()
        setupMenuStack()
    }
    
    private func setupBackground() {
        let backgroundImage = UIImageView()
        backgroundImage.image = #imageLiteral(resourceName: "desertSky")
        view.addSubview(backgroundImage)
        backgroundImage.constrainEdges(to: view)
    }
}

// MARK: - UICollectionView on the left
extension ViewController: MenuCollectionDelegate {
    func setupMenuCollection() {
        collectionView = MenuCollection(menuItems: menuItems)
        view.addSubview(collectionView)
        collectionView.menuCollectionDelegate = self
        collectionView.constrainWidth(250)
        collectionView.constrainEdgesVertically(to: view)
        collectionView.constrainTop(to: view)
        collectionView.constrainLeft(to: view)
    }
    
    func menuCollection(didSelectItemAt index: Int) {
        print("Menu collection tapped at \(menuItems[index].name)")
    }
}

// MARK: - UIButton in the center
extension ViewController {
    private func setupPaigeButton() {
        let customButton = RoundedButton(hasBlurEffect: true)
        customButton.setTitle("Paige Sun\npaige.sun.dev@gmail.com")
        view.addSubview(customButton)
        customButton.constrainCenterX(to: view)
        customButton.constrainCenterY(to: view)
        customButton.addTarget(self, action: #selector(paigeButtonTapped), for: .touchUpInside)
    }
    
    @objc func paigeButtonTapped(_ button: UIButton) {
        print("Paige button tapped")
    }
}

// MARK: - UIStackView on the right
extension ViewController: MenuStackDelegate {
    func setupMenuStack() {
        menuStack.menuStackDelegate = self
        menuStack.configure(menuItems: menuItems)
        view.addSubview(menuStack)
        menuStack.constrainEdgesVertically(to: view)
        menuStack.constrainTrailing(to: view)
        menuStack.constrainWidth(160)
    }
    
    func menuStack(didSelectAtIndex index: Int) {
        print("Menu stack tapped for \(menuItems[index].name)")
    }
}
