//
//  UITextDocumentProxy+Replacements.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2021-03-22.
//  Copyright © 2021 Daniel Saidi. All rights reserved.
//

#if os(iOS) || os(tvOS)
import UIKit

public extension UITextDocumentProxy {
    
    /**
     Check if a certain text that is about to be sent to the
     proxy should be replaced with something else.
     */
    func preferredReplacement(for text: String, locale: Locale) -> String? {
        if let replacement = preferredQuotationReplacement(for: text, locale: locale) { return replacement }
        if let replacement = preferredAlternateQuotationReplacement(for: text, locale: locale) { return replacement }
        return nil
    }
}

private extension UITextDocumentProxy {
    
    func preferredAlternateQuotationReplacement(for text: String, locale: Locale) -> String? {
        guard locale.prefersAlternateQuotationReplacement else { return nil }
        guard text == locale.alternateQuotationEndDelimiter || text == "‘"  else { return nil }
        let isOpen = isOpenAlternateQuotationBeforeInput(for: locale)
        let result = isOpen ? locale.alternateQuotationEndDelimiter : locale.alternateQuotationBeginDelimiter
        return result == text ? nil : result
    }
    
    func preferredQuotationReplacement(for text: String, locale: Locale) -> String? {
        guard text == locale.quotationEndDelimiter || (text == "”" && text != locale.alternateQuotationEndDelimiter)  else { return nil }
        let isOpen = isOpenQuotationBeforeInput(for: locale)
        let result = isOpen ? locale.quotationEndDelimiter : locale.quotationBeginDelimiter
        return result == text ? nil : result
    }
}
#endif
