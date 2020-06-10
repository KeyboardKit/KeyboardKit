//
//  KeyboardButtonCollectionView.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2019-05-02.
//  Copyright © 2019 Daniel Saidi. All rights reserved.
//

import UIKit

/**
 This collection view displays a single cell for each action,
 using the provided `buttonCreator` function which maps each
 action to a view.
 
 Since this is a `UICollectionView`, you can customize it in
 any way you want, e.g. by setting a custom flow layout.
 */
open class KeyboardButtonCollectionView: KeyboardCollectionView {
    
    
    // MARK: - Initialization
    
    public init(actions: [KeyboardAction], buttonCreator: @escaping KeyboardButtonCreator) {
        self.buttonCreator = buttonCreator
        super.init(actions: actions)
    }
    
    public required init?(coder aDecoder: NSCoder) {
        self.buttonCreator = { _ in fatalError() }
        super.init(coder: aDecoder)
    }
    
    
    // MARK: - Types
    
    public typealias KeyboardButtonCreator = (KeyboardAction) -> (UIView)
    
    
    // MARK: - Properties
    
    private let buttonCreator: KeyboardButtonCreator
    
    
    // MARK: - UICollectionViewDataSource
    
    open func action(at indexPath: IndexPath) -> KeyboardAction {
        return actions[indexPath.item]
    }
    
    open override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = super.collectionView(collectionView, cellForItemAt: indexPath)
        let action = self.action(at: indexPath)
        let button = buttonCreator(action)
        cell.addSubview(button, fill: true)
        return cell
    }
}
