//
//  KeyboardCollectionView.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2019-04-23.
//  Copyright © 2019 Daniel Saidi. All rights reserved.
//

/*
 
 This view can be used as a base class for a collection view
 that should present keyboard actions in different ways. You
 must subclass it if you want to use it, since it by default
 returns an empty cell for each action.
 
 For convenience, you can use `KeyboardButtonCollectionView`
 and `KeyboardButtonRowCollectionView` instead. They provide
 a lot of functionality for either displaying single buttons
 or button rows.
 
 */

import UIKit

open class KeyboardCollectionView: UICollectionView, KeyboardStackViewComponent, UICollectionViewDataSource {

    
    // MARK: - Initialization
    
    public init(actions: [KeyboardAction]) {
        super.init(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        self.actions = actions
        dataSource = self
        backgroundColor = .clear
        register(UICollectionViewCell.self, forCellWithReuseIdentifier: cellIdentifier)
    }
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.actions = []
    }
    
    
    // MARK: - Properties
    
    public var actions = [KeyboardAction]() {
        didSet { refresh() }
    }
    
    public let cellIdentifier = "Cell"
    
    
    // MARK: - Public Functions
    
    open func refresh() {
        collectionViewLayout.invalidateLayout()
        reloadData()
    }
    
    
    // MARK: - KeyboardComponent
    
    public private(set) lazy var heightConstraint: NSLayoutConstraint = {
        let constraint = heightAnchor.constraint(equalToConstant: 100)
        constraint.isActive = true
        return constraint
    }()
    
    
    // MARK: - UICollectionViewDataSource
    
    open func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    open func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return actions.count
    }
    
    open func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath)
        cell.subviews.forEach { $0.removeFromSuperview() }
        return cell
    }
}
