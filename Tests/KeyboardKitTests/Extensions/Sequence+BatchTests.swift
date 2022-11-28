//
//  Sequence+BatchTests.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2017-05-10.
//  Copyright © 2021 Daniel Saidi. All rights reserved.
//

import KeyboardKit
import XCTest

class Sequence_BatchTests: XCTestCase {

    func testBatchingArrayCreatesSingleBatchIfBatchSizeExceedsArraySize() {
        let array = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]
        let batch = array.batched(into: 20)

        XCTAssertEqual(batch.count, 1)
        XCTAssertEqual(batch[0], array)
    }

    func testBatchingArrayCreatesMultipleBatchesIfArraySizeExceedsBatchSize() {
        let array = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]
        let batch = array.batched(into: 3)

        XCTAssertEqual(batch.count, (4))
        XCTAssertEqual(batch[0], [1, 2, 3])
        XCTAssertEqual(batch[1], [4, 5, 6])
        XCTAssertEqual(batch[2], [7, 8, 9])
        XCTAssertEqual(batch[3], [10])
    }

    func testBatchingArrayPreservesItemIdentity() {
        let item1 = TestSequenceItem("1")
        let item2 = TestSequenceItem("2")
        let item3 = TestSequenceItem("3")
        let item4 = TestSequenceItem("4")

        let array = [item1, item2, item3, item4]
        let batch = array.batched(into: 2)

        XCTAssertEqual(batch.count, 2)
        XCTAssertEqual(batch.last!, [item3, item4])
    }
}

private class TestSequenceItem: NSObject {

    init(_ name: String) {
        self.name = name
        super.init()
    }

    let name: String
}
