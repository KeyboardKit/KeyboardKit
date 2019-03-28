//
//  KeyboardSettingTests.swift
//  KeyboardKitTests
//
//  Created by Daniel Saidi on 2018-10-04.
//  Copyright © 2018 Daniel Saidi. All rights reserved.
//

import Quick
import Nimble
import KeyboardKit

class KeyboardSettingTests: QuickSpec {
    
    override func spec() {
        
        describe("keyboard setting") {
            
            context("current page index") {
                
                let setting = KeyboardSetting.currentPageIndex
                
                it("has correct key") {
                    let key = setting.key
                    expect(key).to(equal("com.keyboardKit.settings.currentPageIndex"))
                }
                
                it("has correct key for presenter without id") {
                    let presenter = MockKeyboardPresenter()
                    let key = setting.key(for: presenter)
                    expect(key).to(equal("com.keyboardKit.settings.currentPageIndex"))
                }
                
                it("has correct key for presenter with id") {
                    let presenter = MockKeyboardPresenter(id: "foo")
                    let key = setting.key(for: presenter)
                    expect(key).to(equal("com.keyboardKit.settings.currentPageIndex.foo"))
                }
            }
        }
    }
}
