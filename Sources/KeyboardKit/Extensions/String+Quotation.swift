//
//  String+Quotation.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2021-03-17.
//  Copyright © 2021-2024 Daniel Saidi. All rights reserved.
//

import Foundation

public extension String {

    /// Check if the string contains any unclosed quotations.
    func hasUnclosedAlternateQuotation(for locale: Locale) -> Bool {
        guard let begin = locale.alternateQuotationBeginDelimiter else { return false}
        guard let end = locale.alternateQuotationEndDelimiter else { return false}
        return hasUnclosedQuotation(beginDelimiter: begin, endDelimiter: end)
    }

    /// Check if the string contains any unclosed quotations.
    func hasUnclosedQuotation(for locale: Locale) -> Bool {
        guard let begin = locale.quotationBeginDelimiter else { return false}
        guard let end = locale.quotationEndDelimiter else { return false}
        return hasUnclosedQuotation(beginDelimiter: begin, endDelimiter: end)
    }

    /// Check if the string contains any unclosed quotations.
    func hasUnclosedQuotation(
        beginDelimiter begin: String,
        endDelimiter end: String
    ) -> Bool {
        let string = String(reversed())
        guard let beginIndex = (string.firstIndex { String($0) == begin }) else { return false }
        guard let endIndex = (string.firstIndex { String($0) == end }) else { return true }
        return beginIndex < endIndex
    }

    /// Check if a certain text that is about to be appended
    /// to the string should be replaced with something else.
    func preferredQuotationReplacement(
        whenAppending text: String,
        for locale: Locale
    ) -> String? {
        if let replacement = preferredQuotationReplacement(for: text, locale: locale) { return replacement }
        if let replacement = preferredAlternateQuotationReplacement(for: text, locale: locale) { return replacement }
        return nil
    }

    /// Wrap the string in quotation delimiters.
    func quoted(for locale: Locale) -> String {
        guard let begin = locale.quotationBeginDelimiter else { return self }
        guard let end = locale.quotationEndDelimiter else { return self }
        return "\(begin)\(self)\(end)"
    }

    /// Wrap the string in alternate quotation delimiters.
    func alternateQuoted(for locale: Locale) -> String {
        guard let begin = locale.alternateQuotationBeginDelimiter else { return self }
        guard let end = locale.alternateQuotationEndDelimiter else { return self }
        return "\(begin)\(self)\(end)"
    }
}

private extension String {

    func preferredQuotationReplacement(for text: String, locale: Locale) -> String? {
        guard text == locale.quotationEndDelimiter || (text == "”" && text != locale.alternateQuotationEndDelimiter)  else { return nil }
        let isOpen = hasUnclosedQuotation(for: locale)
        let result = isOpen ? locale.quotationEndDelimiter : locale.quotationBeginDelimiter
        return result == text ? nil : result
    }

    func preferredAlternateQuotationReplacement(for text: String, locale: Locale) -> String? {
        guard locale.prefersAlternateQuotationReplacement else { return nil }
        guard text == locale.alternateQuotationEndDelimiter || text == "‘"  else { return nil }
        let isOpen = hasUnclosedAlternateQuotation(for: locale)
        let result = isOpen ? locale.alternateQuotationEndDelimiter : locale.alternateQuotationBeginDelimiter
        return result == text ? nil : result
    }
}
