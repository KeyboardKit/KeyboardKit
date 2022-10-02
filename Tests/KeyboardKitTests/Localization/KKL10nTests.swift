//
//  KKL10nTests.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2021-03-17.
//  Copyright © 2021 Daniel Saidi. All rights reserved.
//

import Foundation
import Quick
import Nimble
import XCTest
@testable import KeyboardKit

class KKL10nTests: QuickSpec {
    
    override func spec() {

        describe("bundle path for locale") {

            it("is valid for all keyboard locales") {
                KeyboardLocale.allCases.forEach {
                    let bundle = Bundle.keyboardKit
                    let path = bundle.bundlePath(for: $0.locale) ?? ""
                    expect(path).toNot(beNil())
                    expect(FileManager.default.fileExists(atPath: path)).to(beTrue())
                }
            }
        }

        describe("localized name") {

            func result(for locale: KeyboardLocale) -> String {
                KKL10n.localizedName.text(for: locale)
            }

            it("is only specified for a few locales") {
                let expected: [KeyboardLocale] = [.kurdish_sorani_arabic]
                KeyboardLocale.allCases.forEach {
                    let hasText = KKL10n.localizedName.hasText(for: $0)
                    XCTAssertEqual(hasText, expected.contains($0))
                }
            }
        }

        describe("text for locale") {

            it("is not empty for any keyboard locale") {
                KeyboardLocale.allCases.forEach {
                    let text = KKL10n.space.text(for: $0)
                    expect(text.isEmpty).toNot(beTrue())
                }
            }
        }
    }
}
