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
        isPagingEnabled = true
        height = configuration.totalHeight
        collectionViewLayout = Layout(rowHeight: configuration.rowHeight)
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
        
        public var totalHeight: CGFloat {
            return rowHeight * CGFloat(rowsPerPage)
        }
        
        public static var empty: Configuration {
            return Configuration(rowHeight: 0, rowsPerPage: 0, buttonsPerRow: 0)
        }
    }
    
    class Layout: UICollectionViewFlowLayout {
        
        init(rowHeight: CGFloat) {
            self.rowHeight = rowHeight
            super.init()
            minimumInteritemSpacing = 0
            minimumLineSpacing = 0
            scrollDirection = .horizontal
        }
        
        required init?(coder aDecoder: NSCoder) {
            rowHeight = 0
            super.init(coder: aDecoder)
        }
        
        override func invalidateLayout() {
            super.invalidateLayout()
            let width = collectionView?.bounds.width ?? 0
            guard width > 0 else { return }
            itemSize = CGSize(width: width, height: rowHeight)
        }
        
        private var rowHeight: CGFloat
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
        let rowView = self.collectionView(collectionView, rowViewForItemAt: indexPath)
        cell.addSubview(rowView, fill: true)
        return cell
    }
    
    open func collectionView(_ collectionView: UICollectionView, rowViewForItemAt indexPath: IndexPath) -> KeyboardButtonRow {
        let row = self.row(at: indexPath)
        let rowHeight = configuration.rowHeight
        return KeyboardButtonRow(height: rowHeight, actions: row, buttonCreator: buttonCreator)
    }
}
