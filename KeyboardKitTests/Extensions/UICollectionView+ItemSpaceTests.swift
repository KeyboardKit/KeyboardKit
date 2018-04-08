//
//  UICollectionView+ItemSpaceTests.swift
//  KeyboardKitTests
//
//  Created by Daniel Saidi on 2018-04-08.
//  Copyright © 2018 Daniel Saidi. All rights reserved.
//

import Quick
import Nimble
import KeyboardKit

class UICollectionView_ItemSpaceTests: QuickSpec {
    
    override func spec() {
        
        var view: UICollectionView!
        
        describe("available item space") {
            
            beforeEach {
                let size = CGSize(width: 500, height: 500)
                let frame = CGRect(origin: .zero, size: size)
                let layout = UICollectionViewFlowLayout()
                view = UICollectionView(frame: frame, collectionViewLayout: layout)
            }
            
            context("for bounds") {
                
                it("removes top inset") {
                    view.contentInset.top = 10
                    let space = view.availableItemSpace
                    expect(space.width).to(equal(500))
                    expect(space.height).to(equal(490))
                }
                
                it("removes bottom inset") {
                    view.contentInset.top = 20
                    let space = view.availableItemSpace
                    expect(space.width).to(equal(500))
                    expect(space.height).to(equal(480))
                }
                
                it("removes left inset") {
                    view.contentInset.left = 30
                    let space = view.availableItemSpace
                    expect(space.width).to(equal(470))
                    expect(space.height).to(equal(500))
                }
                
                it("removes right inset") {
                    view.contentInset.right = 40
                    let space = view.availableItemSpace
                    expect(space.width).to(equal(460))
                    expect(space.height).to(equal(500))
                }
                
                it("removes all insets") {
                    view.contentInset.top = 10
                    view.contentInset.bottom = 20
                    view.contentInset.left = 30
                    view.contentInset.right = 40
                    let space = view.availableItemSpace
                    expect(space.width).to(equal(430))
                    expect(space.height).to(equal(470))
                }
            }
            
            context("for custom size") {
                
                it("removes top inset") {
                    view.contentInset.top = 10
                    let size = CGSize(width: 400, height: 400)
                    let space = view.availableItemSpace(for: size)
                    expect(space.width).to(equal(400))
                    expect(space.height).to(equal(390))
                }
                
                it("removes bottom inset") {
                    view.contentInset.top = 20
                    let size = CGSize(width: 400, height: 400)
                    let space = view.availableItemSpace(for: size)
                    expect(space.width).to(equal(400))
                    expect(space.height).to(equal(380))
                }
                
                it("removes left inset") {
                    view.contentInset.left = 30
                    let size = CGSize(width: 400, height: 400)
                    let space = view.availableItemSpace(for: size)
                    expect(space.width).to(equal(370))
                    expect(space.height).to(equal(400))
                }
                
                it("removes right inset") {
                    view.contentInset.right = 40
                    let size = CGSize(width: 400, height: 400)
                    let space = view.availableItemSpace(for: size)
                    expect(space.width).to(equal(360))
                    expect(space.height).to(equal(400))
                }
                
                it("removes all insets") {
                    view.contentInset.top = 10
                    view.contentInset.bottom = 20
                    view.contentInset.left = 30
                    view.contentInset.right = 40
                    let size = CGSize(width: 400, height: 400)
                    let space = view.availableItemSpace(for: size)
                    expect(space.width).to(equal(330))
                    expect(space.height).to(equal(370))
                }
            }
        }
    }
}
