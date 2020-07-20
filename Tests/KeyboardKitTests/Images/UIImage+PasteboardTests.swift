//
//  UIImage+PasteboardTests.swift
//  KeyboardKitTests
//
//  Created by Daniel Saidi on 2019-05-28.
//  Copyright © 2019 Daniel Saidi. All rights reserved.
//

import Quick
import Nimble
import KeyboardKit
import UIKit

class UIImage_PasteboardTests: QuickSpec {
    
    override func spec() {
        
        var pasteboard: MockPasteboard!
        
        beforeEach {
            pasteboard = MockPasteboard()
        }
        
        describe("copying pasteboard") {
            
            it("ignores image without png data") {
                let result = UIImage().copyToPasteboard(pasteboard)
                let invokes = pasteboard.invokations(of: pasteboard.setDataRef)
                expect(result).to(beFalse())
                expect(invokes.count).to(equal(0))
            }
            
            it("sets correctly formatted data") {
                let image = UIImage().resized(to: CGSize(width: 1, height: 1))!
                let result = image.copyToPasteboard(pasteboard)
                let invokes = pasteboard.invokations(of: pasteboard.setDataRef)
                expect(result).to(beTrue())
                expect(invokes.count).to(equal(1))
                expect(invokes[0].arguments.0).toNot(beNil())
                expect(invokes[0].arguments.1).to(equal("public.png"))
            }
        }
    }
}
