//
//  UIImage+ResizedTests.swift
//  KeyboardKitTests
//
//  Created by Daniel Saidi on 2019-05-06.
//  Copyright © 2021 Daniel Saidi. All rights reserved.
//

import Quick
import Nimble
import KeyboardKit
import CoreGraphics
import UIKit

class UIImage_ResizedTests: QuickSpec {
    
    override func spec() {
        
        let image = UIImage()
            .resized(to: CGSize(width: 100, height: 200))
        
        describe("resized to new size") {
            
            it("handles zero image size by returning nil") {
                let resized = UIImage().resized(to: CGSize(width: -10, height: -10))
                expect(resized).to(beNil())
            }
            
            it("handles negative size by returning nil") {
                let resized = image!.resized(to: CGSize(width: -10, height: -10))
                expect(resized).to(beNil())
            }
            
            it("handles zero size by returning nil") {
                let resized = image!.resized(to: CGSize(width: 0, height: 0))
                expect(resized).to(beNil())
            }
            
            it("resizes image correctly for valid size") {
                let resized = UIImage().resized(to: CGSize(width: 100, height: 200))
                expect(resized?.size.width).to(equal(100))
                expect(resized?.size.height).to(equal(200))
            }
        }
        
        describe("resized to new height") {
            
            it("handles negative height by returning nil") {
                let resized = image!.resized(toHeight: -10)
                expect(resized).to(beNil())
            }
            
            it("handles zero image height by returning nil") {
                let resized = UIImage().resized(toHeight: 100)
                expect(resized).to(beNil())
            }
            
            it("handles zero height by returning nil") {
                let resized = image!.resized(toHeight: 0)
                expect(resized).to(beNil())
            }
            
            it("resizes image by preserving aspect ratio") {
                let resized = image!.resized(toHeight: 400)
                expect(resized?.size.width).to(equal(200))
                expect(resized?.size.height).to(equal(400))
            }
        }
        
        describe("resized to new width") {
            
            it("handles negative width by returning nil") {
                let resized = image!.resized(toWidth: -10)
                expect(resized).to(beNil())
            }
            
            it("handles zero image width by returning nil") {
                let resized = UIImage().resized(toWidth: 100)
                expect(resized).to(beNil())
            }
            
            it("handles zero width by returning nil") {
                let resized = image!.resized(toWidth: 0)
                expect(resized).to(beNil())
            }
            
            it("resizes image by preserving aspect ratio") {
                let resized = image!.resized(toWidth: 400)
                expect(resized?.size.width).to(equal(400))
                expect(resized?.size.height).to(equal(800))
            }
        }
    }
}
