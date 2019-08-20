//
//  UIStackView+SubviewsTests.swift
//  KeyboardKitTests
//
//  Created by Daniel Saidi on 2019-05-28.
//  Copyright © 2019 Daniel Saidi. All rights reserved.
//

import Quick
import Nimble
import KeyboardKit

class UIStackView_SubviewsTests: QuickSpec {
    
    override func spec() {
        
        var stackView: UIStackView!
        let views = [UIView(), UIView(), UIView()]
        
        beforeEach {
            stackView = UIStackView(frame: .zero)
        }
        
        describe("adding arranged subviews") {
            
            it("adds each subview") {
                stackView.addArrangedSubviews(views)
                let subviews = stackView.arrangedSubviews
                expect(subviews.count).to(equal(3))
                expect(subviews[0]).to(be(views[0]))
                expect(subviews[1]).to(be(views[1]))
                expect(subviews[2]).to(be(views[2]))
                expect(views[0].superview).toNot(beNil())
                expect(views[1].superview).toNot(beNil())
                expect(views[2].superview).toNot(beNil())
            }
        }
        
        describe("removing arranged subviews") {
            
            it("removes matching subviews") {
                stackView.addArrangedSubviews(views)
                stackView.removeArrangedSubviews([views[0], views[2]])
                let subviews = stackView.arrangedSubviews
                expect(subviews.count).to(equal(1))
                expect(subviews[0]).to(be(views[1]))
                expect(views[0].superview).to(beNil())
                expect(views[1].superview).toNot(beNil())
                expect(views[2].superview).to(beNil())
            }
        }
        
        describe("removing all arranged subviews") {
            
            it("removes all arranged subviews") {
                stackView.addArrangedSubviews(views)
                stackView.removeAllArrangedSubviews()
                let subviews = stackView.arrangedSubviews
                expect(subviews.count).to(equal(0))
                expect(views[0].superview).to(beNil())
                expect(views[1].superview).to(beNil())
                expect(views[2].superview).to(beNil())
            }
        }
    }
}
