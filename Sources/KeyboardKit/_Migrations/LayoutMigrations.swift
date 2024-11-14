import Foundation
import SwiftUI

public extension InputSet {

    @available(*, deprecated, renamed: "ItemRow", message: "Migration Deprecation, will be removed in 9.1!")
    typealias Row = ItemRow

    @available(*, deprecated, renamed: "ItemRows", message: "Migration Deprecation, will be removed in 9.1!")
    typealias Rows = ItemRows
}

public extension InputSet.ItemRow {

    @available(*, deprecated, message: "Migration Deprecation, will be removed in 9.1! This is destructive, and can't be used to dynamically resolve a device-specific layout. Use the variations-based initializer instead.")
    init(
        phone: String,
        pad: String,
        deviceType: DeviceType = .current
    ) {
        self.init(chars: deviceType == .pad ? pad : phone)
    }

    @available(*, deprecated, message: "Migration Deprecation, will be removed in 9.1! This is destructive, and can't be used to dynamically resolve a device-specific layout. Use the variations-based initializer instead.")
    init(
        phone: [String],
        pad: [String],
        deviceType: DeviceType = .current
    ) {
        self.init(chars: deviceType == .pad ? pad : phone)
    }

    @available(*, deprecated, message: "Migration Deprecation, will be removed in 9.1! This is destructive, and can't be used to dynamically resolve a device-specific layout. Use the variations-based initializer instead.")
    init(
        phoneLowercased: String,
        phoneUppercased: String,
        padLowercased: String,
        padUppercased: String,
        deviceType: DeviceType = .current
    ) {
        self.init(
            lowercased: deviceType == .pad ? padLowercased : phoneLowercased,
            uppercased: deviceType == .pad ? padUppercased : phoneUppercased
        )
    }

    @available(*, deprecated, message: "Migration Deprecation, will be removed in 9.1! This is destructive, and can't be used to dynamically resolve a device-specific layout. Use the variations-based initializer instead.")
    init(
        phoneLowercased: [String],
        phoneUppercased: [String],
        padLowercased: [String],
        padUppercased: [String],
        deviceType: DeviceType = .current
    ) {
        self.init(
            lowercased: deviceType == .pad ? padLowercased : phoneLowercased,
            uppercased: deviceType == .pad ? padUppercased : phoneUppercased
        )
    }
}

@available(*, deprecated, message: "Migration Deprecation, will be removed in 9.1!")
public extension KeyboardLayoutService where Self == KeyboardLayout.DisabledService {

    static var disabled: Self {
        KeyboardLayout.DisabledService()
    }
}

extension KeyboardLayout {

    @available(*, deprecated, message: "Migration Deprecation, will be removed in 9.1!")
    open class DisabledService: KeyboardLayout.BaseService {

        public init() {
            super.init(
                alphabeticInputSet: .qwerty,
                numericInputSet: .numeric(currency: "$"),
                symbolicInputSet: .symbolic(currencies: ["€£¥"])
            )
        }
    }
}


@available(*, deprecated, message: "Migration Deprecation, will be removed in 9.1! Use KeyboardLayout.Item collection operations instead.")
public protocol KeyboardLayoutIdentifiable {

    associatedtype ID: Equatable

    /// The layout-specific item identifier.
    var rowId: ID { get }
}

@available(*, deprecated, message: "Migration Deprecation, will be removed in 9.1! Use KeyboardLayout.Item collection operations instead.")
extension InputSet.Item: KeyboardLayoutIdentifiable {

    public var rowId: Self { self }
}

@available(*, deprecated, message: "Migration Deprecation, will be removed in 9.1! Use KeyboardLayout.Item collection operations instead.")
extension KeyboardLayout.Item: KeyboardLayoutIdentifiable {

    public var rowId: KeyboardAction { action }
}

@available(*, deprecated, message: "Migration Deprecation, will be removed in 9.1! Use item.action with the KeyboardAction variants instead.")
public extension RangeReplaceableCollection where Element == KeyboardLayout.Item, Index == Int {

