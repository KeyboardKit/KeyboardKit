//
//  InputSet+ItemRowTests.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2020-07-03.
//  Copyright © 2020-2025 Daniel Saidi. All rights reserved.
//

import KeyboardKit
import XCTest

class InputSet_RowTests: XCTestCase {

    typealias InputSet = KeyboardLayout.InputSet

    func testCanCreateRowWithItemsAndDeviceVariations() {
        let row = InputSet.ItemRow(
            items: "abc".chars.map { InputSet.Item($0) },
            deviceVariations: [
                .pad: "def".chars.map { InputSet.Item($0) },
                .vision: "ghi".chars.map { InputSet.Item($0) }
            ]
        )

        XCTAssertEqual(row.characters(for: .lowercased, device: .phone).joined(), "abc")
        XCTAssertEqual(row.characters(for: .uppercased, device: .mac).joined(), "ABC")
        XCTAssertEqual(row.characters(for: .lowercased, device: .pad).joined(), "def")
        XCTAssertEqual(row.characters(for: .capsLocked, device: .tv).joined(), "ABC")
        XCTAssertEqual(row.characters(for: .lowercased, device: .watch).joined(), "abc")
        XCTAssertEqual(row.characters(for: .uppercased, device: .vision).joined(), "GHI")
    }

    func testCanCreateRowWithStringAndDeviceVariations() {
        let row = InputSet.ItemRow(
            chars: "abc",
            deviceVariations: [.pad: "def", .vision: "ghi"]
        )

        XCTAssertEqual(row.characters(for: .lowercased, device: .phone).joined(), "abc")
        XCTAssertEqual(row.characters(for: .lowercased, device: .mac).joined(), "abc")
        XCTAssertEqual(row.characters(for: .uppercased, device: .pad).joined(), "DEF")
        XCTAssertEqual(row.characters(for: .capsLocked, device: .tv).joined(), "ABC")
        XCTAssertEqual(row.characters(for: .uppercased, device: .watch).joined(), "ABC")
        XCTAssertEqual(row.characters(for: .lowercased, device: .vision).joined(), "ghi")
    }

    func testCanCreateRowWithStringsAndDeviceVariations() {
        let row = InputSet.ItemRow(
            chars: ["a", "kr", "c"],
            deviceVariations: [.pad: ["d", "kr", "f"], .vision: ["g", "kr", "i"]]
        )

        XCTAssertEqual(row.characters(for: .uppercased, device: .phone).joined(), "AKRC")
        XCTAssertEqual(row.characters(for: .lowercased, device: .mac).joined(), "akrc")
        XCTAssertEqual(row.characters(for: .capsLocked, device: .pad).joined(), "DKRF")
        XCTAssertEqual(row.characters(for: .uppercased, device: .tv).joined(), "AKRC")
        XCTAssertEqual(row.characters(for: .lowercased, device: .watch).joined(), "akrc")
        XCTAssertEqual(row.characters(for: .lowercased, device: .vision).joined(), "gkri")
    }

    func testCanCreateRowWithCasedStringsAndDeviceVariations() {
        let row = InputSet.ItemRow(
            lowercased: "abc",
            uppercased: "def",
            deviceVariations: [.pad: (lowercased: "ghi", uppercased: "JKL")]
        )

        XCTAssertEqual(row.characters(for: .lowercased, device: .phone).joined(), "abc")
        XCTAssertEqual(row.characters(for: .uppercased, device: .phone).joined(), "def")
        XCTAssertEqual(row.characters(for: .lowercased, device: .mac).joined(), "abc")
        XCTAssertEqual(row.characters(for: .uppercased, device: .mac).joined(), "def")
        XCTAssertEqual(row.characters(for: .lowercased, device: .pad).joined(), "ghi")
        XCTAssertEqual(row.characters(for: .uppercased, device: .pad).joined(), "JKL")
    }
}
