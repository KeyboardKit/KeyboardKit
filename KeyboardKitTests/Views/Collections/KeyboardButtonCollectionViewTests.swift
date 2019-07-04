//
//  KeyboardButtonCollectionViewTests.swift
//  KeyboardKitTests
//
//  Created by Daniel Saidi on 2019-05-28.
//  Copyright © 2019 Daniel Saidi. All rights reserved.
//

import Quick
import Nimble
import KeyboardKit
import MockNRoll

class KeyboardButtonCollectionViewTests: QuickSpec {
    
    override func spec() {
        
        var view: TestClass!
        var actions: [KeyboardAction]!
        
        beforeEach {
            actions = [.backspace, .newLine]
            view = TestClass(actions: actions) { action in
                let button = TestButton(type: .custom)
                button.action = action
                return button
            }
        }
        
        describe("action at indexpath") {
            
            it("is correct") {
                let action1 = view.action(at: IndexPath(row: 0, section: 0))
                let action2 = view.action(at: IndexPath(row: 1, section: 0))
                expect(action1).to(equal(.backspace))
                expect(action2).to(equal(.newLine))
            }
        }
        
        describe("data source") {
            
            it("returns cell with correcty configured buttob") {
                let result = view.collectionView(view, cellForItemAt: IndexPath(row: 0, section: 0))
                let button = result.subviews[0] as? TestButton
                expect(button?.action).to(equal(.backspace))
            }
        }
    }
}

private class TestClass: KeyboardButtonCollectionView {
    
    var recorder = Mock()
}

private class TestButton: UIButton {
    
    var action: KeyboardAction?
}
