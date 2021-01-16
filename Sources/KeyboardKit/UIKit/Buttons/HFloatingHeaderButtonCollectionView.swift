//
//  CustomButtonRowCollectionView.swift
//  KeyboardKitDemoKeyboard
//
//  Created by 于留传 on 2021/1/16.
//

import UIKit

open class HFloatingHeaderButtonCollectionView: KeyboardCollectionView, HorizontalFloatingHeaderLayoutDelegate, UICollectionViewDelegate{
    
    // MARK: - Initialization
    public init(
        id: String = "HFloatingHeaderButtonCollectionView",
        categoryActions: [(String, KeyboardActions)],
        configuration: Configuration,
        buttonCreator: @escaping KeyboardButtonCreator){
        self.id = id
        self.categoryActions = categoryActions
        self.categorySectionAction = Self.createCategorySectionAction(for: categoryActions)
        self.configuration = configuration
        self.buttonCreator = buttonCreator
        super.init(actions: []) // Unused
        setup()
    }
    
    public required init?(coder aDecoder: NSCoder) {
        self.id = ""
        self.categoryActions = []
        self.categorySectionAction = []
        self.configuration = .empty
        self.buttonCreator = { _ in fatalError() }
        super.init(coder: aDecoder)
        setup()
    }
    
    // MARK: - Setup
    
    func setup(){
        dataSource = self
        delegate = self
        height = configuration.totalHeight
        collectionViewLayout = HorizontalFloatingHeaderLayout()
        register(UICollectionReusableView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: headerIdentifier)
    }
    
    // MARK: - Types
    public typealias KeyboardButtonCreator = (KeyboardAction) -> (UIView)
    
    public struct Configuration{
        public init(headerHeight: CGFloat, rowHeight: CGFloat, rowsCount: Int){
            self.headerHeight = headerHeight
            self.rowHeight = rowHeight
            self.rowsCount = rowsCount
        }
        
        public let headerHeight: CGFloat
        public let rowHeight: CGFloat
        public let rowsCount: Int
        
        public var totalHeight: CGFloat{
            headerHeight + rowHeight * CGFloat(rowsCount)
        }
        
        public static var empty: Configuration{
            Configuration(headerHeight: 0, rowHeight: 0, rowsCount: 0 )
        }
    }
    // MARK: - Properties
    public let headerIdentifier = "Header"
    
    public let id: String
    public let configuration: Configuration
    public let categoryActions: [(String, KeyboardActions)]
    private let categorySectionAction: [(String, Int, Int)]
    private let buttonCreator: KeyboardButtonCreator
    // MARK: - Category
    
    static func createCategorySectionAction(for categoryActions: [(String, KeyboardActions)]) -> [(String, Int, Int)] {
        categoryActions.enumerated().map { (index: Int, arg1) -> (String, Int, Int) in
            let (cat, actions) = arg1
            return (cat, index, actions.count)
        }
    }
    
    // MARK: - UICollectionViewDataSource
    // Number of Sections
    open override func numberOfSections(in collectionView: UICollectionView) -> Int {
        self.categorySectionAction.count
    }

    // Number of Items
    open override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let index = self.categorySectionAction.first(where: { $0.1 == section }) else { return 0 }
        return index.2
    }

    // Cells
    open override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = super.collectionView(collectionView, cellForItemAt: indexPath)
        cell.subviews.forEach { $0.removeFromSuperview() }
        let action = self.categoryActions[indexPath.section].1[indexPath.item]
        cell.addSubview(self.buttonCreator(action), fill: true)
        return cell
    }
    
    // Headers
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let cell = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: headerIdentifier, for: indexPath)
        cell.subviews.forEach { $0.removeFromSuperview() }
        let titleLabel = UILabel()
        titleLabel.text = self.categoryActions[indexPath.section].0
        titleLabel.textColor = UIColor(white: 0.6, alpha: 1.0)
        titleLabel.font = UIFont.boldSystemFont(ofSize: UIFont.labelFontSize)
        cell.addSubview(titleLabel, fill: true)
        return cell
    }

    // MARK: - HorizontalFloatingHeaderDelegate
    
    // Item Size
    public func collectionView(_ collectionView: UICollectionView, horizontalFloatingHeaderItemSizeAt indexPath: IndexPath) -> CGSize {
        return CGSize(width:48, height: 48)
    }
    
    // Header Size
    public func collectionView(_ collectionView: UICollectionView, horizontalFloatingHeaderSizeAt section: Int) -> CGSize {
        return CGSize(width:200, height:30)
    }
    
    // Vertial Spacing: Spacing Between Vertial Items
    public func collectionView(_ collectionView: UICollectionView, horizontalFloatingHeaderItemSpacingForSectionAt section: Int) -> CGFloat {
        return 0.0
    }
    
    // Horizontal Spacing: Spacing Between Horizontal Items
    public func collectionView(_ collectionView: UICollectionView, horizontalFloatingHeaderColumnSpacingForSectionAt section: Int) -> CGFloat {
        return 0.0
    }
    
    // Section Insets
    public func collectionView(_ collectionView: UICollectionView, horizontalFloatingHeaderSectionInsetAt section: Int) -> UIEdgeInsets {
        switch section{
        case 0:
            return UIEdgeInsets(top: 8, left: 0, bottom: 0, right: 0)
        default:
            return UIEdgeInsets(top: 8, left: 8, bottom: 0, right: 0)
        }
    }
}

public extension HFloatingHeaderButtonCollectionView{
    @objc func moveToSection(bySection section: Int){
        guard section <= self.categorySectionAction.count else { return }
        self.scrollToItem(at: IndexPath(item: 0, section: section), at: .left, animated: true)
    }
    
    @objc func moveToSection(byCategory category: String){
        guard let index = self.categorySectionAction.first(where: { $0.0 == category }) else { return }
        self.moveToSection(bySection: index.1)
    }
}
