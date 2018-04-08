//
//  GridKeyboardLayout.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2018-03-09.
//  Copyright © 2018 Daniel Saidi. All rights reserved.
//

/*
 
 This layout is used by the grid-based collection view-based
 `GridCollectionKeyboardInputViewController` and distributes
 the keyboard buttons evenly within the available size given
 a certain number of rows and buttons per row.
 
 */

import UIKit

open class GridKeyboardLayout: UICollectionViewFlowLayout {
    
    
    // MARK: - Initialization
    
    public init(rowsPerPage: Int, buttonsPerRow: Int) {
        self.rowsPerPage = rowsPerPage
        self.buttonsPerRow = buttonsPerRow
        super.init()
        scrollDirection = .horizontal
    }
    
    public required init?(coder aDecoder: NSCoder) {
        rowsPerPage = 0
        buttonsPerRow = 0
        super.init(coder: aDecoder)
        scrollDirection = .horizontal
    }
    
    
    // MARK: - Properties
    
    public let rowsPerPage: Int
    public let buttonsPerRow: Int
    
    
    // MARK: - Public Functions
    
    open func adjustButtonSize(for view: UICollectionView) {
        guard let view = collectionView else { return }
        let size = view.bounds.size
        let rows = rowsPerPage
        let cols = buttonsPerRow
        let itemSize = view.itemSizeForGrid(withSize: size, rows: rows, columns: cols)
        guard self.itemSize != itemSize else { return }
        self.itemSize = itemSize
        invalidateLayout()
    }
    
    public func sourceIndexPathForItem(at indexPath: IndexPath) -> IndexPath {
        let row = Int(indexPath.row/rowsPerPage) + buttonsPerRow * (indexPath.row % rowsPerPage)
        return IndexPath(row: row, section: indexPath.section)
    }
    
    public func targetIndexPathForItem(at indexPath: IndexPath) -> IndexPath {
        let row = Int(indexPath.row/buttonsPerRow) + rowsPerPage * (indexPath.row % buttonsPerRow)
        return IndexPath(row: row, section: indexPath.section)
    }
}
