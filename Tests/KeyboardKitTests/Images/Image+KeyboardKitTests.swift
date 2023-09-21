//
//  Image+KeyboardKitTests.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2020-06-22.
//  Copyright © 2021-2023 Daniel Saidi. All rights reserved.
//

import KeyboardKit
import SwiftUI
import XCTest

class Image_KeyboardKitTests: XCTestCase {

    func result(for image: Image) -> Image {
        image
    }

    func testKeyboardImagesAreDefined() {
        XCTAssertEqual(result(for: .keyboard), Image(systemName: "keyboard"))
        XCTAssertEqual(result(for: .keyboardBackspace), Image(systemName: "delete.left"))
        XCTAssertEqual(result(for: .keyboardBackspaceRtl), Image(systemName: "delete.right"))
        XCTAssertEqual(result(for: .keyboardCommand), Image(systemName: "command"))
        XCTAssertEqual(result(for: .keyboardControl), Image(systemName: "control"))
        XCTAssertEqual(result(for: .keyboardDictation), Image(systemName: "mic"))
        XCTAssertEqual(result(for: .keyboardEmail), Image(systemName: "envelope"))
        XCTAssertEqual(result(for: .keyboardGlobe), Image(systemName: "globe"))
        XCTAssertEqual(result(for: .keyboardImages), Image(systemName: "photo"))
        XCTAssertEqual(result(for: .keyboardDismiss), Image(systemName: "keyboard.chevron.compact.down"))
        XCTAssertEqual(result(for: .keyboardEmojiSymbol), Image(systemName: "face.smiling"))
        XCTAssertEqual(result(for: .keyboardLeft), Image(systemName: "arrow.left"))
        XCTAssertEqual(result(for: .keyboardNewline), Image(systemName: "arrow.turn.down.left"))
        XCTAssertEqual(result(for: .keyboardNewlineRtl), Image(systemName: "arrow.turn.down.right"))
        XCTAssertEqual(result(for: .keyboardOption), Image(systemName: "option"))
        XCTAssertEqual(result(for: .keyboardRedo), Image(systemName: "arrow.uturn.right"))
        XCTAssertEqual(result(for: .keyboardRight), Image(systemName: "arrow.right"))
        XCTAssertEqual(result(for: .keyboardSettings), Image(systemName: "gearshape"))
        XCTAssertEqual(result(for: .keyboardShiftCapslocked), Image(systemName: "capslock.fill"))
        XCTAssertEqual(result(for: .keyboardShiftLowercased), Image(systemName: "shift"))
        XCTAssertEqual(result(for: .keyboardShiftUppercased), Image(systemName: "shift.fill"))
        XCTAssertEqual(result(for: .keyboardTab), Image(systemName: "arrow.right.to.line"))
        XCTAssertEqual(result(for: .keyboardUndo), Image(systemName: "arrow.uturn.left"))
    }
}
