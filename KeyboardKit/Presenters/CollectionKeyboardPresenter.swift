//
//  CollectionKeyboardPresenter.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2019-04-27.
//  Copyright © 2019 Daniel Saidi. All rights reserved.
//

/*
 
 This presenter requires a collection view, which by default
 is given one section with as many items as the keyboard has
 actions. The presenter will set itself up as the collection
 view data source and delegate.
 
 Whenever you use this presenter, you must inherit it and at
 the very least override `collectionView(cellForItemAt:)` to
 specify which cell to use for each action.
 
 To get the keyboard action at a certain index path, you can
 use the `keyboardAction(at:)` function.
 
 */

import UIKit

open class CollectionKeyboardPresenter: NSObject, KeyboardPresenter/*, UICollectionViewDataSource, UICollectionViewDelegate*/ {
    
    
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
//
    public lazy var collectionView: KeyboardCollectionView = {
        let layout = UICollectionViewFlowLayout()
        return KeyboardCollectionView(frame: .zero, collectionViewLayout: layout)
//        collectionView.delegate = self
//        collectionView.dataSource = self
//        collectionView.translatesAutoresizingMaskIntoConstraints = false
//        collectionView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
//        collectionView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
//        collectionView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
//        collectionViewHeight = collectionView.heightAnchor.constraint(equalToConstant: 100)
//        collectionViewHeight?.isActive = true
    }()
    
    
    // MARK: - KeyboardPresenter
    
    open func refresh() {
//        collectionView.collectionViewLayout.invalidateLayout()
    }
    
    public func setup(with keyboard: Keyboard, in viewController: KeyboardInputViewController) {
        
    }
    
    
    // MARK: - Public Functions
    
//    open func keyboardAction(at indexPath: IndexPath) -> KeyboardAction? {
//        return keyboard.actions[indexPath.row]
//    }
    
    
    // MARK: - UICollectionViewDataSource
    
//    open func numberOfSections(in collectionView: UICollectionView) -> Int {
//        return 1
//    }
//
//    open func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        return keyboard.actions.count
//    }
//
//    open func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        return UICollectionViewCell()
//    }
    
    
    // MARK: - UICollectionViewDelegate
    
//    open func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        guard let action = keyboardAction(at: indexPath) else { return }
//        let actionHandler = viewController.keyboardActionHandler
//        actionHandler.handleTap(on: action)
//    }
}
