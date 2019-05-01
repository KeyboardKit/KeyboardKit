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
 at each index path. You may also have to adjust it in other
 ways, override and implement other functions etc., since it
 doesn't do anything else and doesn't handle any taps.
 
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
}
