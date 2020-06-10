//
//  KeyboardViewController.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2018-03-04.
//  Copyright © 2018 Daniel Saidi. All rights reserved.
//

import UIKit
import KeyboardKit

/**
 This UIKit-based demo keyboard demonstrates how to create a
 UIKit-based keyboard extension using `KeyboardKit`.
 
 This demo keyboard handles a bunch of actions, sends string
 and emoji inputs to the text proxy, copies tapped images to
 the pasteboard and saves long pressed images to photos etc.
 It also has a topmost auto complete toolbar with three fake
 suggestions for the currently active word.
 
 `IMPORTANT` To use this keyboard, you must enable it in the
 system keyboard settings ("Settings/General/Keyboards") and
 give it full access, which is unfortunately required to use
 some features like haptic and audio feedback, access to the
 user's photos etc.
 
 If you want to use these features in your own app, you must
 add `RequestsOpenAccess` to the extension `Info.plist`, add
 a `NSPhotoLibraryAddUsageDescription` to the **host** app's
 `Info.plist` etc. This is already done in this demo app, so
 you can just copy the setup into your own app.
 */
class KeyboardViewController: KeyboardInputViewController {
    
    
    // MARK: - View Controller Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        keyboardType = .alphabetic(.lowercased)
        keyboardActionHandler = DemoKeyboardActionHandler(inputViewController: self)
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        setupKeyboard(for: size)
    }
    
    
    // MARK: - Keyboard Functionality
    
    override func setupKeyboard() {
        setupKeyboard(for: view.bounds.size)
    }
    
    override func selectionWillChange(_ textInput: UITextInput?) {
        super.selectionWillChange(textInput)
        autocompleteToolbar.reset()
    }
    
    override func selectionDidChange(_ textInput: UITextInput?) {
        super.selectionDidChange(textInput)
        autocompleteToolbar.reset()
    }
    
    override func textDidChange(_ textInput: UITextInput?) {
        super.textDidChange(textInput)
        requestAutocompleteSuggestions()
    }
    
    
    // MARK: - Properties
    
    let alerter = ToastAlert()
    
    var emojiKeyboard: EmojiKeyboard?
    var emojiCategoryTitleLabel = UILabel()
    var emojiCollectionView: KeyboardButtonRowCollectionView!
    var emojiLabelUpdateAction = {}
    
    
    // MARK: - Autocomplete
    
    lazy var autocompleteProvider = DemoAutocompleteSuggestionProvider()
    
    lazy var autocompleteToolbar: AutocompleteToolbarView = {
        AutocompleteToolbarView(textDocumentProxy: textDocumentProxy)
    }()
}
