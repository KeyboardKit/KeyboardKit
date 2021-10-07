//
//  UITextDocumentProxy+Delete.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2019-07-02.
//  Copyright © 2021 Daniel Saidi. All rights reserved.
//

import UIKit

public extension UITextDocumentProxy {
    
    /**
     Delete backwards a certain number of times.
     */
    func deleteBackward(times: Int) {
        for _ in 0..<times { deleteBackward() }
    }
    
    /**
     Delete backwards a certain range.
     */
    func deleteBackward(range: DeleteBackwardRange) {
        guard let text = deleteBackwardText(for: range) else { return deleteBackward() }
        deleteBackward(times: text.count)
    }
}

extension UITextDocumentProxy {
    
    func deleteBackwardText(for range: DeleteBackwardRange) -> String? {
        guard let text = documentContextBeforeInput else { return nil }
        switch range {
        case .char: return text.lastCharacter
        case .sentence: return text.lastSentenceSegment
        case .word: return text.lastWordSegment
        }
    }
}

private extension String {
    
    var lastCharacter: String? {
        guard let last = last else { return nil }
        return String(last)
    }
    
    var lastSentenceSegment: String {
        lastSegment(isSegmentDelimiter: { $0.isSentenceDelimiter })
    }
    
    var lastWordSegment: String {
        lastSegment(isSegmentDelimiter: { $0.isWordDelimiter })
    }
    
    func lastSegment(isSegmentDelimiter: (String) -> Bool) -> String {
        var result = last { $0.isWhitespace }.map { String($0) } ?? ""
        var text = self.trimmingCharacters(in: .whitespaces)
        var foundNonDelimiter = false
        while let char = text.popLast() {
            let char = String(char)
            let isDelimiter = isSegmentDelimiter(char)
            if isDelimiter && foundNonDelimiter { break }
            foundNonDelimiter = !isDelimiter
            result.append(char)
        }
        return String(result.reversed())
    }
}