    func index(
        of item: Element
    ) -> Index? {
        index(of: item.action)
    }

    mutating func insert(
        _ item: Element,
        after target: Element
    ) {
        insert(item, after: target.action)
    }

    mutating func insert(
        _ item: Element,
        before target: Element
    ) {
        insert(item, before: target.rowId)
    }

    mutating func remove(
        _ item: Element
    ) {
        remove(item.rowId)
    }

    /// Replace an item with another item in the collection.
    mutating func replace(
        _ item: Element,
        with replacement: Element
    ) {
        insert(replacement, after: item.action)
        remove(item.action) // This works due to `firstIndex`
    }
}

@available(*, deprecated, message: "Migration Deprecation, will be removed in 9.1! Use item.action with the KeyboardAction variants instead.")
public extension Array where Element: RangeReplaceableCollection,
                             Element.Index == Int,
                             Element.Element == KeyboardLayout.Item {

    /// Insert an item after another item in all rows.
    mutating func insert(
        _ item: Element.Element,
        after target: Element.Element
    ) {
        insert(item, after: target.rowId)
    }

    /// Insert an item after another item in a certain row.
    mutating func insert(
        _ item: Element.Element,
        after target: Element.Element,
        atRow index: Int
    ) {
        insert(item, after: target.rowId, atRow: index)
    }

    /// Insert an item before another item in all rows.
    mutating func insert(
        _ item: Element.Element,
        before target: Element.Element
    ) {
        insert(item, before: target.rowId)
    }

    /// Insert an item before another item in a certain row.
    mutating func insert(
        _ item: Element.Element,
        before target: Element.Element,
        atRow index: Int
    ) {
        insert(item, before: target.rowId, atRow: index)
    }

    /// Remove a certain item in all rows.
    mutating func remove(
        _ item: Element.Element
    ) {
        remove(item.rowId)
    }

    /// Remove a certain item in a certain row.
    mutating func remove(
        _ item: Element.Element,
        atRow index: Int
    ) {
        remove(item.rowId, atRow: index)
    }

    /// Replace an item with another item in all rows.
    mutating func replace(
        _ item: Element.Element,
        with replacement: Element.Element
    ) {
        replace(item.rowId, with: replacement)
    }

    /// Replace an item with another item in a certain row.
    mutating func replace(
        _ item: Element.Element,
        with replacement: Element.Element,
        atRow index: Int
    ) {
        replace(item.rowId, with: replacement, atRow: index)
    }
}

public extension Array where Element: RangeReplaceableCollection,
                             Element.Index == Int,
                             Element.Element == KeyboardLayout.Item {

    @available(*, deprecated, renamed: "insert(_:before:inRow:)", message: "Migration Deprecation, will be removed in 9.1!")
    mutating func insert(
        _ item: Element.Element,
        before target: Element.Element.ID,
        atRow rowIndex: Int
    ) {
        self.insert(item, before: target, inRow: rowIndex)
    }

    @available(*, deprecated, renamed: "insert(_:after:inRow:)", message: "Migration Deprecation, will be removed in 9.1!")
    mutating func insert(
        _ item: Element.Element,
        after target: Element.Element.ID,
        atRow rowIndex: Int
    ) {
        self.insert(item, after: target, inRow: rowIndex)
    }

    @available(*, deprecated, renamed: "remove(_:fromRow:)", message: "Migration Deprecation, will be removed in 9.1!")
    mutating func remove(
        _ action: KeyboardAction,
        atRow rowIndex: Int
    ) {
        self.remove(action, fromRow: rowIndex)
    }

    @available(*, deprecated, renamed: "replace(_:with:inRow:)", message: "Migration Deprecation, will be removed in 9.1!")
    mutating func replace(
        _ action: KeyboardAction,
        with replacement: Element.Element,
        atRow index: Int
    ) {
        guard var row = self.row(at: index) else { return }
        row.replace(action, with: replacement)
        self[index] = row
    }
}
