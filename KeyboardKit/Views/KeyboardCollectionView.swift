//
//  KeyboardCollectionView.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2019-04-23.
//  Copyright © 2019 Daniel Saidi. All rights reserved.
//

import UIKit

open class KeyboardCollectionView: UICollectionView, KeyboardStackViewComponent {

    
    // MARK: - Initialization
    
    public convenience init() {
        self.init(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
    }
    
    
    // MARK: - Setup
    
    open func setup(with actions: [KeyboardAction], buttonCreator: KeyboardCellCreator) {
        bounces = false
        isPagingEnabled = true
        backgroundColor = .clear
    }
    
    
    // MARK: - Types
    
    public typealias KeyboardCellCreator = (KeyboardAction) -> (UICollectionViewCell)
    
    
    // MARK: - KeyboardComponent
    
    public lazy var heightConstraint: NSLayoutConstraint = {
        let constraint = heightAnchor.constraint(equalToConstant: 100)
        constraint.isActive = true
        return constraint
    }()
}
