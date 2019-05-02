//
//  KeyboardButtonRowCollectionView.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2019-05-02.
//  Copyright © 2019 Daniel Saidi. All rights reserved.
//

import UIKit

open class KeyboardButtonRowCollectionView: KeyboardCollectionView {
    
    
    // MARK: - Initialization
    
    public init(actions: [KeyboardAction], configuration: Configuration, buttonCreator: @escaping KeyboardButtonCreator) {
        self.rows = actions.batched(withBatchSize: configuration.buttonsPerRow)
        self.configuration = configuration
        self.buttonCreator = buttonCreator
        super.init(actions: actions)
        height = configuration.collectionViewHeight
    }
    
    public required init?(coder aDecoder: NSCoder) {
        self.rows = []
        self.configuration = .empty
        self.buttonCreator = { _ in fatalError() }
        super.init(coder: aDecoder)
    }
    
    
    // MARK: - Types
    
    public typealias KeyboardButtonCreator = (KeyboardAction) -> (UIView)
    
    public struct Configuration {

        public init(rowHeight: CGFloat, rowsPerPage: Int, buttonsPerRow: Int) {
            self.rowsPerPage = rowsPerPage
            self.buttonsPerRow = buttonsPerRow
            self.rowHeight = rowHeight
        }

        public let rowHeight: CGFloat
        public let rowsPerPage: Int
        public let buttonsPerRow: Int
        
        public var collectionViewHeight: CGFloat {
            return rowHeight * CGFloat(rowsPerPage)
        }
        
        public static var empty: Configuration {
            return Configuration(rowHeight: 0, rowsPerPage: 0, buttonsPerRow: 0)
        }
    }
    
    
    // MARK: - Properties
    
    private let buttonCreator: KeyboardButtonCreator
    private let configuration: Configuration
    private let rows: [[KeyboardAction]]
    
    
    // MARK: - UICollectionViewDataSource
    
    open func row(at indexPath: IndexPath) -> [KeyboardAction] {
        return rows[indexPath.item]
    }
    
    open override func numberOfItems(inSection section: Int) -> Int {
        return rows.count
    }
    
    open override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = super.collectionView(collectionView, cellForItemAt: indexPath)
        let row = self.row(at: indexPath)
        let rowHeight = configuration.rowHeight
        let rowView = KeyboardButtonRow(height: rowHeight, actions: row, buttonCreator: buttonCreator)
        cell.addSubview(rowView, fill: true)
        return cell
    }
}
