//
//  KeyboardButtonRowTests.swift
//  KeyboardKitTests
//
//  Created by Daniel Saidi on 2019-05-28.
//  Copyright © 2019 Daniel Saidi. All rights reserved.
//

import Quick
import Nimble
import KeyboardKit
import UIKit

class KeyboardButtonRowTests: QuickSpec {
    
    override func spec() {
        
        var view: KeyboardButtonRow!
        var actions: [KeyboardAction]!
        
        
        beforeEach {
            actions = [.backspace, .control]
            view = KeyboardButtonRow(height: 123, actions: actions) { action in
                let button = TestButton(type: .custom)
                button.action = action
                return button
            }
        }
        
        describe("created instance") {
            
            it("is correctly configured") {
                let stack = view.buttonStackView
                let buttons = stack.arrangedSubviews.compactMap { $0 as? TestButton}
                expect(view.height).to(equal(123))
                expect(view.heightConstraint?.constant).to(equal(123))
                expect(view.subviews.count).to(equal(1))
                expect(view.subviews[0]).to(be(stack))
                expect(stack.alignment).to(equal(.fill))
                expect(stack.distribution).to(equal(.fillEqually))
                expect(stack.axis).to(equal(.horizontal))
                expect(buttons.count).to(equal(2))
                expect(buttons[0].action).to(equal(.backspace))
                expect(buttons[1].action).to(equal(.control))
            }
            
            it("can use custom stack view configuration") {
                view = KeyboardButtonRow(height: 123, actions: actions, alignment: .center, distribution: .equalCentering) { action in
                    let button = TestButton(type: .custom)
                    button.action = action
                    return button
                }
                let stack = view.buttonStackView
                expect(stack.alignment).to(equal(.center))
                expect(stack.distribution).to(equal(.equalCentering))
            }
        }
    }
}

private class TestButton: UIButton {
    
    var action: KeyboardAction?
}
