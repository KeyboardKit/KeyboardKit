//
//  HorizontalFloatingHeaderLayout.swift
//
//  Created by 于留传 on 2021/1/15.
//  Original by Diego Alberto Cruz Castillo on 12/30/15.
//
//  This is an adjusted version of this implementation:
//  https://github.com/tysonkerridge/HorizontalFloatingHeaderLayout/blob/master/Pod/Classes/HorizontalFloatingHeaderLayout.swift
//

import KeyboardKit
import UIKit

@objc public protocol HorizontalFloatingHeaderLayoutDelegate: AnyObject {
    
    // Item size
    func collectionView(_ collectionView: UICollectionView, horizontalFloatingHeaderItemSizeAt indexPath: IndexPath) -> CGSize
    
    // Header size
    func collectionView(_ collectionView: UICollectionView, horizontalFloatingHeaderSizeAt section: Int) -> CGSize
    
    // Section Inset
    @objc optional func collectionView(_ collectionView: UICollectionView, horizontalFloatingHeaderSectionInsetAt section: Int) -> UIEdgeInsets
    
    // Item Spacing
    @objc optional func collectionView(_ collectionView: UICollectionView, horizontalFloatingHeaderItemSpacingForSectionAt section: Int) -> CGFloat
    
    // Line Spacing
    @objc optional func collectionView(_ collectionView: UICollectionView, horizontalFloatingHeaderColumnSpacingForSectionAt section: Int) -> CGFloat
}


public class HorizontalFloatingHeaderLayout: UICollectionViewLayout {
        
    // MARK: - Properties
    
    public override var collectionViewContentSize: CGSize {
        get { return getContentSize() }
    }
    
    
    // MARK: Headers properties
    
    // Variables
    private var sectionHeadersAttributes: [IndexPath : UICollectionViewLayoutAttributes] {
        get { return getSectionHeadersAttributes() }
    }
    
    
    // MARK: Items properties
    
    // Variables
    private var itemAttributes = [IndexPath : UICollectionViewLayoutAttributes]()
    
    
    // MARK: - PrepareForLayout methods
    
    public override func prepare() {
        prepareItemsAttributes()
    }
    
    // Items
    private func prepareItemsAttributes() {
        
        // Ensure we have a collection view else we have nothing to do
        guard let collectionView = self.collectionView else { return }
        
        // Remove all current item attributes
        itemAttributes.removeAll()
        
        // Get the number of sections we'll be displaying
        let sectionCount = collectionView.numberOfSections
        
        // Ensure we have at least one section to prepare items for
        guard sectionCount > 0 else { return }
        
        // Set up values to keep track of
        var currentMinX: CGFloat = 0
        var currentMinY: CGFloat = 0
        var currentMaxX: CGFloat = 0
        
        // Work for configuring the values for each section
        func configureVariables(forSection section: Int) {
            let sectionInset = inset(ForSection: section)
            let lastSectionInset = inset(ForSection: section - 1)
            currentMinX = (currentMaxX + sectionInset.left + lastSectionInset.right)
            currentMinY = sectionInset.top + headerSize(forSection: section).height
            currentMaxX = 0.0
        }
        
        // Work for creating the attributes for each item
        func itemAttribute(at indexPath: IndexPath) -> UICollectionViewLayoutAttributes {
            
            // Applying corrected layout
            func newLineOrigin(size: CGSize) -> CGPoint {
                let x = currentMaxX + columnSpacing(forSection: indexPath.section)
                let y = inset(ForSection: indexPath.section).top + headerSize(forSection: indexPath.section).height
                return CGPoint(x: x, y: y)
            }
            
            func sameLineOrigin(size: CGSize) -> CGPoint {
                return CGPoint(x: currentMinX, y: currentMinY)
            }
            
            func updateVariables(itemFrame frame: CGRect) {
                currentMaxX = max(currentMaxX, frame.maxX)
                currentMinX = frame.minX
                currentMinY = frame.maxY + itemSpacing(forSection: indexPath.section)
            }
            
            //
            let size = itemSize(for: indexPath)
            let yFloatTolerance: CGFloat = 0.0001 // Float tolerance due to comparing equality of floats in relation to what will actually be displaid
            let newMaxY = currentMinY + size.height
            let origin: CGPoint
            if (newMaxY - yFloatTolerance) > availableHeight(atSection: indexPath.section) {
                origin = newLineOrigin(size: size)
            } else {
                origin = sameLineOrigin(size: size)
            }
            let frame = CGRect(origin: origin, size: size)
            let attribute = UICollectionViewLayoutAttributes(forCellWith: indexPath)
            attribute.frame = frame
            updateVariables(itemFrame: frame)
            return attribute
        }
        
        // Create the attributes for the items in each section
        for section in 0..<sectionCount {
            
            configureVariables(forSection: section)
            let itemCount = collectionView.numberOfItems(inSection: section)
            
            // We're done if there's no items for this section
            guard itemCount > 0 else { continue }
            
            // Create the attributes for each item
            for index in 0..<itemCount {
                let indexPath = IndexPath(row: index, section: section)
                let attribute = itemAttribute(at: indexPath)
                itemAttributes[indexPath] = attribute
            }
        }
    }
    
    
    // MARK: - LayoutAttributesForElementsInRect methods
    
