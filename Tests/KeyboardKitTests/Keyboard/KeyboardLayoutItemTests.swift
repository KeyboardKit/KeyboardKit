//
//  KeyboardLayoutItemTests.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2021-02-08.
//  Copyright © 2021 Daniel Saidi. All rights reserved.
//

import SwiftUI
import XCTest

@testable import KeyboardKit

class KeyboardLayoutItemRowTests: XCTestCase {
    
    var item: KeyboardLayoutItem!
    var row: KeyboardLayoutItemRow!
    var rows: KeyboardLayoutItemRows!

    let size = KeyboardLayoutItemSize(width: .available, height: 100)
    let insets = EdgeInsets()

    override func setUp() {
        item = KeyboardLayoutItem(action: .primary(.done), size: size, insets: insets)
        let item1 = KeyboardLayoutItem(action: .command, size: size, insets: insets)
        let item2 = KeyboardLayoutItem(action: .space, size: size, insets: insets)
        let item3 = KeyboardLayoutItem(action: .backspace, size: size, insets: insets)
        row = [item1, item2, item3]
        rows = [row, row, row]
    }

    var rowActions: KeyboardActions {
        row.map { $0.action }
    }

    var rowsActions: KeyboardActionRows {
        rows.map { $0.map { $0.action } }
    }


    func testInsertItemAfterActionInRowAbortsIfItemIsNotFound() {
        row.insert(item, after: .escape)
        XCTAssertEqual(rowActions, [.command, .space, .backspace])
    }

    func testInsertItemAfterActionInRowCanInsertItemAfterFirstItem() {
        row.insert(item, after: .command)
        XCTAssertEqual(rowActions, [.command, .primary(.done), .space, .backspace])
    }

    func testInsertItemAfterActionInRowCanInsertItemAfterLastItem() {
        row.insert(item, after: .backspace)
        XCTAssertEqual(rowActions, [.command, .space, .backspace, .primary(.done)])
    }


    func testInsertItemBeforeActionInRowAbortsIfItemIsNotFound() {
        row.insert(item, before: .escape)
        XCTAssertEqual(rowActions, [.command, .space, .backspace])
    }

    func testInsertItemBeforeActionInRowCanInsertItemBeforeFirstItem() {
        row.insert(item, before: .command)
        XCTAssertEqual(rowActions, [.primary(.done), .command, .space, .backspace])
    }

    func testInsertItemBeforeActionInRowAbortsIfCanInsertItemBeforeLastItem() {
        row.insert(item, before: .backspace)
        XCTAssertEqual(rowActions, [.command, .space, .primary(.done), .backspace])
    }


    func removingActionFromRowAbortsIfActionIsNotFound() {
        row.remove(.character("a"))
        XCTAssertEqual(rowActions, [.command, .space, .backspace])
    }

    func removingActionFromRowRemovesMatchingItem() {
        let item = KeyboardLayoutItem(action: .backspace, size: size, insets: insets)
        row.insert(item, before: .command)
        XCTAssertEqual(rowActions, [.backspace, .command, .space, .backspace])
        row.remove(.backspace)
        XCTAssertEqual(rowActions, [.command, .space])
    }


    func testInsertingItemAfterActionInAllRowsDoesNothingIfActionDoesNotExist() {
        rows.insert(item, after: .escape)
        XCTAssertEqual(rowsActions[0], rowActions)
        XCTAssertEqual(rowsActions[1], rowActions)
        XCTAssertEqual(rowsActions[2], rowActions)
    }

    func testInsertingItemAfterActionInAllRowsInsertsItemIfActionExists() {
        rows.insert(item, after: .command)
        XCTAssertEqual(rowsActions[0], [.command, .primary(.done), .space, .backspace])
        XCTAssertEqual(rowsActions[1], [.command, .primary(.done), .space, .backspace])
        XCTAssertEqual(rowsActions[2], [.command, .primary(.done), .space, .backspace])
    }


    func testInsertingItemAfterActionAtCertainRowDoesNothingIfRowDoesNotExist() {
        rows.insert(item, after: .escape, atRow: -1)
        rows.insert(item, after: .escape, atRow: 3)
        XCTAssertEqual(rowsActions, [rowActions, rowActions, rowActions])
    }

