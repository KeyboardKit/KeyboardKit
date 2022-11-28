//
//  KeyboardLayoutItemTests.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2021-02-08.
//  Copyright © 2021 Daniel Saidi. All rights reserved.
//

import Quick
import Nimble
import SwiftUI
@testable import KeyboardKit

class KeyboardLayoutItemRowTests: QuickSpec {
    
    override func spec() {
        
        var item: KeyboardLayoutItem!
        var row: KeyboardLayoutItemRow!
        var rows: KeyboardLayoutItemRows!
        
        let size = KeyboardLayoutItemSize(width: .available, height: 100)
        let insets = EdgeInsets()
        
        beforeEach {
            item = KeyboardLayoutItem(action: .primary(.done), size: size, insets: insets)
            let item1 = KeyboardLayoutItem(action: .command, size: size, insets: insets)
            let item2 = KeyboardLayoutItem(action: .space, size: size, insets: insets)
            let item3 = KeyboardLayoutItem(action: .backspace, size: size, insets: insets)
            row = [item1, item2, item3]
            rows = [row, row, row]
        }
        
        var rowActions: KeyboardActions {
            row.map { $0.action }
        }
        
        var rowsActions: KeyboardActionRows {
            rows.map { $0.map { $0.action } }
        }
        
        context("row") {
            
            describe("inserting item after action") {
                
                it("aborts if item is not found") {
                    row.insert(item, after: .escape)
                    expect(rowActions).to(equal([.command, .space, .backspace]))
                }
                
                it("can insert item after first item") {
                    row.insert(item, after: .command)
                    expect(rowActions).to(equal([.command, .primary(.done), .space, .backspace]))
                }
                
                it("can insert item after last item") {
                    row.insert(item, after: .backspace)
                    expect(rowActions).to(equal([.command, .space, .backspace, .primary(.done)]))
                }
            }
            
            describe("inserting item before action") {
                
                it("aborts if item is not found") {
                    row.insert(item, before: .escape)
                    expect(rowActions).to(equal([.command, .space, .backspace]))
                }
                
                it("can insert item before first item") {
                    row.insert(item, before: .command)
                    expect(rowActions).to(equal([.primary(.done), .command, .space, .backspace]))
                }
                
                it("can insert item before last item") {
                    row.insert(item, before: .backspace)
                    expect(rowActions).to(equal([.command, .space, .primary(.done), .backspace]))
                }
            }
            
            describe("removing action") {
                
                it("aborts if action is not found") {
                    row.remove(.character("a"))
                    expect(rowActions).to(equal([.command, .space, .backspace]))
                }
                
                it("removes matching item") {
                    let item = KeyboardLayoutItem(action: .backspace, size: size, insets: insets)
                    row.insert(item, before: .command)
                    expect(rowActions).to(equal([.backspace, .command, .space, .backspace]))
                    row.remove(.backspace)
                    expect(rowActions).to(equal([.command, .space]))
                }
            }
        }
        
        context("rows") {
            
            describe("inserting item after action in all rows") {
                
                it("does nothing if action doesn't exists") {
                    rows.insert(item, after: .escape)
                    expect(rowsActions[0]).to(equal(rowActions))
                    expect(rowsActions[1]).to(equal(rowActions))
                    expect(rowsActions[2]).to(equal(rowActions))
                }
                
                it("inserts item if action exists") {
                    rows.insert(item, after: .command)
                    expect(rowsActions[0]).to(equal([.command, .primary(.done), .space, .backspace]))
                    expect(rowsActions[1]).to(equal([.command, .primary(.done), .space, .backspace]))
                    expect(rowsActions[2]).to(equal([.command, .primary(.done), .space, .backspace]))
                }
            }
            
            describe("inserting item after action in row") {
                
                it("aborts if row doesn't exist") {
                    rows.insert(item, after: .escape, atRow: -1)
                    rows.insert(item, after: .escape, atRow: 3)
                    expect(rowsActions).to(equal([rowActions, rowActions, rowActions]))
                }
                
                it("can insert item after item in first row") {
                    rows.insert(item, after: .command, atRow: 0)
                    expect(rowsActions[0]).to(equal([.command, .primary(.done), .space, .backspace]))
                    expect(rowsActions[1]).to(equal(rowActions))
                    expect(rowsActions[2]).to(equal(rowActions))
                }
                
                it("can insert item after item in last row") {
                    rows.insert(item, after: .backspace, atRow: 2)
                    expect(rowsActions[0]).to(equal(rowActions))
                    expect(rowsActions[1]).to(equal(rowActions))
                    expect(rowsActions[2]).to(equal([.command, .space, .backspace, .primary(.done)]))
                }
            }
        
            describe("inserting item before action in all rows") {
                
                it("does nothing if action doesn't exists") {
                    rows.insert(item, before: .escape)
                    expect(rowsActions[0]).to(equal(rowActions))
                    expect(rowsActions[1]).to(equal(rowActions))
                    expect(rowsActions[2]).to(equal(rowActions))
                }
                
                it("inserts item if action exists") {
                    rows.insert(item, before: .command)
                    expect(rowsActions[0]).to(equal([.primary(.done), .command, .space, .backspace]))
                    expect(rowsActions[1]).to(equal([.primary(.done), .command, .space, .backspace]))
                    expect(rowsActions[2]).to(equal([.primary(.done), .command, .space, .backspace]))
                }
            }
            
            describe("inserting item before action in row") {
                
                it("aborts if row doesn't exist") {
                    rows.insert(item, before: .escape, atRow: -1)
                    rows.insert(item, before: .escape, atRow: 3)
                    expect(rowsActions).to(equal([rowActions, rowActions, rowActions]))
                }
                
                it("can insert item before item in first row") {
                    rows.insert(item, before: .command, atRow: 0)
                    expect(rowsActions[0]).to(equal([.primary(.done), .command, .space, .backspace]))
                    expect(rowsActions[1]).to(equal(rowActions))
                    expect(rowsActions[2]).to(equal(rowActions))
                }
                
                it("can insert item before item in last row") {
                    rows.insert(item, before: .backspace, atRow: 2)
                    expect(rowsActions[0]).to(equal(rowActions))
                    expect(rowsActions[1]).to(equal(rowActions))
                    expect(rowsActions[2]).to(equal([.command, .space, .primary(.done), .backspace]))
                }
            }
            
            describe("removing item from all rows") {
                
                it("does nothing if action doesn't exists") {
                    rows.remove(.escape)
                    expect(rowsActions[0]).to(equal(rowActions))
                    expect(rowsActions[1]).to(equal(rowActions))
                    expect(rowsActions[2]).to(equal(rowActions))
                }
                
                it("removes item if it exists") {
                    rows.remove(.command)
                    expect(rowsActions[0]).to(equal([.space, .backspace]))
                    expect(rowsActions[1]).to(equal([.space, .backspace]))
                    expect(rowsActions[2]).to(equal([.space, .backspace]))
                }
            }
            
            describe("removing action from row") {
                
                it("aborts if action is not found") {
                    rows.remove(.character("a"), atRow: 2)
                    expect(rowActions).to(equal([.command, .space, .backspace]))
                }
                
                it("removes matching item") {
                    let item = KeyboardLayoutItem(action: .backspace, size: size, insets: insets)
                    rows.insert(item, before: .command, atRow: 2)
                    expect(rowsActions[2]).to(equal([.backspace, .command, .space, .backspace]))
                    rows.remove(.backspace, atRow: 2)
                    expect(rowsActions[2]).to(equal([.command, .space]))
                }
            }
        }
    }
}
