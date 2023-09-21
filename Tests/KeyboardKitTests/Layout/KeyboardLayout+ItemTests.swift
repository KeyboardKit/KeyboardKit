//
//  KeyboardLayout+ItemTests.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2021-02-08.
//  Copyright © 2021-2023 Daniel Saidi. All rights reserved.
//

import SwiftUI
import XCTest

@testable import KeyboardKit

class KeyboardLayout_ItemRowTests: XCTestCase {
    
    var item: KeyboardLayout.Item!
    var row: KeyboardLayout.ItemRow!
    var rows: KeyboardLayout.ItemRows!

    let size = KeyboardLayout.ItemSize(width: .available, height: 100)

    override func setUp() {
        item = KeyboardLayout.Item(action: .primary(.done), size: size)
        let item1 = KeyboardLayout.Item(action: .command, size: size)
        let item2 = KeyboardLayout.Item(action: .space, size: size)
        let item3 = KeyboardLayout.Item(action: .backspace, size: size)
        row = [item1, item2, item3]
        rows = [row, row, row]
    }

    var rowActions: KeyboardAction.Row {
        row.map { $0.action }
    }

    var rowsActions: KeyboardAction.Rows {
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
        let item = KeyboardLayout.Item(action: .backspace, size: size)
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
        let item = KeyboardLayout.Item(action: .backspace, size: size)
        rows.insert(item, before: .command, atRow: 2)
        XCTAssertEqual(rowsActions[2], [.backspace, .command, .space, .backspace])
        rows.remove(.backspace, atRow: 2)
        XCTAssertEqual(rowsActions[2], [.command, .space])
    }
}
