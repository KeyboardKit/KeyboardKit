//
//  QuotationAnalyzer.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2021-03-17.
//  Copyright © 2021-2023 Daniel Saidi. All rights reserved.
//

import Foundation

/**
 This protocol can be implemented by any type that should be
 able to analyze quotation information for strings.

 Implementing the protocol will extend the implementing type
 with functions that use public `String` extensions with the
 same names. While you can use the protocol, the main reason
 for having it is to expose these extensions to DocC.
 */
public protocol QuotationAnalyzer {}

public extension QuotationAnalyzer {

    /**
     Check whether or not the last trailing quotation in the
     string is an alternate quotation begin delimiter.
     */
    func hasUnclosedAlternateQuotation(
        in string: String,
        for locale: Locale
    ) -> Bool {
        string.hasUnclosedAlternateQuotation(for: locale)
    }

    /**
     Check whether or not the last trailing quotation in the
     string is a quotation begin delimiter.
     */
    func hasUnclosedQuotation(
        in string: String,
        for locale: Locale
    ) -> Bool {
        string.hasUnclosedQuotation(for: locale)
    }

    /**
     Whether or not the last trailing quotation character is
     a begin delimiter for the provided locale.
     */
    func hasUnclosedQuotation(
        in string: String,
        beginDelimiter begin: String,
        endDelimiter end: String
    ) -> Bool {
        string.hasUnclosedQuotation(beginDelimiter: begin, endDelimiter: end)
    }

    /**
     Check if a certain text that is about to be appended to
     the string should be replaced with something else.
     */
    func preferredQuotationReplacement(
        for string: String,
        whenAppending text: String,
        for locale: Locale
    ) -> String? {
        string.preferredQuotationReplacement(whenAppending: text, for: locale)
    }


    /**
     Wrap a `string` in quotation delimiters for a `locale`.
     */
    func quote(
        _ string: String,
        for locale: Locale
    ) -> String {
        string.quoted(for: locale)
    }

    /**
     Wrap a `string` in alternate quotation delimiters for a
     `locale`.
     */
    func alternateQuote(
        _ string: String,
        for locale: Locale
    ) -> String {
        string.alternateQuoted(for: locale)
    }
}


// MARK: - String

public extension String {

    /**
     Check whether or not the last trailing quotation in the
     string is an alternate quotation begin delimiter.
     */
    func hasUnclosedAlternateQuotation(for locale: Locale) -> Bool {
        guard let begin = locale.alternateQuotationBeginDelimiter else { return false}
        guard let end = locale.alternateQuotationEndDelimiter else { return false}
        return hasUnclosedQuotation(beginDelimiter: begin, endDelimiter: end)
    }

    /**
     Check whether or not the last trailing quotation in the
     string is a quotation begin delimiter.
     */
    func hasUnclosedQuotation(for locale: Locale) -> Bool {
        guard let begin = locale.quotationBeginDelimiter else { return false}
        guard let end = locale.quotationEndDelimiter else { return false}
        return hasUnclosedQuotation(beginDelimiter: begin, endDelimiter: end)
    }

    /**
     Whether or not the last trailing quotation character is
     a begin delimiter for the provided locale.
     */
    func hasUnclosedQuotation(
        beginDelimiter begin: String,
        endDelimiter end: String
    ) -> Bool {
        let string = String(reversed())
        guard let beginIndex = (string.firstIndex { String($0) == begin }) else { return false }
        guard let endIndex = (string.firstIndex { String($0) == end }) else { return true }
        return beginIndex < endIndex
    }

    /**
     Check if a certain text that is about to be appended to
     the string should be replaced with something else.
     */
    func preferredQuotationReplacement(
        whenAppending text: String,
        for locale: Locale
    ) -> String? {
        if let replacement = preferredQuotationReplacement(for: text, locale: locale) { return replacement }
        if let replacement = preferredAlternateQuotationReplacement(for: text, locale: locale) { return replacement }
        return nil
    }

    /**
     Wrap the string in quotation delimiters for a `locale`.
     */
    func quoted(for locale: Locale) -> String {
        guard let begin = locale.quotationBeginDelimiter else { return self }
        guard let end = locale.quotationEndDelimiter else { return self }
        return "\(begin)\(self)\(end)"
    }

    /**
     Wrap the string in alternate quotation delimiters for a
     `locale`.
     */
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
