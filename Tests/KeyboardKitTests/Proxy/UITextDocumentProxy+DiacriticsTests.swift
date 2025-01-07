//
//  UITextDocumentProxy+DiacriticsTests.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2024-04-12.
//  Copyright © 2024-2025 Daniel Saidi. All rights reserved.
//

#if os(iOS) || os(tvOS) || os(visionOS)
import KeyboardKit
import XCTest

class UITextDocumentProxy_DiacriticsTests: XCTestCase {

    var proxy: MockTextDocumentProxy!
    
    let diacritic = Keyboard.Diacritic(
        char: "*",
        replacements: ["r": "r!"]
    )

    override func setUp() {
        proxy = MockTextDocumentProxy()
    }

    
    func testInsertingNonMatchingDiacriticsInsertsCharacter() {
        proxy.documentContextBeforeInput = "foo"
        proxy.insertDiacritic(diacritic)
        
        let delete = proxy.calls(to: \.deleteBackwardRef)
        XCTAssertEqual(delete.count, 0)
        let insert = proxy.calls(to: \.insertTextRef)
        XCTAssertEqual(insert.count, 1)
        XCTAssertEqual(insert[0].arguments, "*")
    }
    
    func testInsertingMatchingDiacriticsReplacesPreviousCharacter() {
        proxy.documentContextBeforeInput = "bar"
        proxy.insertDiacritic(diacritic)
        
        let delete = proxy.calls(to: \.deleteBackwardRef)
        XCTAssertEqual(delete.count, 1)
        let insert = proxy.calls(to: \.insertTextRef)
        XCTAssertEqual(insert.count, 1)
        XCTAssertEqual(insert[0].arguments, "r!")
    }
}
#endif
