//
//  UITextDocumentProxy+Quotation.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2021-03-17.
//  Copyright © 2021-2025 Daniel Saidi. All rights reserved.
//

#if os(iOS) || os(tvOS) || os(visionOS)

// MARK: - UITextDocumentProxy

import UIKit

public extension UITextDocumentProxy {

    /// Whether the last trailing quotation before the input
    /// cursor is an alternate quotation begin delimiter.
    func hasUnclosedAlternateQuotationBeforeInput(
        for locale: Locale
    ) -> Bool {
        documentContextBeforeInput?
            .hasUnclosedAlternateQuotation(for: locale) ?? false
    }

    /// Whether the last trailing quotation before the input
    /// cursor is a quotation begin delimiter.
    func hasUnclosedQuotationBeforeInput(
        for locale: Locale
    ) -> Bool {
        documentContextBeforeInput?
            .hasUnclosedQuotation(for: locale) ?? false
    }

    /// Whether the provided text has quotations that should
    /// be replaced with something else for a certain locale.
    func preferredQuotationReplacement(
        whenInserting text: String,
        for locale: Locale
    ) -> String? {
        documentContextBeforeInput?
            .preferredQuotationReplacement(whenAppending: text, for: locale)
    }
}
#endif
