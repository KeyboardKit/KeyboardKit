//
//  KeyboardViewController.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2018-03-04.
//  Copyright © 2021 Daniel Saidi. All rights reserved.
//

import Combine
import UIKit
import KeyboardKit

/**
 This UIKit-based demo keyboard demonstrates how to create a
 keyboard extension using `KeyboardKit` and `UIKit`.
 
 The demo injects a custom, demo-specific action handler and
 layout provider when the controller is created.
 
 The demo then sends text and emoji inputs to the text proxy,
 copies tapped images to the device's pasteboard, saves long
 pressed images to photos etc. It also adds an auto complete
 toolbar that provides fake suggestions for the current word.
 
 `NOTE` That this class calls `setupKeyboard` for big events.
 It should observe the keyboard context instead.
 
 `IMPORTANT` To use this keyboard, you must enable it in the
 system keyboard settings ("Settings/General/Keyboards"). It
 needs full access for haptic and audio feedback, for access
 to the user's photos etc.
 
 If you want to use these features in your own app, you must
 add `RequestsOpenAccess` to the extension's `Info.plist` to
 make it possible to enable full access. To access the photo
 album, you have to add a `NSPhotoLibraryAddUsageDescription`
 key to the `host` application's `Info.plist`.
 */
class KeyboardViewController: KeyboardInputViewController {
    
    
    // MARK: - View Controller Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        keyboardActionHandler = DemoKeyboardActionHandler(
            inputViewController: self)
        keyboardLayoutProvider = StandardKeyboardLayoutProvider(
            inputSetProvider: keyboardInputSetProvider)
        setupStateObservation()
        setup(with: stackView)
    }
    
    override func textDidChange(_ textInput: UITextInput?) {
        super.textDidChange(textInput)
        keyboardContext.keyboardType = keyboardContext.preferredKeyboardType
        setupDemoKeyboard()
    }
    
    /**
     This demo recreates the keyboard when view controller's
     trait collections change.
     */
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        setupDemoKeyboard()
    }
    
    /**
     This demo recreates the keyboard when view controller's
     size changes.
     */
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        setupDemoKeyboard()
    }
    
    
    // MARK: - Properties
    
    let alerter = UIKeyboardToastAlert()
    var emojiKeyboard: EnhancedEmojiKeyboard?
    var emojiCategoryTitleLabel = UILabel()
    var emojiCollectionView: HFloatingHeaderButtonCollectionView!
    var emojiLabelUpdateAction = {}
    
    lazy var stackView = UIStackView()
    
    private var cancellables = Set<AnyCancellable>()
    
    
    // MARK: - Autocomplete
    
    lazy var autocompleteProvider = DemoAutocompleteSuggestionProvider()
    
    lazy var autocompleteToolbar: UIAutocompleteToolbar = {
        UIAutocompleteToolbar(textDocumentProxy: textDocumentProxy, height: 50)
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

private extension KeyboardViewController {
    
    func setupStateObservation() {
        setupKeyboardTypeObservation()
    }
    
    func setupKeyboardTypeObservation() {
        keyboardContext.$keyboardType.sink { [weak self] _ in
            DispatchQueue.main.async {
                self?.setupDemoKeyboard()
            }
        }.store(in: &cancellables)
    }
}
