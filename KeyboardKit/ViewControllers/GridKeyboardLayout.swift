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
    
    open func adjustButtonSize(to keyboardSize: CGSize) {
        let size = buttonSize(for: keyboardSize)
        guard size != itemSize else { return }
        itemSize = buttonSize(for: keyboardSize)
        invalidateLayout()
    }
    
    open func buttonHeight(for keyboardSize: CGSize) -> CGFloat {
        let margin = minimumInteritemSpacing
        let totalHeightMargin = margin * CGFloat(rowsPerPage - 1)
        let availableHeight = keyboardSize.height - totalHeightMargin
        return availableHeight / CGFloat(rowsPerPage) - 1
    }
    
    open func buttonSize(for keyboardSize: CGSize) -> CGSize {
        let width = buttonWidth(for: keyboardSize)
        let height = buttonHeight(for: keyboardSize)
        return CGSize(width: width, height: height)
    }
    
    open func buttonWidth(for keyboardSize: CGSize) -> CGFloat {
        let margin = minimumInteritemSpacing
        let totalWidthMargin = margin * CGFloat(buttonsPerRow - 1)
        let availableWidth = keyboardSize.width - totalWidthMargin
        let width = availableWidth / CGFloat(buttonsPerRow)
        return width
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
