//
//  KeyboardLayout+BottomTests.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2024-04-11.
//  Copyright © 2024 Daniel Saidi. All rights reserved.
//

import SwiftUI
import XCTest

@testable import KeyboardKit

class KeyboardLayout_BottomTests: XCTestCase {
    
    var layout: KeyboardLayout!
    let size = KeyboardLayout.ItemSize(width: .available, height: 100)

    override func setUp() {
        let item1 = KeyboardLayout.Item(action: .command, size: size)
        let item2 = KeyboardLayout.Item(action: .space, size: size)
        let item3 = KeyboardLayout.Item(action: .backspace, size: size)
        let rows = [
            [item1, item2, item3],
            [item1, item2, item3],
            [item2]
        ]
        layout = .init(itemRows: rows)
    }
    
    
    func testBottomRowReturnsTheEntireRow() {
        XCTAssertEqual(layout.bottomRow?.count, 1)
        layout.itemRows = Array(layout.itemRows.prefix(2))
        XCTAssertEqual(layout.bottomRow?.count, 3)
    }
    
    
    func testBottomRowIndexIsTheLastIndex() {
        XCTAssertEqual(layout.bottomRowIndex, 2)
    }
    
    func testBottomRowIndexIsNegativeForNoRows() {
        layout.itemRows = []
        XCTAssertEqual(layout.bottomRowIndex, -1)
    }
    
    
    func testBottomRowLayoutIncludesBottomRowItem() {
        let layout = layout.bottomRowLayout
        XCTAssertEqual(layout.itemRows.count, 1)
        XCTAssertEqual(layout.itemRows[0].map { $0.action }, [.space])
    }
    
    func testBottomRowLayoutIsEmptyForNoRows() {
        layout.itemRows = []
        let layout = layout.bottomRowLayout
        XCTAssertEqual(layout.itemRows.count, 0)
    }
    
    
    func testBottomRowLayoutSystemItemsFiltersOutSystemItems() {
        XCTAssertEqual(layout.bottomRowSystemItems?.count, 0)
        layout.itemRows = Array(layout.itemRows.prefix(2))
        XCTAssertEqual(layout.bottomRowSystemItems?.count, 2)
    }
    
    
    func testCanInsertBottomRowActionBeforeAnotherAction() {
        let item = KeyboardLayout.Item(action: .command, size: size)
        layout.itemRows.insert(item, before: .space, atRow: 2)
        layout.tryInsertBottomRowAction(.backspace, before: .space)
        let actions = layout.bottomRow?.map { $0.action }
        XCTAssertEqual(actions, [.command, .backspace, .space])
    }
    
    func testCanInsertBottomRowActionAfterAnotherAction() {
        let item = KeyboardLayout.Item(action: .command, size: size)
        layout.itemRows.insert(item, before: .space, atRow: 2)
        layout.tryInsertBottomRowAction(.backspace, after: .space)
        let actions = layout.bottomRow?.map { $0.action }
        XCTAssertEqual(actions, [.command, .space, .backspace])
    }
    
    
    func testCanReplaceBottomRowActionWithAnotherAction() {
        layout.tryReplaceBottomRowAction(.space, with: .backspace)
        let actions = layout.bottomRow?.map { $0.action }
        XCTAssertEqual(actions, [.backspace])
    }
}
