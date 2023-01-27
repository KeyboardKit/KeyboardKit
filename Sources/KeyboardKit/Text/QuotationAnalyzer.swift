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
 able to analyze quotation information.

 Implementing the protocol will extend the implementing type
 with functionality that builds on these `String` extensions:

 ```swift
 let string = "..."
 let locale = Locale(identifier: "en-US")
 string.hasUnclosedAlternateQuotation(for: locale)
 string.hasUnclosedQuotation(for: locale)
 ```

 `UITextDocumentProxy` uses the extensions to implement this:

 ```swift
 let locale = Locale(identifier: "en-US")
 proxy.hasUnclosedQuotationBeforeInput(for: locale)
 proxy.hasUnclosedAlternateQuotationBeforeInput(for: locale)
 ```

 Although you can just use the type extensions and basically
 ignore the protocol, the protocol plays together with other
 protocols and makes the functionality appear in the library
 docs, which by default omit native type extensions.
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
}
