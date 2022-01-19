//
//  UITextDocumentProxy+ReplaceTests.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2021-03-22.
//  Copyright © 2021 Daniel Saidi. All rights reserved.
//

#if os(iOS) || os(macOS) || os(tvOS)
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
            
            func result(for text: String?, locale: KeyboardLocale) -> String? {
                guard let text = text else { return nil }
                return proxy.preferredReplacement(for: text, locale: locale.locale)
            }
            
            func altBegin(for locale: KeyboardLocale) -> String? { locale.locale.alternateQuotationBeginDelimiter }
            
            func altEnd(for locale: KeyboardLocale) -> String? { locale.locale.alternateQuotationEndDelimiter }
            
            func begin(for locale: KeyboardLocale) -> String? { locale.locale.quotationBeginDelimiter }
            
            func end(for locale: KeyboardLocale) -> String? { locale.locale.quotationEndDelimiter }
            
            
            describe("when text is non-quotation") {
                
                it("is nil for non-quotation texts") {
                    expect(result(for: "a", locale: .english)).to(beNil())
                }
            }
            
            describe("when proxy has no open quotation before input") {
                
                beforeEach {
                    proxy.documentContextBeforeInput = "before"
                }
                
                func resultForEndDelimiter(for locale: KeyboardLocale) -> String? {
                    result(for: end(for: locale), locale: locale)
                }
                
                func resultForAltEndDelimiter(for locale: KeyboardLocale) -> String? {
                    result(for: altEnd(for: locale), locale: locale)
                }
                
                it("converts end delimiters to begin delimiters if they differ, else returns nil") {
                    expect(resultForEndDelimiter(for: .danish)).to(equal(begin(for: .danish)))
                    expect(resultForEndDelimiter(for: .dutch)).to(equal(begin(for: .dutch)))
                    expect(resultForEndDelimiter(for: .english)).to(equal(begin(for: .english)))
                    expect(resultForEndDelimiter(for: .finnish)).to(beNil())
                    expect(result(for: "”", locale: .german)).to(equal(begin(for: .german)))
                    expect(resultForEndDelimiter(for: .german)).to(equal(begin(for: .german)))
                    expect(resultForEndDelimiter(for: .norwegian)).to(equal(begin(for: .norwegian)))
                    expect(resultForEndDelimiter(for: .swedish)).to(beNil())
                }
                
                it("converts end delimiters to begin delimiters if they differ, else returns nil") {
                    expect(resultForAltEndDelimiter(for: .danish)).to(equal(altBegin(for: .danish)))
                    expect(resultForAltEndDelimiter(for: .dutch)).to(equal(altBegin(for: .dutch)))
                    expect(resultForAltEndDelimiter(for: .english)).to(equal(altBegin(for: .english)))
                    expect(resultForAltEndDelimiter(for: .finnish)).to(beNil())
                    expect(resultForAltEndDelimiter(for: .german)).to(equal(altBegin(for: .german)))
                    expect(resultForAltEndDelimiter(for: .norwegian)).to(equal(altBegin(for: .norwegian)))
                    expect(resultForAltEndDelimiter(for: .swedish)).to(beNil())
                }
            }
            
            describe("when proxy has open quotation before input") {
                
                func resultForEndDelimiter(for locale: KeyboardLocale) -> String? {
                    proxy.documentContextBeforeInput = locale.locale.quotationBeginDelimiter
                    return result(for: end(for: locale), locale: locale)
                }
                
                func resultForAltEndDelimiter(for locale: KeyboardLocale) -> String? {
                    proxy.documentContextBeforeInput = locale.locale.alternateQuotationBeginDelimiter
                    return result(for: altEnd(for: locale), locale: locale)
                }
                
                it("does not convert end delimiters and returns nil") {
                    expect(resultForEndDelimiter(for: .danish)).to(beNil())
                    expect(resultForEndDelimiter(for: .dutch)).to(beNil())
                    expect(resultForEndDelimiter(for: .english)).to(beNil())
                    expect(resultForEndDelimiter(for: .finnish)).to(beNil())
                    expect(resultForEndDelimiter(for: .norwegian)).to(beNil())
                    expect(resultForEndDelimiter(for: .swedish)).to(beNil())
                }
                
                it("does not convert end delimiters and returns nil") {
                    expect(resultForAltEndDelimiter(for: .danish)).to(beNil())
                    expect(resultForAltEndDelimiter(for: .dutch)).to(beNil())
                    expect(resultForAltEndDelimiter(for: .english)).to(beNil())
                    expect(resultForAltEndDelimiter(for: .finnish)).to(beNil())
                    expect(resultForAltEndDelimiter(for: .norwegian)).to(beNil())
                    expect(resultForAltEndDelimiter(for: .swedish)).to(beNil())
                }
            }
        }
    }
}
#endif
