//
//  Locale+FlagTests.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2021-03-17.
//  Copyright © 2021-2023 Daniel Saidi. All rights reserved.
//

import KeyboardKit
import XCTest

@available(iOS 16, macOS 13, tvOS 16, watchOS 9, *)
class Locale_FlagTests: XCTestCase {

    func testFlags() {
        let doPrint = false
        KeyboardLocale.allCases.forEach { locale in
            let isEqual = locale.flag == locale.locale.flag
            if !isEqual && doPrint {
                print("*** \(locale.locale.localizedName): \(locale.flag) vs \(locale.locale.flag ?? "-")")
            }
        }
    }
}
