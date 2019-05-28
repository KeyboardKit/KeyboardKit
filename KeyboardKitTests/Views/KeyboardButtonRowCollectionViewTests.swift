//
//  KeyboardButtonRowCollectionViewTests.swift
//  KeyboardKitTests
//
//  Created by Daniel Saidi on 2019-05-28.
//  Copyright © 2019 Daniel Saidi. All rights reserved.
//

import Quick
import Nimble
import KeyboardKit
import MockNRoll

class KeyboardButtonRowCollectionViewTests: QuickSpec {
    
    override func spec() {
        
        var view: TestClass!
        var actions: [KeyboardAction]!
        var config: KeyboardButtonRowCollectionView.Configuration!
        var layout: KeyboardButtonRowCollectionView.Layout!
        
        beforeEach {
            actions = [.capsLock, .moveCursorBackward, .backspace, .dismissKeyboard, .newLine]
            config = KeyboardButtonRowCollectionView.Configuration(rowHeight: 123, rowsPerPage: 2, buttonsPerRow: 2)
            view = TestClass(actions: actions, configuration: config) { action in
                let button = TestButton(type: .custom)
                button.action = action
                return button
            }
            layout = view.collectionViewLayout as? KeyboardButtonRowCollectionView.Layout
        }
        
        describe("created instance") {
            
            it("is correctly configured with default parameters") {
                expect(view.id).to(equal("KeyboardButtonRowCollectionView"))
                expect(view.delegate).to(be(view))
                expect(view.isPagingEnabled).to(beTrue())
                expect(view.height).to(equal(config.totalHeight))
                expect(layout.rowHeight).to(equal(123))
                expect(layout.minimumInteritemSpacing).to(equal(0))
                expect(layout.minimumLineSpacing).to(equal(0))
                expect(layout.scrollDirection).to(equal(.horizontal))
            }
            
            it("can have custom id") {
                view = TestClass(id: "test", actions: [], configuration: config) { _ in TestButton(type: .custom) }
                expect(view.id).to(equal("test"))
            }
        }
        
        describe("laying out subviews") {
            
            it("restores current page index") {
                view = TestClass(id: "test", actions: [], configuration: config) { _ in TestButton(type: .custom) }
                view.layoutSubviews()
                let exec = view.recorder.executions(of: view.restoreCurrentPage)
                expect(exec.count).to(equal(1))
            }
        }
        
        describe("configuration") {
            
            it("has correct total height") {
                let expected = config.rowHeight * CGFloat(config.rowsPerPage)
                expect(config.totalHeight).to(equal(expected))
            }
            
            it("has correct empty values") {
                let config = KeyboardButtonRowCollectionView.Configuration.empty
                expect(config.rowHeight).to(equal(0))
                expect(config.rowsPerPage).to(equal(0))
                expect(config.buttonsPerRow).to(equal(0))
            }
        }
        
        describe("can persist page index") {
            
            it("is only true when not dragging") {
                expect(view.canPersistPageIndex).toNot(equal(view.isDragging))
            }
        }
        
        describe("can restore page index") {
            
            it("is only true when not dragging") {
                expect(view.canRestorePageIndex).toNot(equal(view.isDragging))
            }
        }
        
        describe("number of pages") {
            
            it("is correct depending on the number of rows and rows per page") {
                expect(view.numberOfPages).to(equal(2))
            }
        }
        
        describe("data source") {
            
            it("returns correct row at index path") {
                let row1 = view.row(at: IndexPath(row: 0, section: 0))
                let row2 = view.row(at: IndexPath(row: 1, section: 0))
                let row3 = view.row(at: IndexPath(row: 2, section: 0))
                let row4 = view.row(at: IndexPath(row: 3, section: 0))
                expect(row1).to(equal([.capsLock, .moveCursorBackward]))
                expect(row2).to(equal([.backspace, .dismissKeyboard]))
                expect(row3).to(equal([.newLine, .none]))
                expect(row4).to(equal([.none, .none]))
            }
            
            it("returns the same number of items as page adjusted rows") {
                let items = view.numberOfItems(inSection: 0)
                expect(items).to(equal(4))
            }
            
            it("returns correct cell at index path") {
                let cell = view.collectionView(view, cellForItemAt: IndexPath(row: 0, section: 0))
                let subview = cell.subviews[0] as? KeyboardButtonRow
                expect(subview?.height).to(equal(123))
                expect(subview?.heightConstraint?.constant).to(equal(123))
            }
            
            it("returns correct row view at index path") {
                let row = view.collectionView(view, rowViewForItemAt: IndexPath(row: 0, section: 0))
                let actions = row.buttonStackView.arrangedSubviews.compactMap { $0 as? TestButton }.map { $0.action }
                expect(row.height).to(equal(123))
                expect(row.heightConstraint?.constant).to(equal(123))
                expect(actions).to(equal([.capsLock, .moveCursorBackward]))
            }
        }
    }
}

private class TestClass: KeyboardButtonRowCollectionView {
    
    var recorder = Mock()
    
    override func layoutSubviews() {
        frame = CGRect(x: 0, y: 0, width: 100, height: 100)
        super.layoutSubviews()
    }
    
    override func restoreCurrentPage() {
        recorder.invoke(restoreCurrentPage, args: ())
    }
}

private class TestButton: UIButton {
    
    var action: KeyboardAction?
}
