//
//  UICollectionView+ItemSpace.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2018-04-08.
//  Copyright © 2018 Daniel Saidi. All rights reserved.
//

/*
 
 This extensions can be used to calculate how much available
 total item space a collection view has after content insets
 are removed.
 
 */

import UIKit

extension UICollectionView {
    
    var availableItemSpace: CGSize {
        return availableItemSpace(for: bounds.size)
    }
    
    func availableItemSpace(for size: CGSize) -> CGSize {
        let inset = contentInset
        let horizontalInset = inset.left + inset.right
        let verticalInset = inset.top + inset.bottom
        let width = size.width - horizontalInset
        let height = size.height - verticalInset
        return CGSize(width: width, height: height)
    }
}
