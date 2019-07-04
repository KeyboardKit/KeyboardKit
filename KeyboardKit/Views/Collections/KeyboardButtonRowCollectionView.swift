//
//  KeyboardButtonRowCollectionView.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2019-05-02.
//  Copyright © 2019 Daniel Saidi. All rights reserved.
//

/*
 
 This view can be created with a set of actions and a button
 creator block. It creates and adds a button for each action
 to a horizontal `buttonStackView`. This stack view can then
 be added to the keyboard view controller's main stack view.
 
 */

import UIKit

open class KeyboardButtonRowCollectionView: KeyboardCollectionView, PagedKeyboardComponent, UICollectionViewDelegate {
    
    
    // MARK: - Initialization
    
    public init(
        id: String = "KeyboardButtonRowCollectionView",
        actions: [KeyboardAction],
        configuration: Configuration,
        buttonCreator: @escaping KeyboardButtonCreator) {
        self.id = id
        self.rows = actions.rows(for: configuration)
        self.configuration = configuration
        self.buttonCreator = buttonCreator
        super.init(actions: actions)
        setup()
    }
    
    public required init?(coder aDecoder: NSCoder) {
        self.id = ""
        self.rows = []
        self.configuration = .empty
        self.buttonCreator = { _ in fatalError() }
        super.init(coder: aDecoder)
        setup()
    }
    
    
    // MARK: - Setup
    
    func setup() {
        delegate = self
        isPagingEnabled = true
        height = configuration.totalHeight
        collectionViewLayout = Layout(rowHeight: configuration.rowHeight)
    }
    
    
    // MARK: - View Lifecycle
    
    open override func layoutSubviews() {
        restoreCurrentPage()
        super.layoutSubviews()
    }
    
    open func restoreCurrentPage() {
        restoreCurrentPageIndex()
    }
    
    
    // MARK: - Types
    
    public typealias KeyboardButtonCreator = (KeyboardAction) -> (UIView)
    
    public struct Configuration {

        public init(rowHeight: CGFloat, rowsPerPage: Int, buttonsPerRow: Int) {
            self.rowsPerPage = rowsPerPage
            self.buttonsPerRow = buttonsPerRow
            self.rowHeight = rowHeight
            self.pageSize = rowsPerPage * buttonsPerRow
        }

        public let rowHeight: CGFloat
        public let rowsPerPage: Int
        public let buttonsPerRow: Int
        public let pageSize: Int
        
        public var totalHeight: CGFloat {
            return rowHeight * CGFloat(rowsPerPage)
        }
        
        public static var empty: Configuration {
            return Configuration(rowHeight: 0, rowsPerPage: 0, buttonsPerRow: 0)
        }
    }
    
    public class Layout: UICollectionViewFlowLayout {
        
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
        
        public override func invalidateLayout() {
            super.invalidateLayout()
            let width = collectionView?.bounds.width ?? 0
            guard width > 0 else { return }
            itemSize = CGSize(width: width, height: rowHeight)
        }
        
        public let rowHeight: CGFloat
    }
    
    
    // MARK: - Properties
    
    public let id: String
    public let configuration: Configuration
    public let rows: KeyboardActionRows
    
    private let buttonCreator: KeyboardButtonCreator
    
    
    // MARK: - PagedKeyboardViewController
    
    open var canPersistPageIndex: Bool {
        return !isDragging
    }
    
    open var canRestorePageIndex: Bool {
        return !isDragging
    }
    
    public var numberOfPages: Int {
        let numberOfRows = Double(rows.count)
        let rowsPerPage = Double(configuration.rowsPerPage)
        let pages = ceil(numberOfRows / rowsPerPage)
        return Int(pages)
    }
    
    
    // MARK: - UICollectionViewDataSource
    
    open func row(at indexPath: IndexPath) -> KeyboardActionRow {
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
    
    
    // MARK: - UICollectionViewDelegate
    
    open func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        persistCurrentPageIndex()
    }
}


// MARK: - Private KeyboardAction Array Extensions

private extension Array where Element == KeyboardAction {
    
    func rows(for configuration: KeyboardButtonRowCollectionView.Configuration) -> KeyboardActionRows {
        var actions = self
        while actions.count % configuration.pageSize > 0 {
            actions.append(.none)
        }
        return actions.batched(withBatchSize: configuration.buttonsPerRow)
    }
}