    override public func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        
        // Get the item & section attributes within the rect
        let attributesAreWithinRect = { (attributes: UICollectionViewLayoutAttributes) in attributes.frame.intersects(rect) }
        let itemsA = itemAttributes.values.filter(attributesAreWithinRect)
        let headersA = sectionHeadersAttributes.values.filter(attributesAreWithinRect)
        return itemsA + headersA
    }
    
    
    //MARK: - ContentSize methods
    
    private func getContentSize() -> CGSize {
        
        guard let collectionView = collectionView else {
            return CGSize.zero
        }
        
        func lastItemMaxX() -> CGFloat {
            let lastSection = collectionView.numberOfSections - 1
            guard lastSection >= 0 else { return 0 }
            let lastIndexInSection = collectionView.numberOfItems(inSection: lastSection) - 1
            if let lastItemAttributes = layoutAttributesForItem(at: IndexPath(row: lastIndexInSection, section: lastSection)) {
                return lastItemAttributes.frame.maxX
            } else {
                return 0
            }
        }
        
        let lastSection = collectionView.numberOfSections - 1
        let contentWidth = lastItemMaxX() + inset(ForSection: lastSection).right
        let safeAreaInsets: UIEdgeInsets = { if #available(iOS 11.0, *) { return collectionView.safeAreaInsets } else { return .zero } }()
        let contentHeight = collectionView.bounds.height - collectionView.contentInset.top - collectionView.contentInset.bottom - safeAreaInsets.top - safeAreaInsets.bottom
        return CGSize(width: contentWidth, height: contentHeight)
        
    }
    
    
    // MARK: - LayoutAttributes methods
    
    // MARK: For ItemAtIndexPath
    
    public override func layoutAttributesForItem(at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        return itemAttributes[indexPath]
    }
    
    
    // MARK: For SupplementaryViewOfKind
    
    public override func layoutAttributesForSupplementaryView(ofKind elementKind: String, at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        
        switch elementKind {
        case UICollectionView.elementKindSectionHeader:
            return sectionHeadersAttributes[indexPath]
        default:
            return nil
        }
        
    }
    
    
    // MARK: - Utility methods
    
    // MARK: SectionHeaders Attributes methods
    
    private func getSectionHeadersAttributes() -> [IndexPath : UICollectionViewLayoutAttributes] {
        
        func attributeForSectionHeader(at indexPath: IndexPath) -> UICollectionViewLayoutAttributes {
            
            func size() -> CGSize {
                return headerSize(forSection: indexPath.section)
            }
            
            func position() -> CGPoint {
                if let itemsCount = collectionView?.numberOfItems(inSection: indexPath.section),
                    let firstItemAttributes = layoutAttributesForItem(at: indexPath),
                    let lastItemAttributes = layoutAttributesForItem(at: IndexPath(row: itemsCount - 1, section: indexPath.section)) {
                    let safeAreaInsets: UIEdgeInsets = { if #available(iOS 11.0, *) { return collectionView!.safeAreaInsets } else { return .zero } }()
                    let edgeX = collectionView!.contentOffset.x + collectionView!.contentInset.left + safeAreaInsets.left
                    let xByLeftBoundary = max(edgeX, firstItemAttributes.frame.minX)
                    let width = size().width
                    let xByRightBoundary = lastItemAttributes.frame.maxX - width
                    let x = min(xByLeftBoundary,xByRightBoundary)
                    return CGPoint(x: x, y: 0)
                } else {
                    return CGPoint(x: inset(ForSection: indexPath.section).left, y: 0)
                }
                
            }
            
            let attribute = UICollectionViewLayoutAttributes(forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, with: indexPath)
            attribute.frame = CGRect(origin: position(), size: size())
            return attribute
        }
        
        guard let collectionView = collectionView else {
            return [:]
        }
        
        let sectionCount = collectionView.numberOfSections
        guard sectionCount > 0 else {
            return [:]
        }
        
        var attributes = [IndexPath : UICollectionViewLayoutAttributes]()
        for section in 0..<sectionCount {
            let indexPath = IndexPath(row: 0, section: section)
            attributes[indexPath] = attributeForSectionHeader(at: indexPath)
        }
        
        return attributes
    }
    
    
    // MARK: - Invalidating layout methods
    
    public override func shouldInvalidateLayout(forBoundsChange newBounds: CGRect) -> Bool {
        return true
    }
    
    public override func invalidationContext(forBoundsChange newBounds: CGRect) -> UICollectionViewLayoutInvalidationContext {
        
        func isSizeChanged() -> Bool {
            let oldBounds = collectionView?.bounds ?? .zero
            return oldBounds.size != newBounds.size
        }
        
        func headersIndexPaths() -> [IndexPath] {
            return Array(sectionHeadersAttributes.keys)
        }
        
        let context = super.invalidationContext(forBoundsChange: newBounds)
        if !isSizeChanged() {
            context.invalidateSupplementaryElements(ofKind: UICollectionView.elementKindSectionHeader, at: headersIndexPaths())
        }
        return context
    }
    
    
    // MARK: - Utility methods
    
    private func itemSize(for indexPath: IndexPath) -> CGSize {
        guard let collectionView = collectionView,
            let delegate = collectionView.delegate as? HorizontalFloatingHeaderLayoutDelegate else {
                return CGSize.zero
        }
        
        return delegate.collectionView(collectionView, horizontalFloatingHeaderItemSizeAt: indexPath)
    }
    
    private func headerSize(forSection section: Int) -> CGSize {
        guard let collectionView = collectionView,
            let delegate = collectionView.delegate as? HorizontalFloatingHeaderLayoutDelegate,
            section >= 0 else {
                return CGSize.zero
        }
        
        return delegate.collectionView(collectionView, horizontalFloatingHeaderSizeAt: section)
    }
    
    private func inset(ForSection section: Int) -> UIEdgeInsets {
        let defaultValue = UIEdgeInsets.zero
        guard let collectionView = collectionView,
            let delegate = collectionView.delegate as? HorizontalFloatingHeaderLayoutDelegate,
            section >= 0 else {
                return defaultValue
        }
        
        return delegate.collectionView?(collectionView, horizontalFloatingHeaderSectionInsetAt: section) ?? defaultValue
    }
    
    private func columnSpacing(forSection section:Int) -> CGFloat {
        let defaultValue: CGFloat = 0.0
        guard let collectionView = collectionView,
            let delegate = collectionView.delegate as? HorizontalFloatingHeaderLayoutDelegate,
            section >= 0 else {
                return defaultValue
        }
        
        return delegate.collectionView?(collectionView, horizontalFloatingHeaderColumnSpacingForSectionAt: section) ?? defaultValue
    }
    
    private func itemSpacing(forSection section: Int) -> CGFloat {
        let defaultValue:CGFloat = 0.0
        guard let collectionView = collectionView,
            let delegate = collectionView.delegate as? HorizontalFloatingHeaderLayoutDelegate,
            section >= 0 else {
                return defaultValue
        }
        
        return delegate.collectionView?(collectionView, horizontalFloatingHeaderItemSpacingForSectionAt: section) ?? defaultValue
    }
    
    private func availableHeight(atSection section: Int) -> CGFloat {
        
        // Ensure we have a collection view and the section is positive
        guard let collectionView = collectionView, section >= 0 else { return 0.0 }
        
        func totalInset() -> CGFloat {
            let sectionInset = inset(ForSection: section)
            let contentInset = collectionView.contentInset
            return sectionInset.top + sectionInset.bottom + contentInset.top + contentInset.bottom
        }
        
        return collectionView.bounds.height - totalInset()
    }
}
