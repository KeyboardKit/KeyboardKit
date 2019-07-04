//
//  KeyboardViewController.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2018-03-04.
//  Copyright © 2018 Daniel Saidi. All rights reserved.
//

/*
 
 This demo app handles system actions as normal (e.g. change
 keyboard, space, new line etc.), injects strings and emojis
 into the text proxy and handles the rightmost images in the
 emoji keyboarx by copying them to the pasteboard on tap and
 saving them to the user's photo album on long press.
 
 The keyboard is setup in `viewDidAppear(...)` since this is
 when `needsInputModeSwitchKey` first gets the correct value.
 Before this point, the value is `true` even if it should be
 `false`. If you find a way to solve this, you can setup the
 keyboard earlier.
 
 IMPORTANT: To use this demo keyboard, you have to enable it
 in system settings ("Settings/General/Keyboards") then give
 it full access (this requires enabling `RequestsOpenAccess`
 in `Info.plist`) if you want to use image buttons. You must
 also add a `NSPhotoLibraryAddUsageDescription`  to the host
 app's `Info.plist` if you want to be able to save images to
 the photo album. This is already taken care of in this demo
 app, so you can just copy the setup into your own app.
 
 */

import UIKit
import KeyboardKit

class KeyboardViewController: KeyboardInputViewController {
    
    
    // MARK: - View Controller Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
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
    
    
    // MARK: - Mode
    
    var keyboardType = KeyboardType.alphabetic(uppercased: false) {
        didSet { setupKeyboard() }
    }
    
    
    // MARK: - Properties
    
    let alerter = ToastAlert()
    
    private lazy var autocompleteToolbar: AutocompleteToolbar = {
        let toolbar = AutocompleteToolbar(
            height: 50,
            buttonCreator: { word in
                let button = UIButton(type: .system)
                button.setTitle(word, for: .normal)
                button.addTapAction { [weak self] in
                    self?.textDocumentProxy.replaceCurrentWord(with: word)
                }
                return button
            }
        )
        toolbar.update(with: ["foo", "bar", "baz"])
        return toolbar
    }()
    
    var keyboardSwitcherAction: KeyboardAction {
        return needsInputModeSwitchKey ? .switchKeyboard : .switchToKeyboard(.emojis)
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
        return KeyboardButtonRow(height: 50, actions: actions, distribution: distribution) {
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
