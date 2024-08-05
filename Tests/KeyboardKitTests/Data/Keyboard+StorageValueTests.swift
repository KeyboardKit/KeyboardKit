//
//  Keyboard+StorageValueTests.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2024-06-02.
//  Copyright © 2024 Daniel Saidi. All rights reserved.
//

import XCTest

@testable import KeyboardKit

final class StorageValueTests: XCTestCase {

    typealias StorageValue = Keyboard.StorageValue

    func testCanEncodeAndDecodeSingleValue() {
        let data = TestData(name: "foo", age: 42)
        let value = StorageValue(data)
        let rawValue = value.rawValue
        let decoded = StorageValue<TestData>(rawValue: rawValue)
        XCTAssertEqual(data.name, decoded?.value.name)
        XCTAssertEqual(data.age, decoded?.value.age)
    }

    func testCanEncodeAndDecodeArray() {
        let data1 = TestData(name: "foo", age: 42)
        let data2 = TestData(name: "bar", age: 24)
        let value = StorageValue([data1, data2])
        let rawValue = value.rawValue
        let decoded = StorageValue<[TestData]>(rawValue: rawValue)
        XCTAssertEqual(data1.name, decoded?.value[0].name)
        XCTAssertEqual(data1.age, decoded?.value[0].age)
        XCTAssertEqual(data2.name, decoded?.value[1].name)
        XCTAssertEqual(data2.age, decoded?.value[1].age)
    }

    func testCanEncodeAndDecodeDictionary() {
        let data1 = TestData(name: "foo", age: 42)
        let data2 = TestData(name: "bar", age: 24)
        let value = StorageValue([
            "foo": data1,
            "bar": data2
        ])
        let rawValue = value.rawValue
        let decoded = StorageValue<[String: TestData]>(rawValue: rawValue)
        XCTAssertEqual(data1.name, decoded?.value["foo"]?.name)
        XCTAssertEqual(data1.age, decoded?.value["foo"]?.age)
        XCTAssertEqual(data2.name, decoded?.value["bar"]?.name)
        XCTAssertEqual(data2.age, decoded?.value["bar"]?.age)
    }
}

private struct TestData: Codable, Identifiable {

    var name: String
    var age: Int

    var id: String { name }
}
