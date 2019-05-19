//
//  UIImage+TintedTests.swift
//  KeyboardKitTests
//
//  Created by Daniel Saidi on 2019-05-06.
//  Copyright © 2019 Daniel Saidi. All rights reserved.
//

import Quick
import Nimble
import KeyboardKit

class UIImage_TintedTests: QuickSpec {
    
    override func spec() {
        
        describe("tinting with color and blend mode") {
            
            it("returns tinted image") {
                let image = UIImage().resized(to: CGSize(width: 100, height: 100))!
                let tinted = image.tinted(with: .red, blendMode: .clear)
                expect(tinted).toNot(beNil())
            }
        }
    }
}
