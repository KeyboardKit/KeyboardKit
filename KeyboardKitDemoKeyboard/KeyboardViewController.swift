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
 
 This demo app handles system actions as normal (e.g. change
 keyboard, space, new line etc.), injects strings and emojis
 into the text proxy and handles the rightmost images in the
 emoji keyboard by copying them to the pasteboard on tap and
 saving them to the user's photo album on long press.
 
 IMPORTANT: To use this demo keyboard, you have to enable it
 in system settings ("Settings/General/Keyboards") then give
 it full access (this requires enabling `RequestsOpenAccess`
 in `Info.plist`) if you want to use image buttons. You must
 also add a `NSPhotoLibraryAddUsageDescription` to your host
 app's `Info.plist` if you want to be able to save images to
 the photo album. This is already taken care of in this demo
 app, so you can just copy the setup into your own app.
 
 The keyboard is setup in `viewDidAppear(...)` since this is
 when `needsInputModeSwitchKey` first gets the correct value.
 Before this point, the value is `true` even if it should be
 `false`. If you find a way to solve this bug, you can setup
 the keyboard earlier.
 
 The autocomplete parts of this class is the first iteration
 of autocomplete support in KeyboardKit. The intention is to
 move these parts to `KeyboardInputViewController` and a new
 api for working with autocomplete.
 
 **IMPORTANT** `textWillChange` and `textDidChange` does not
 trigger when a user types and text is sent to the proxy. It
 however works when the text cursor changes its position, so
 I therefore use a (hopefully temporary) hack, by starting a
 timer that triggers each second and moves the cursor. Since
 this is a nasty hack, it may have yet to be discovered side
 effects. If so, please let me know.
 
 */
class KeyboardViewController: KeyboardInputViewController {
    
    
    // MARK: - View Controller Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        autocompleteBugFixTimer = createAutocompleteBugFixTimer()
        keyboardActionHandler = DemoKeyboardActionHandler(inputViewController: self)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupKeyboard()
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        setupKeyboard(for: size)
    }
    
    
    // MARK: - Keyboard Functionality
    
    override func textDidChange(_ textInput: UITextInput?) {
        super.textDidChange(textInput)
        requestAutocompleteSuggestions()
    }
    
    override func selectionWillChange(_ textInput: UITextInput?) {
        super.selectionWillChange(textInput)
        autocompleteToolbar.reset()
    }
    
    override func selectionDidChange(_ textInput: UITextInput?) {
        super.selectionDidChange(textInput)
        autocompleteToolbar.reset()
    }
    
    
    // MARK: - Properties
    
    let alerter = ToastAlert()
    
    var autocompleteBugFixTimer: AutocompleteBugFixTimer?
    
    var keyboardType = KeyboardType.alphabetic(uppercased: false) {
        didSet { setupKeyboard() }
    }
    
    
    // MARK: - Autocomplete
    
    lazy var autocompleteProvider = DemoAutocompleteSuggestionProvider()
    
    lazy var autocompleteToolbar: AutocompleteToolbar = {
        let proxy = textDocumentProxy
        let toolbar = AutocompleteToolbar(
            buttonCreator: { DemoAutocompleteLabel(word: $0, proxy: proxy) }
        )
        toolbar.update(with: ["foo", "bar", "baz"])
        return toolbar
    }()
}
