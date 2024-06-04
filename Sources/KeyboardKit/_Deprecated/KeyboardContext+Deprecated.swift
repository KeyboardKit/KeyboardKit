//
//  File.swift
//  
//
//  Created by Daniel Saidi on 2024-06-04.
//

import Foundation

extension KeyboardContext {

    @available(*, deprecated, message: "Use the text document proxy to end the current sentence.")
    func endSentence(text: String = ". ") {
        #if os(iOS) || os(tvOS) || os(visionOS)
        textDocumentProxy.endSentence(withText: text)
        #endif
    }
}
