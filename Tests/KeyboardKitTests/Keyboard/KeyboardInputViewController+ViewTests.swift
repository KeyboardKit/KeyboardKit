//
//  KeyboardInputViewController+ViewTests.swift
//  KeyboardKitTests
//
//  Created by Daniel Saidi on 2020-06-15.
//  Copyright © 2020 Daniel Saidi. All rights reserved.
//

import Quick
import Nimble
import KeyboardKit
import SwiftUI
import UIKit

class KeyboardInputViewController_ViewTests: QuickSpec {
    
    override func spec() {
        
        var vc: KeyboardInputViewController!
        
        beforeEach {
            vc = KeyboardInputViewController()
        }
        
        describe("setting up for swift ui") {
            
            it("removes all other view controllers") {
                let subview = UIView()
                expect(vc.view.subviews.contains(subview)).to(beFalse())
                vc.view.addSubview(subview)
                expect(vc.view.subviews.contains(subview)).to(beTrue())
                vc.setup(with: Text("Hello"))
                expect(vc.view.subviews.contains(subview)).to(beFalse())
            }
            
            it("adds child controller with environment data") {
                expect(vc.children.count).to(equal(0))
                vc.setup(with: Text("Hello"))
                expect(vc.children.count).to(equal(1))
                expect(vc.children[0] is KeyboardHostingController<Text>).to(beFalse())
            }
        }
    }
}
