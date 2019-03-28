//
//  CollectionKeyboardViewController.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2018-03-13.
//  Copyright © 2018 Daniel Saidi. All rights reserved.
//

/*
 
 This input view controller provides a collection view-based
 setup with no built-in functionality or configuration. It's
 meant to be used as a base class for other view controllers.
 
 */

import UIKit

open class CollectionKeyboardViewController: KeyboardViewController, UICollectionViewDataSource, UICollectionViewDelegate {

    
    // MARK: - View Controller Lifecycle
    
    open override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionView()
    }
    
    
    // MARK: - View Properties
    
    open lazy var collectionView = UICollectionView(frame: .zero, collectionViewLayout: collectionViewLayout)
    
    
    // MARK: - Properties
    
    open var collectionViewHeightAnchorConstraint: NSLayoutConstraint?
    
    open var collectionViewLayout = UICollectionViewFlowLayout() {
        didSet { collectionView.collectionViewLayout = collectionViewLayout }
    }
    
    
    // MARK: - Setup
    
    open func setupCollectionView() {
        collectionView.bounces = false
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.frame = view.frame
        collectionView.isPagingEnabled = true
        collectionView.backgroundColor = .clear
        view.addSubview(collectionView)
        setupCollectionViewConstraints()
    }
    
    open func setupCollectionViewConstraints() {
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        collectionView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        collectionView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        collectionViewHeightAnchorConstraint = collectionView.heightAnchor.constraint(equalToConstant: 100)
        collectionViewHeightAnchorConstraint?.isActive = true
    }
    
    
    // MARK: - Public Functions
    
    open func action(at indexPath: IndexPath) -> KeyboardAction? {
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
        guard let action = action(at: indexPath) else { return }
        handleTap(on: action)
    }
}
