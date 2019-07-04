//
//  MockTextDocumentProxy.swift
//  KeyboardKitTests
//
//  Created by Daniel Saidi on 2019-07-04.
//  Copyright © 2019 Daniel Saidi. All rights reserved.
//

import MockNRoll
import UIKit

class MockTextDocumentProxy: NSObject, UITextDocumentProxy {
    
    let recorder = Mock()
    
    var hasText: Bool = false
    
    var documentContextBeforeInput: String?
    var documentContextAfterInput: String?
    var selectedText: String?
    var documentInputMode: UITextInputMode?
    var documentIdentifier: UUID = UUID()
    
    func adjustTextPosition(byCharacterOffset offset: Int) {
        recorder.invoke(adjustTextPosition, args: (offset))
    }
    
    func deleteBackward() {
        recorder.invoke(deleteBackward, args: ())
    }
    
    func insertText(_ text: String) {
        recorder.invoke(insertText, args: (text))
    }
}
