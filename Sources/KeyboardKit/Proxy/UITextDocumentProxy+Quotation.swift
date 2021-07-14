//
//  UITextDocumentProxy+Quotation.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2021-03-17.
//  Copyright © 2021 Daniel Saidi. All rights reserved.
//

import Foundation
import UIKit

public extension UITextDocumentProxy {
    
    /**
     Whether or not the input cursor is placed at a position
     where the closest single quotation before the cursor is
     a single quotation delimiter for the provided locale.
     */
    func isOpenAlternateQuotationBeforeInput(for locale: Locale) -> Bool {
        isOpenQuotationBeforeInput(
            beginDelimiter: locale.alternateQuotationBeginDelimiter,
            endDelimiter: locale.alternateQuotationEndDelimiter)
    }
    
    /**
     Whether or not the input cursor is placed at a position
     where the closest double quotation before the cursor is
     a double quotation delimiter for the provided locale.
     */
    func isOpenQuotationBeforeInput(for locale: Locale) -> Bool {
        isOpenQuotationBeforeInput(
            beginDelimiter: locale.quotationBeginDelimiter,
            endDelimiter: locale.quotationEndDelimiter)
    }
}

private extension UITextDocumentProxy {
    
    func isOpenQuotationBeforeInput(beginDelimiter: String?, endDelimiter: String?) -> Bool {
        guard
            let beginDelimiter = beginDelimiter,
            let endDelimiter = endDelimiter,
            let text = documentContextBeforeInput?.reversed().toString(),
            let beginIndex = (text.firstIndex { String($0) == beginDelimiter })
        else { return false }
        guard
            let endIndex = (text.firstIndex { String($0) == endDelimiter }) else { return true }
        return beginIndex < endIndex
    }
}

private extension Array where Element == Character {
    
    func toString() -> String { String(self) }
}
