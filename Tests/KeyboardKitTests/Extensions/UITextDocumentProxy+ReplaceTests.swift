//
//  UITextDocumentProxy+ReplaceTests.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2021-03-22.
//  Copyright © 2021 Daniel Saidi. All rights reserved.
//

import Quick
import Nimble
import KeyboardKit
import MockingKit

class UITextDocumentProxy_ReplaceTests: QuickSpec {
    
    override func spec() {
        
        var proxy: MockTextDocumentProxy!
        
        beforeEach {
            proxy = MockTextDocumentProxy()
        }
        
        describe("preferred replacement for text and locale") {
            
            func result(for text: String, locale: KeyboardLocale) -> String? {
                proxy.preferredReplacement(for: text, locale: locale.locale)
            }
            
            describe("when text is non-quotation") {
                
                it("is nil for non-quotation texts") {
                    expect(result(for: "a", locale: .english)).to(beNil())
                }
            }
            
            describe("when proxy has no open quotation before input") {
                
                beforeEach {
                    proxy.documentContextBeforeInput = "before"
                }
                
                it("converts locale-specific end delimiters to begin delimiters") {
                    expect(result(for: "”", locale: .english)).to(equal("“"))
                    expect(result(for: "”", locale: .swedish)).to(beNil())
                    expect(result(for: "»", locale: .norwegian)).to(equal("«"))
                    expect(result(for: "”", locale: .dutch)).to(equal("‘"))
                }
                
                it("converts keyboard-specific end delimiters to begin delimiters") {
                    expect(result(for: "”", locale: .english)).to(equal("“"))
                    expect(result(for: "”", locale: .swedish)).to(beNil())
                    expect(result(for: "”", locale: .norwegian)).to(equal("«"))
                }
                
                it("converts locale-specific alternate end delimiters to begin delimiters") {
                    expect(result(for: "’", locale: .english)).to(equal("‘"))
                    expect(result(for: "’", locale: .swedish)).to(beNil())
                    expect(result(for: "’", locale: .norwegian)).to(equal("‘"))
                }
                
                it("converts keyboard-specific alternate end delimiters to begin delimiters") {
                    expect(result(for: "’", locale: .english)).to(equal("‘"))
                    expect(result(for: "’", locale: .swedish)).to(beNil())
                    expect(result(for: "’", locale: .norwegian)).to(equal("‘"))
                }
            }
            
            describe("when proxy has open quotation before input") {
                
                func result(for text: String, locale: KeyboardLocale) -> String? {
                    proxy.documentContextBeforeInput = locale.locale.quotationBeginDelimiter
                    return proxy.preferredReplacement(for: text, locale: locale.locale)
                }
                
                it("converts keyboard-specific end delimiters to end delimiters") {
                    expect(result(for: "”", locale: .english)).to(beNil())
                    expect(result(for: "”", locale: .swedish)).to(beNil())
                    expect(result(for: "”", locale: .norwegian)).to(equal("»"))
                    expect(result(for: "”", locale: .dutch)).to(equal("’"))
                }
            }
            
            describe("when proxy has open alternate quotation before input") {
                
                func result(for text: String, locale: KeyboardLocale) -> String? {
                    proxy.documentContextBeforeInput = locale.locale.alternateQuotationBeginDelimiter
                    return proxy.preferredReplacement(for: text, locale: locale.locale)
                }
                
                it("converts locale-specific alternate end delimiters to alternate end delimiters") {
                    expect(result(for: "’", locale: .english)).to(beNil())
                    expect(result(for: "’", locale: .swedish)).to(beNil())
                    expect(result(for: "’", locale: .norwegian)).to(beNil())
                }
                
                it("converts keyboard-specific alternate end delimiters to alternate end delimiters") {
                    expect(result(for: "’", locale: .english)).to(beNil())
                    expect(result(for: "’", locale: .swedish)).to(beNil())
                    expect(result(for: "’", locale: .norwegian)).to(beNil())
                }
            }
        }
    }
}
