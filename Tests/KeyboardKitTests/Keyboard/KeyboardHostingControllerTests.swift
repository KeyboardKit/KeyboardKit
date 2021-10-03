//
//  KeyboardHostingControllerTests.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2020-06-15.
//  Copyright © 2021 Daniel Saidi. All rights reserved.
//

import Quick
import Nimble
import KeyboardKit
import SwiftUI

class KeyboardHostingControllerTests: QuickSpec {
    
    override func spec() {
        
        var host: KeyboardHostingController<Text>!
        var input: KeyboardInputViewController!
        
        beforeEach {
            host = KeyboardHostingController(rootView: Text(""))
            input = KeyboardInputViewController()
        }
        
        describe("adding to keyboard controller") {
            
            beforeEach {
                expect(input.children.count).to(equal(0))
                host.add(to: input)
            }
            
            it("adds host as child controller") {
                expect(input.children.count).to(equal(1))
            }
            
            it("adds host view as subview") {
                expect(input.view.subviews.last).to(be(host.view))
            }
            
            it("configures host view") {
                let view = host.view!
                expect(view.backgroundColor).to(equal(.clear))
                expect(view.translatesAutoresizingMaskIntoConstraints).to(beFalse())
                expect(view.leadingAnchor).toNot(beNil())
                expect(view.trailingAnchor).toNot(beNil())
                expect(view.topAnchor).toNot(beNil())
                expect(view.bottomAnchor).toNot(beNil())
            }
        }
    }
}
