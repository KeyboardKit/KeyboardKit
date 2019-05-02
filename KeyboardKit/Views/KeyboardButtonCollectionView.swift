//
//  KeyboardButtonCollectionView.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2019-05-02.
//  Copyright © 2019 Daniel Saidi. All rights reserved.
//

/*
 
 This collection view displays a single button cell for each
 keyboard action. You can customize it and its appearance in
 any way you want, e.g. by setting a custom flow layout.
 
 */

import UIKit

open class KeyboardButtonCollectionView: KeyboardCollectionView {
    
    
    // MARK: - Initialization
    
    public init(actions: [KeyboardAction], buttonCreator: @escaping KeyboardButtonCreator) {
        super.init(actions: actions)
        self.buttonCreator = buttonCreator
    }
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.actions = []
        self.buttonCreator = { _ in fatalError() }
    }
    
    
    // MARK: - Types
    
    public typealias KeyboardButtonCreator = (KeyboardAction) -> (UIView?)
    
    
    // MARK: - Properties
    
    public var buttonCreator: KeyboardButtonCreator? {
        didSet { refresh() }
    }
    
    
    // MARK: - UICollectionViewDataSource
    
    open func action(at indexPath: IndexPath) -> KeyboardAction {
        return actions[indexPath.item]
    }
    
    open override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = super.collectionView(collectionView, cellForItemAt: indexPath)
        let action = self.action(at: indexPath)
        guard let button = buttonCreator?(action) else { return cell }
        cell.addSubview(button, fill: true)
        return cell
    }
}