    func testInsertingItemAfterActionAtCertainRowCanInsertItemAfterFirstItemInFirstRow() {
        rows.insert(item, after: .command, atRow: 0)
        XCTAssertEqual(rowsActions[0], [.command, .primary(.done), .space, .backspace])
        XCTAssertEqual(rowsActions[1], rowActions)
        XCTAssertEqual(rowsActions[2], rowActions)
    }

    func testInsertingItemAfterActionAtCertainRowCanInsertItemAfterFirstItemInLastRow() {
        rows.insert(item, after: .backspace, atRow: 2)
        XCTAssertEqual(rowsActions[0], rowActions)
        XCTAssertEqual(rowsActions[1], rowActions)
        XCTAssertEqual(rowsActions[2], [.command, .space, .backspace, .primary(.done)])
    }


    func testInsertingItemBeforeActionInAllRowsDoesNothingIfActionDoesNotExist() {
        rows.insert(item, before: .escape)
        XCTAssertEqual(rowsActions[0], rowActions)
        XCTAssertEqual(rowsActions[1], rowActions)
        XCTAssertEqual(rowsActions[2], rowActions)
    }

    func testInsertingItemBeforeActionInAllRowsInsertsItemIfActionExists() {
        rows.insert(item, before: .command)
        XCTAssertEqual(rowsActions[0], [.primary(.done), .command, .space, .backspace])
        XCTAssertEqual(rowsActions[1], [.primary(.done), .command, .space, .backspace])
        XCTAssertEqual(rowsActions[2], [.primary(.done), .command, .space, .backspace])
    }


    func testInsertingItemBeforeActionAtCertainRowDoesNothingIfRowDoesNotExist() {
        rows.insert(item, before: .escape, atRow: -1)
        rows.insert(item, before: .escape, atRow: 3)
        XCTAssertEqual(rowsActions, [rowActions, rowActions, rowActions])
    }

    func testInsertingItemBeforeActionAtCertainRowCanInsertItemAfterFirstItemInFirstRow() {
        rows.insert(item, before: .command, atRow: 0)
        XCTAssertEqual(rowsActions[0], [.primary(.done), .command, .space, .backspace])
        XCTAssertEqual(rowsActions[1], rowActions)
        XCTAssertEqual(rowsActions[2], rowActions)
    }

    func testInsertingItemBeforeActionAtCertainRowCanInsertItemAfterFirstItemInLastRow() {
        rows.insert(item, before: .backspace, atRow: 2)
        XCTAssertEqual(rowsActions[0], rowActions)
        XCTAssertEqual(rowsActions[1], rowActions)
        XCTAssertEqual(rowsActions[2], [.command, .space, .primary(.done), .backspace])
    }


    func testRemovingItemFromAllRowsDoesNothingIfActionDoesNotExist() {
        rows.remove(.escape)
        XCTAssertEqual(rowsActions[0], rowActions)
        XCTAssertEqual(rowsActions[1], rowActions)
        XCTAssertEqual(rowsActions[2], rowActions)
    }

    func testRemovingItemFromAllRowsRemovesItemIfItExists() {
        rows.remove(.command)
        XCTAssertEqual(rowsActions[0], [.space, .backspace])
        XCTAssertEqual(rowsActions[1], [.space, .backspace])
        XCTAssertEqual(rowsActions[2], [.space, .backspace])
    }


    func testRemovingItemFromCertainRowDoesNothingIfActionDoesNotExist() {
        rows.remove(.character("a"), atRow: 2)
        XCTAssertEqual(rowActions, [.command, .space, .backspace])
    }

    func testRemovingItemFromCertainRowRemovesItemIfItExists() {
        let item = KeyboardLayoutItem(action: .backspace, size: size, insets: insets)
        rows.insert(item, before: .command, atRow: 2)
        XCTAssertEqual(rowsActions[2], [.backspace, .command, .space, .backspace])
        rows.remove(.backspace, atRow: 2)
        XCTAssertEqual(rowsActions[2], [.command, .space])
    }
}
