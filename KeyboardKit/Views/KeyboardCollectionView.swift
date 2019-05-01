//
//  KeyboardCollectionView.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2019-04-23.
//  Copyright © 2019 Daniel Saidi. All rights reserved.
//

import UIKit

open class KeyboardCollectionView: UICollectionView, KeyboardStackViewComponent, UICollectionViewDataSource {

    
    // MARK: - Initialization
    
    public convenience init() {
        self.init(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        backgroundColor = .clear
    }
    
    
    // MARK: - Setup
    
    open func setup(with actions: [KeyboardAction], buttonCreator: @escaping KeyboardButtonCreator) {
        self.actions = actions
        self.buttonCreator = buttonCreator
        (collectionViewLayout as? UICollectionViewFlowLayout)?.scrollDirection = .horizontal
        dataSource = self
        isPagingEnabled = true
        register(UICollectionViewCell.self, forCellWithReuseIdentifier: "Cell")
    }
    
    
    // MARK: - Types
    
    public typealias KeyboardButtonCreator = (KeyboardAction) -> (UIView?)
    
    
    // MARK: - Properties
    
    public private(set) var actions = [KeyboardAction]()
    public private(set) var buttonCreator: KeyboardButtonCreator?
    
    
    // MARK: - Public Functions
    
    open func refresh() {
        collectionViewLayout.invalidateLayout()
        reloadData()
    }
    
    
    // MARK: - KeyboardComponent
    
    public lazy var heightConstraint: NSLayoutConstraint = {
        let constraint = heightAnchor.constraint(equalToConstant: 100)
        constraint.isActive = true
        return constraint
    }()
    
    
    // MARK: - UICollectionViewDataSource
    
    open func action(at indexPath: IndexPath) -> KeyboardAction {
        return actions[indexPath.item]
    }
    
    open func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    open func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return actions.count
    }
    
    open func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let action = self.action(at: indexPath)
        let cell = dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath)
        cell.subviews.forEach { $0.removeFromSuperview() }
        guard let button = buttonCreator?(action) else { return cell }
        cell.addSubview(button, fill: true)
        return cell
    }
}
