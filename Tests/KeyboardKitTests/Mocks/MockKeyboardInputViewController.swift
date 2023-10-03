//
//  MockKeyboardInputViewController.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2019-05-28.
//  Copyright © 2021-2023 Daniel Saidi. All rights reserved.
//

#if os(iOS) || os(tvOS)
import KeyboardKit
import MockingKit
import UIKit

class MockKeyboardInputViewController: KeyboardInputViewController, Mockable {
    
    lazy var dismissKeyboardRef = MockReference(dismissKeyboard)
    lazy var performAutocompleteRef = MockReference(performAutocomplete)
    
    let mock = Mock()
    
    var textDocumentProxyReplacement: UITextDocumentProxy?
    
    override var textDocumentProxy: UITextDocumentProxy { textDocumentProxyReplacement ?? super.textDocumentProxy }
    
    override func dismissKeyboard() {
        call(dismissKeyboardRef, args: ())
    }
    
    override func performAutocomplete() {
        call(performAutocompleteRef, args: ())
    }
}
#endif
