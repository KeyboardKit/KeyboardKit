//
//  UITextDocumentProxy+Replace.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2021-03-22.
//  Copyright © 2021 Daniel Saidi. All rights reserved.
//

import UIKit

public extension UITextDocumentProxy {
    
    /**
     Check if a certain text that is about to be sent to the
     proxy should be replaced with something else.
     
     This is currently limited to locale-specific quotations.
     */
    func preferredReplacement(for text: String, locale: Locale) -> String? {
        if let replacement = preferredQuotationReplacement(for: text, locale: locale) { return replacement }
        if let replacement = preferredAlternateQuotationReplacement(for: text, locale: locale) { return replacement }
        return nil
    }
}

private extension UITextDocumentProxy {
    
    func isAlternateEndDelimiter(_ text: String, for locale: Locale) -> Bool {
        text == locale.alternateQuotationEndDelimiter || text == "’"
    }
    
    func isEndDelimiter(_ text: String, for locale: Locale) -> Bool {
        text == locale.quotationEndDelimiter || text == "”"
    }
    
    func preferredAlternateQuotationReplacement(for text: String, locale: Locale) -> String? {
        guard isAlternateEndDelimiter(text, for: locale) else { return nil }
        let isOpen = isOpenAlternateQuotationBeforeInput(for: locale)
        let replacement = isOpen ? locale.alternateQuotationEndDelimiter : locale.alternateQuotationBeginDelimiter
        return replacement != text ? replacement : nil
    }
    
    func preferredQuotationReplacement(for text: String, locale: Locale) -> String? {
        guard isEndDelimiter(text, for: locale) else { return nil }
        let isOpen = isOpenQuotationBeforeInput(for: locale)
        let replacement = isOpen ? locale.quotationEndDelimiter : locale.quotationBeginDelimiter
        return replacement != text ? replacement : nil
    }
}
