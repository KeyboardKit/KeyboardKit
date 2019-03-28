//
//  UICollectionView+ItemSizeTests.swift
//  KeyboardKitTests
//
//  Created by Daniel Saidi on 2018-04-08.
//  Copyright © 2018 Daniel Saidi. All rights reserved.
//

import Quick
import Nimble
@testable import KeyboardKit

class UICollectionView_ItemSizeTests: QuickSpec {
    
    override func spec() {
        
        var view: UICollectionView!
        
        describe("item size for grid") {
            
            beforeEach {
                let size = CGSize(width: 500, height: 300)
                let frame = CGRect(origin: .zero, size: size)
                let layout = UICollectionViewFlowLayout()
                view = UICollectionView(frame: frame, collectionViewLayout: layout)
            }
            
            context("with one cell") {
                
                it("uses all available space") {
                    let size = view.itemSizeForGrid(withRows: 1, columns: 1)
                    expect(size.width).to(equal(500))
                    expect(size.height).to(equal(300))
                }
                
                it("removes all content insets") {
                    view.contentInset = UIEdgeInsets(top: 10, left: 20, bottom: 30, right: 40)
                    let size = view.itemSizeForGrid(withRows: 1, columns: 1)
                    expect(size.width).to(equal(440))
                    expect(size.height).to(equal(260))
                }
            }
            
            context("with multiple cells") {
                
                it("distributes all available space") {
                    let size = view.itemSizeForGrid(withRows: 3, columns: 5)
                    expect(size.width).to(equal(100))
                    expect(size.height).to(equal(100))
                }
                
                it("removes all content insets") {
                    view.contentInset = UIEdgeInsets(top: 10, left: 20, bottom: 30, right: 40)
                    let size = view.itemSizeForGrid(withRows: 26, columns: 44)
                    expect(size.width).to(equal(10))
                    expect(size.height).to(equal(10))
                }
            }
            
            context("with custom size") {
                
                it("distributes all available space") {
                    let size = CGSize(width: 1000, height: 600)
                    let itemSize = view.itemSizeForGrid(withSize: size, rows: 3, columns: 5)
                    expect(itemSize.width).to(equal(200))
                    expect(itemSize.height).to(equal(200))
                }
                
                it("removes all content insets") {
                    let size = CGSize(width: 1000, height: 600)
                    view.contentInset = UIEdgeInsets(top: 100, left: 150, bottom: 50, right: 50)
                    let itemSize = view.itemSizeForGrid(withSize: size, rows: 3, columns: 5)
                    expect(itemSize.width).to(equal(160))
                    expect(itemSize.height).to(equal(150))
                }
            }
        }
    }
}
