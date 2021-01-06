//
//  UIScrollView+PageIndexTests.swift
//  KeyboardKitTests
//
//  Created by Daniel Saidi on 2020-05-02.
//  Copyright © 2021 Daniel Saidi. All rights reserved.
//

import Quick
import Nimble
import KeyboardKit
import UIKit

class UIScrollView_PageIndexTests: QuickSpec {
    
    override func spec() {
        
        var scrollView: UIScrollView!
        
        beforeEach {
            scrollView = UIScrollView()
            setOffset(0)
        }
        
        func setOffset(_ x: CGFloat) {
            let offset = CGPoint(x: x, y: 0)
            scrollView.setContentOffset(offset, animated: false)
        }
        
        func setWidth(_ width: CGFloat) {
            let size = CGSize(width: width, height: 0)
            scrollView.frame.size = size
        }
        
        describe("current page index") {
            
            it("handles zero width by returning zero") {
                setWidth(0)
                setOffset(-100)
                expect(scrollView.currentPageIndex).to(equal(0))
            }
            
            it("handles small width by returning zero") {
                setWidth(9)
                setOffset(100)
                expect(scrollView.currentPageIndex).to(equal(0))
            }
            
            it("handles zero offset by returning zero") {
                setWidth(100)
                setOffset(0)
                expect(scrollView.currentPageIndex).to(equal(0))
            }
            
            it("returns correct index for offset within first page") {
                setWidth(255)
                setOffset(57)
                expect(scrollView.currentPageIndex).to(equal(0))
            }
            
            it("returns correct index for offset at second page") {
                setWidth(255)
                setOffset(255)
                expect(scrollView.currentPageIndex).to(equal(1))
            }
            
            it("returns correct index for offset at third page") {
                setWidth(255)
                setOffset(600)
                expect(scrollView.currentPageIndex).to(equal(2))
            }
        }
    }
}
