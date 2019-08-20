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
    
    var keyboardSwitcherAction: KeyboardAction {
        return needsInputModeSwitchKey ? .switchKeyboard : .switchToKeyboard(.emojis)
    }
    
    
    // MARK: - Autocomplete
    
    private lazy var autocompleteProvider = DemoAutocompleteSuggestionProvider()
    
    private lazy var autocompleteToolbar: AutocompleteToolbar = {
        let proxy = textDocumentProxy
        let toolbar = AutocompleteToolbar(
            buttonCreator: { DemoAutocompleteLabel(word: $0, proxy: proxy) }
        )
        toolbar.update(with: ["foo", "bar", "baz"])
        return toolbar
    }()
    
    private func requestAutocompleteSuggestions() {
        let word = textDocumentProxy.currentWord ?? ""
        autocompleteProvider.provideAutocompleteSuggestions(for: word) { [weak self] in
            switch $0 {
            case .failure(let error): print(error.localizedDescription)
            case .success(let result): self?.autocompleteToolbar.update(with: result)
            }
        }
    }
    
    private func resetAutocompleteSuggestions() {
        autocompleteToolbar.reset()
    }
}


// MARK: - Setup

private extension KeyboardViewController {
    
    func setupKeyboard() {
        setupKeyboard(for: view.bounds.size)
    }
    
    func setupKeyboard(for size: CGSize) {
        DispatchQueue.main.async {
            self.setupKeyboardAsync(for: size)
        }
    }
    
    func setupKeyboardAsync(for size: CGSize) {
        keyboardStackView.removeAllArrangedSubviews()
        switch keyboardType {
        case .alphabetic(let uppercased): setupAlphabeticKeyboard(uppercased: uppercased)
        case .numeric: setupNumericKeyboard()
        case .symbolic: setupSymbolicKeyboard()
        case .emojis: setupEmojiKeyboard(for: size)
        default: return
        }
    }
    
    func setupAlphabeticKeyboard(uppercased: Bool = false) {
        let keyboard = AlphabeticKeyboard(uppercased: uppercased, in: self)
        let rows = buttonRows(for: keyboard.actions, distribution: .fillProportionally)
        keyboardStackView.addArrangedSubviews(rows)
    }
    
    func setupEmojiKeyboard(for size: CGSize) {
        let keyboard = EmojiKeyboard(in: self)
        let isLandscape = size.width > 400
        let rowsPerPage = isLandscape ? 3 : 4
        let buttonsPerRow = isLandscape ? 8 : 6
        let config = KeyboardButtonRowCollectionView.Configuration(rowHeight: 50, rowsPerPage: rowsPerPage, buttonsPerRow: buttonsPerRow)
        let view = KeyboardButtonRowCollectionView(actions: keyboard.actions, configuration: config) { [unowned self] in return self.button(for: $0) }
        let bottom = buttonRow(for: keyboard.bottomActions, distribution: .fillProportionally)
        keyboardStackView.addArrangedSubview(view)
        keyboardStackView.addArrangedSubview(bottom)
    }
    
    func setupNumericKeyboard() {
        let keyboard = NumericKeyboard(in: self)
        let rows = buttonRows(for: keyboard.actions, distribution: .fillProportionally)
        keyboardStackView.addArrangedSubviews(rows)
    }
    
    func setupSymbolicKeyboard() {
        let keyboard = SymbolicKeyboard(in: self)
        let rows = buttonRows(for: keyboard.actions, distribution: .fillProportionally)
        keyboardStackView.addArrangedSubviews(rows)
    }
}


// MARK: - Private Button Functions

private extension KeyboardViewController {
    
    func button(for action: KeyboardAction, distribution: UIStackView.Distribution = .equalSpacing) -> UIView {
        if action == .none { return KeyboardSpacerView(width: 10) }
        let view = DemoButton.fromNib(owner: self)
        view.setup(with: action, in: self, distribution: distribution)
        return view
    }
    
    func buttonRow(for actions: KeyboardActionRow, distribution: UIStackView.Distribution) -> KeyboardStackViewComponent {
        return KeyboardButtonRow(actions: actions, distribution: distribution) {
            button(for: $0, distribution: distribution)
        }
    }
    
    func buttonRows(for actionRows: KeyboardActionRows, distribution: UIStackView.Distribution) -> [KeyboardStackViewComponent] {
        var rows = actionRows.map {
            buttonRow(for: $0, distribution: distribution)
        }
        rows.insert(autocompleteToolbar, at: 0)
        return rows
    }
}
