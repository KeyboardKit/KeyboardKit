//
//  UIImage+ResizedTests.swift
//  KeyboardKitTests
//
//  Created by Daniel Saidi on 2019-05-06.
//  Copyright © 2019 Daniel Saidi. All rights reserved.
//

import Quick
import Nimble
import KeyboardKit

class UIImage_ResizedTests: QuickSpec {
    
    override func spec() {
        
        describe("resized to new size") {
            
            it("resizes image correctly") {
                let image = UIImage()
                let resized = image.resized(to: CGSize(width: 100, height: 200))
                expect(resized?.size.width).to(equal(100))
                expect(resized?.size.height).to(equal(200))
            }
        }
        
        describe("resized to new height") {
            
            it("resizes image by preserving aspect ratio") {
                let image = UIImage().resized(to: CGSize(width: 100, height: 200))
                let resized = image!.resized(toHeight: 400)
                expect(resized?.size.width).to(equal(200))
                expect(resized?.size.height).to(equal(400))
            }
        }
        
        describe("resized to new width") {
            
            it("resizes image by preserving aspect ratio") {
                let image = UIImage().resized(to: CGSize(width: 100, height: 200))
                let resized = image!.resized(toWidth: 400)
                expect(resized?.size.width).to(equal(400))
                expect(resized?.size.height).to(equal(800))
            }
        }
    }
}
