//
//  CollectionKeyboardPresenter.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2019-04-27.
//  Copyright © 2019 Daniel Saidi. All rights reserved.
//

/*
 
 This presenter requires a view controller plus a collection
 view and will setup the collection view with itself as data
 source and delegate. By default, it provides the collection
 view with a single section, with as many items as there are
 keyboard actions.
 
 When using this presenter, you must inherit it and override
 `collectionView(cellForItemAt:)` to specify the cell to use
 for each index path.
 
 */

import UIKit

open class CollectionKeyboardPresenter: NSObject, KeyboardPresenter, UICollectionViewDataSource, UICollectionViewDelegate {
    
    
    // MARK: - Initialization
    
    public init(
        id: String? = nil,
        viewController: KeyboardInputViewController,
        collectionView: KeyboardCollectionView) {
        self.id = id
        self.viewController = viewController
        self.collectionView = collectionView
        super.init()
        setupCollectionView(collectionView)
        refresh()
    }
    
    
    // MARK: - Setup
    
    open func setupCollectionView(_ view: KeyboardCollectionView) {
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.translatesAutoresizingMaskIntoConstraints = false
    }
    
    
    // MARK: - Dependencies
    
    public unowned let collectionView: KeyboardCollectionView
    public unowned let viewController: KeyboardInputViewController
    
    
    // MARK: - Properties
    
    public let id: String?
    
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
