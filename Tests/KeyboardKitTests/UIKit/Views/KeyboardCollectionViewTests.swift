//
//  KeyboardCollectionViewTests.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2019-05-28.
//  Copyright © 2021 Daniel Saidi. All rights reserved.
//

import Quick
import Nimble
import MockingKit
import KeyboardKit
import Foundation

class KeyboardCollectionViewTests: QuickSpec {
    
    override func spec() {
        
        var view: TestClass!
        var actions: [KeyboardAction]!
        var layout: MockCollectionViewLayout!
        
        
        beforeEach {
            actions = [.backspace, .newLine]
            view = TestClass(actions: actions)
            layout = MockCollectionViewLayout()
            view.collectionViewLayout = layout
        }
        
        describe("created instance") {
            
            it("is correctly configured") {
                expect(view.actions).to(equal(actions))
                expect(view.dataSource).to(be(view))
                expect(view.backgroundColor).to(equal(.clear))
            }
        }
        
        describe("cell identifier") {
            
            it("is correctly configured") {
                expect(view.cellIdentifier).to(equal("Cell"))
            }
        }
        
        describe("refreshing") {
            
            beforeEach {
                layout.mock = Mock()
                view.refresh()
            }
            
            it("invalidates layout") {
                let exec = layout.invokations(of: layout.invalidateLayoutRef)
                expect(exec.count).to(equal(1))
            }
            
            it("reloads data") {
                let exec = view.invokations(of: view.reloadDataRef)
                expect(exec.count).to(equal(1))
            }
        }
        
        describe("data source") {
            
            it("has one section") {
                let result = view.numberOfSections(in: view)
                expect(result).to(equal(1))
            }
            
            it("has as many items as actions") {
                let result = view.collectionView(view, numberOfItemsInSection: 1)
                expect(result).to(equal(actions.count))
            }
            
            it("returns empty cell") {
                let result = view.collectionView(view, cellForItemAt: IndexPath(row: 0, section: 0))
                expect(result).toNot(beNil())
            }
        }
    }
}

private class TestClass: KeyboardCollectionView, Mockable {
    
    lazy var reloadDataRef = MockReference(reloadData)
    
    let mock = Mock()
    
    override func reloadData() {
        invoke(reloadDataRef, args: ())
    }
}
