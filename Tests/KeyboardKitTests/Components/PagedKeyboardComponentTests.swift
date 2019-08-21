//
//  PagedKeyboardComponentTests.swift
//  KeyboardKitTests
//
//  Created by Daniel Saidi on 2019-05-28.
//  Copyright © 2019 Daniel Saidi. All rights reserved.
//

import Quick
import Nimble
@testable import KeyboardKit
import UIKit

class PagedKeyboardComponentTests: QuickSpec {
    
    override func spec() {
        
        var view: TestClass!
        var settingsKey: String!
        var defaults: UserDefaults!
        
        beforeEach {
            view = TestClass()
            settingsKey = view.settingsKey
            defaults = UserDefaults.standard
            defaults.removeObject(forKey: settingsKey)
        }
        
        describe("persisting current page index") {
            
            it("doesn't save to user defaults if component can't persist") {
                view.currentPageIndex = 123
                view.persistCurrentPageIndex()
                let persisted = defaults.integer(forKey: settingsKey)
                expect(persisted).to(equal(0))
            }
            
            it("saves to user defaults if component can persist") {
                view.canPersistPageIndex = true
                view.currentPageIndex = 123
                view.persistCurrentPageIndex()
                let persisted = defaults.integer(forKey: settingsKey)
                expect(persisted).to(equal(123))
            }
        }
        
        describe("restoring current page index") {
            
            it("doesn't restore from user defaults if component can't restore") {
                defaults.set(123, forKey: settingsKey)
                view.restoreCurrentPageIndex()
                expect(view.currentPageIndex).to(equal(0))
            }
            
            it("doesn't restore from user defaults if persisted value is greater than number of pages") {
                defaults.set(3, forKey: settingsKey)
                view.canRestorePageIndex = true
                view.restoreCurrentPageIndex()
                expect(view.currentPageIndex).to(equal(0))
            }
            
            it("restores to index if persisted value is less than number of pages") {
                defaults.set(1, forKey: settingsKey)
                view.canRestorePageIndex = true
                view.restoreCurrentPageIndex()
                expect(view.currentPageIndex).to(equal(1))
            }
        }
    }
}


private class TestClass: UIView, PagedKeyboardComponent {
    
    var id: String { return "test" }
    var canPersistPageIndex = false
    var canRestorePageIndex = false
    var currentPageIndex = 0
    var numberOfPages = 3
}
