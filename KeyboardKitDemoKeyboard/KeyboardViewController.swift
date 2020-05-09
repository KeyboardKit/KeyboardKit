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
 This demo keyboard handles system actions as normal (change
 keyboard, space, new line etc.), injects strings and emojis
 into the text proxy, copies tapped images to the pasteboard
 and saves long pressed images to the user's photo album.
 
 IMPORTANT: To use this demo keyboard, you have to enable it
 in system settings ("Settings/General/Keyboards") then give
 it full access (this requires enabling `RequestsOpenAccess`
 in `Info.plist`) if you want to use image buttons. You must
 also add a `NSPhotoLibraryAddUsageDescription` to your host
 app's `Info.plist` if you want to be able to save images to
 the photo album. This is already taken care of in this demo
 app, so you can just copy the setup into your own app.
 
 This demo keyboard also has a topmost auto complete toolbar
 that displays dummy suggestions for the current word.
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
    
    lazy var autocompleteToolbar: AutocompleteToolbar = {
        AutocompleteToolbar(textDocumentProxy: textDocumentProxy)
    }()
}
