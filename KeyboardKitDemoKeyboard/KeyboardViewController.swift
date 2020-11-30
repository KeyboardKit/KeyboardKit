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
 keyboard extension using `KeyboardKit` and `UIKit`.
 
 This keyboard sends text and emoji inputs to the text proxy,
 copies tapped images to the device's pasteboard, saves long
 pressed images to photos etc. It also adds an auto complete
 toolbar that provides fake suggestions for the current word.
 
 `IMPORTANT` To use this keyboard, you must enable it in the
 system keyboard settings ("Settings/General/Keyboards") and
 give it full access, which is unfortunately required to use
 some features like haptic and audio feedback, let it access
 the user's photos etc.
 
 If you want to use these features in your own app, you must
 add `RequestsOpenAccess` to the extension's `Info.plist` to
 make it possible for the user to enable full access. If you
 want to allow the keyboard to access the user's photo album,
 you must add the `NSPhotoLibraryAddUsageDescription` key to
 the **host** application's `Info.plist`. Have a look at the
 demo app and extension and copy the parts that you need.
 */
class KeyboardViewController: KeyboardInputViewController {
    
    
    // MARK: - View Controller Lifecycle
    
    /**
     The demo injects a custom, demo-specific action handler
     when the controller is created.
     */
    override func viewDidLoad() {
        super.viewDidLoad()
        context.actionHandler = DemoKeyboardActionHandler(inputViewController: self)
    }
    
    /**
     The demo recreates the keyboard when a trait collection
     changes, e.g. when the screen is rotated.
     */
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        setupKeyboard()
    }
    
    /**
     The demo recreates the keyboard when the app is resized,
     e.g. when resizing an iPad app in split screen.
     */
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        setupKeyboard(for: size)
    }
    
    
    // MARK: - Keyboard Functionality
    
    override func setupKeyboard() {
        setupKeyboard(for: view.bounds.size)
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
    
    override func performAutocomplete() {
        guard let word = textDocumentProxy.currentWord else { return resetAutocomplete() }
        autocompleteProvider.autocompleteSuggestions(for: word) { [weak self] in
            switch $0 {
            case .failure(let error): print(error.localizedDescription)
            case .success(let result): self?.autocompleteToolbar.update(with: result)
            }
        }
    }
    
    override func resetAutocomplete() {
        autocompleteToolbar.reset()
    }
}
