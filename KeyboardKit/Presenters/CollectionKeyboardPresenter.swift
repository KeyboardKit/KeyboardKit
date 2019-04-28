//
//  CollectionKeyboardPresenter.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2019-04-27.
//  Copyright © 2019 Daniel Saidi. All rights reserved.
//

/*
 
 This presenter will create a collection view, which you can
 add to your keyboard view controller. By default, it gets a
 single section that has as many items as there are keyboard
 actions.
 
 The presenter will set itself as the collection view's data
 source and delegate. When using it, you must inherit it and
 override `collectionView(cellForItemAt:)`, to specify which
 cell to use for each action.
 
 */

import UIKit

open class CollectionKeyboardPresenter: NSObject, KeyboardPresenter, UICollectionViewDataSource, UICollectionViewDelegate {
    
    
    // MARK: - Initialization
    
    public init(id: String? = nil, viewController: KeyboardInputViewController) {
        self.id = id
        self.viewController = viewController
        super.init()
    }
    
    
    // MARK: - Dependencies
    
    private unowned let viewController: KeyboardInputViewController
    
    
    // MARK: - Properties
    
    public let id: String?

    public lazy var collectionView: KeyboardCollectionView = {
        let layout = UICollectionViewFlowLayout()
        let collectionView = KeyboardCollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        guard let view = viewController.view else { return collectionView }
        collectionView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        collectionView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        collectionView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
//        collectionViewHeight = collectionView.heightAnchor.constraint(equalToConstant: 100)
//        collectionViewHeight?.isActive = true
        return collectionView
    }()
    
    var keyboard: Keyboard {
        return viewController.keyboard
    }
    
    
    // MARK: - KeyboardPresenter
    
    open func refresh() {
        collectionView.collectionViewLayout.invalidateLayout()
        collectionView.reloadData()
    }
    
    
    // MARK: - Public Functions
    
    open func keyboardAction(at indexPath: IndexPath) -> KeyboardAction? {
        return keyboard.actions[indexPath.row]
    }
    
    
    // MARK: - UICollectionViewDataSource
    
    open func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    open func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return keyboard.actions.count
    }

    open func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        return UICollectionViewCell()
    }
    
    
    // MARK: - UICollectionViewDelegate
    
    open func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let action = keyboardAction(at: indexPath) else { return }
        viewController.keyboardActionHandler.handleTap(on: action)
    }
}
