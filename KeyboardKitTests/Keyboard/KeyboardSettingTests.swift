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
                    expect(setting.key).to(equal("com.danielsaidi.keyboardKit.settings.currentPageIndex"))
                }
            }
        }
    }
}
