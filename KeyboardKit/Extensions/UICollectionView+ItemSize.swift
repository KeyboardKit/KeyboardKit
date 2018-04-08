//
//  UICollectionView+ItemSize.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2018-04-08.
//  Copyright © 2018 Daniel Saidi. All rights reserved.
//

import UIKit

public extension UICollectionView {
    
    func itemSizeForGrid(withRows rows: Int, columns: Int) -> CGSize {
        let size = bounds.size
        return itemSizeForGrid(withSize: size, rows: rows, columns: columns)
    }
    
    func itemSizeForGrid(withSize size: CGSize, rows: Int, columns: Int) -> CGSize {
        let space = availableItemSpace(for: size)
        let width = space.width / CGFloat(columns)
        let height = space.height / CGFloat(rows)
        return CGSize(width: width, height: height)
    }
}
