//
//  MockTextInput.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2021-07-14.
//  Copyright © 2021 Daniel Saidi. All rights reserved.
//

import UIKit
import MockingKit

class MockTextInput: UIResponder, Mockable, UITextInput {
    
    override init() {
        super.init()
    }
    
    let mock = Mock()
    
    var beginningOfDocument = UITextPosition()
    var endOfDocument = UITextPosition()
    var hasText: Bool = false
    weak var inputDelegate: UITextInputDelegate?
    var markedTextRange: UITextRange?
    var markedTextStyle: [NSAttributedString.Key: Any]?
    var selectedTextRange: UITextRange?
    var tokenizer: UITextInputTokenizer { fatalError() }
    
    func baseWritingDirection(for position: UITextPosition, in direction: UITextStorageDirection) -> NSWritingDirection { .leftToRight }
    func caretRect(for position: UITextPosition) -> CGRect { .zero }
    func characterRange(at point: CGPoint) -> UITextRange? { nil }
    func characterRange(byExtending position: UITextPosition, in direction: UITextLayoutDirection) -> UITextRange? { nil }
    func closestPosition(to point: CGPoint) -> UITextPosition? { nil }
    func closestPosition(to point: CGPoint, within range: UITextRange) -> UITextPosition? { nil }
    func compare(_ position: UITextPosition, to other: UITextPosition) -> ComparisonResult { .orderedAscending }
    func deleteBackward() {}
    func firstRect(for range: UITextRange) -> CGRect { .zero }
    func insertText(_ text: String) {}
    func offset(from: UITextPosition, to toPosition: UITextPosition) -> Int { 0 }
    func position(from position: UITextPosition, offset: Int) -> UITextPosition? { nil }
    func position(from position: UITextPosition, in direction: UITextLayoutDirection, offset: Int) -> UITextPosition? { nil }
    func replace(_ range: UITextRange, withText text: String) {}
    func position(within range: UITextRange, farthestIn direction: UITextLayoutDirection) -> UITextPosition? { nil }
    func selectionRects(for range: UITextRange) -> [UITextSelectionRect] { [] }
    func setBaseWritingDirection(_ writingDirection: NSWritingDirection, for range: UITextRange) {}
    func setMarkedText(_ markedText: String?, selectedRange: NSRange) {}
    func text(in range: UITextRange) -> String? { nil }
    func textRange(from fromPosition: UITextPosition, to toPosition: UITextPosition) -> UITextRange? { UITextRange() }
    func unmarkText() {}
}
