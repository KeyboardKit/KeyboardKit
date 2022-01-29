//
//  UITextDocumentProxy+QuotationTests.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2021-03-17.
//  Copyright © 2021 Daniel Saidi. All rights reserved.
//

#if os(iOS) || os(tvOS)
import Quick
import Nimble
import KeyboardKit
import MockingKit

class UITextDocumentProxy_QuotationTests: QuickSpec {
    
    override func spec() {
        
        var proxy: MockTextDocumentProxy!
        
        beforeEach {
            proxy = MockTextDocumentProxy()
        }
        
        describe("is open alternate quotation before input") {
            
            func result(for text: String?, locale: KeyboardLocale) -> Bool {
                proxy.documentContextBeforeInput = text
                return proxy.isOpenAlternateQuotationBeforeInput(for: locale.locale)
            }
            
            it("is false if no text exists before cursor") {
                KeyboardLocale.allCases.forEach {
                    expect(result(for: nil, locale: $0)).to(beFalse())
                }
            }
            
            it("is false if text before cursor does not contain a begin delimiter") {
                KeyboardLocale.allCases.forEach {
                    let text = "I love coding"
                    expect(result(for: text, locale: $0)).to(beFalse())
                }
            }
            
            it("is false if text before cursor has an end delimiter after a begin delimiter") {
                KeyboardLocale.allCases.forEach {
                    let text = "I love coding\($0.locale.alternateQuotationBeginDelimiter ?? "")\($0.locale.alternateQuotationEndDelimiter ?? "")"
                    expect(result(for: text, locale: $0)).to(beFalse())
                }
            }
            
            it("is true if text before cursor has a begin delimiter after an end delimiter") {
                KeyboardLocale.allCases.forEach {
                    let begin = $0.locale.alternateQuotationBeginDelimiter ?? ""
                    let end = $0.locale.alternateQuotationEndDelimiter ?? ""
                    let text = "I love coding\(end)\(begin)"
                    expect(result(for: text, locale: $0)).to(equal(begin != end))
                }
            }
        }
        
        describe("is open quotation before input") {
            
            func result(for text: String?, locale: KeyboardLocale) -> Bool {
                proxy.documentContextBeforeInput = text
                return proxy.isOpenQuotationBeforeInput(for: locale.locale)
            }
            
            it("is false if no text exists before cursor") {
                KeyboardLocale.allCases.forEach {
                    expect(result(for: nil, locale: $0)).to(beFalse())
                }
            }
            
            it("is false if text before cursor does not contain a begin delimiter") {
                KeyboardLocale.allCases.forEach {
                    let text = "I love coding"
                    expect(result(for: text, locale: $0)).to(beFalse())
                }
            }
            
            it("is false if text before cursor has an end delimiter after a begin delimiter") {
                KeyboardLocale.allCases.forEach {
                    let text = "I love coding\($0.locale.quotationBeginDelimiter ?? "")\($0.locale.quotationEndDelimiter ?? "")"
                    expect(result(for: text, locale: $0)).to(beFalse())
                }
            }
            
            it("is true if text before cursor has a begin delimiter after an end delimiter") {
                KeyboardLocale.allCases.forEach {
                    let begin = $0.locale.quotationBeginDelimiter ?? ""
                    let end = $0.locale.quotationEndDelimiter ?? ""
                    let text = "I love coding\(end)\(begin)"
                    expect(result(for: text, locale: $0)).to(equal(begin != end))
                }
            }
            
            it("honors specific locale scenarios") {
                expect(result(for: "This ‘Is me", locale: .dutch)).to(beTrue())
                expect(result(for: "This «Is me", locale: .italian)).to(beTrue())
                expect(result(for: "This «Is me", locale: .norwegian)).to(beTrue())
            }
        }
    }
}
#endif
