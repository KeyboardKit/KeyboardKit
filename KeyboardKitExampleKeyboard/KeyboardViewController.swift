//
//  KeyboardViewController.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2018-03-04.
//  Copyright © 2018 Daniel Saidi. All rights reserved.
//

/*
 
 In the demo app, the keyboard will handle system actions as
 normal (e.g. change keyboard, space, new line etc.), inject
 plain string characters into the proxy and handle emojis by
 copying them on tap and saving them to photos on long press.
 
 The keyboard is setup in `viewDidAppear(...)` since this is
 when `needsInputModeSwitchKey` gets a correct value. Before
 this, the value is `true`, even if it should be `false`. If
 you can solve this, you can setup the keyboard earlier.
 
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
        setupKeyboard()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupKeyboard()
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        setupKeyboard(for: size)
    }
    
    
    // MARK: - Mode
    
    enum KeyboardMode: Equatable {
        case alphabetic(uppercased: Bool), numeric, symbolic, emojis
    }
    
    var keyboardMode = KeyboardMode.alphabetic(uppercased: false) {
        didSet { setupKeyboard() }
    }
    
    
    // MARK: - Setup
    
    func setupKeyboard() {
        setupKeyboard(for: view.bounds.size)
    }
    
    func setupKeyboard(for size: CGSize) {
        keyboardStackView.removeAllArrangedSubviews()
        switch keyboardMode {
        case .alphabetic(let uppercased): setupAlphabeticKeyboard(uppercased: uppercased)
        case .numeric: setupNumericKeyboard()
        case .symbolic: setupSymbolicKeyboard()
        case .emojis: setupEmojiKeyboard(for: size)
        }
    }
    
    
    // MARK: - Properties
    
    let alerter = ToastAlert()
    
    var keyboardSwitcherAction: KeyboardAction {
        return needsInputModeSwitchKey ? .switchKeyboard : .switchToEmojiKeyboard
    }
}


// MARK: - Private Functions

extension KeyboardViewController {
    
    func button(for action: KeyboardAction, distribution: UIStackView.Distribution = .equalSpacing) -> UIView {
        if action == .none { return noneActionbutton(distribution: distribution) }
        let view = DemoButton.fromNib(owner: self)
        view.setup(with: action, in: self, distribution: distribution)
        return view
    }
    
    func buttonRow(for actions: [KeyboardAction], distribution: UIStackView.Distribution) -> KeyboardButtonRow {
        return KeyboardButtonRow(height: 50, actions: actions, distribution: distribution) {
            return button(for: $0, distribution: distribution)
        }
    }
    
    func buttonRows(for actions: [[KeyboardAction]], distribution: UIStackView.Distribution) -> [KeyboardButtonRow] {
        return actions.map { buttonRow(for: $0, distribution: distribution) }
    }
    
    func noneActionbutton(distribution: UIStackView.Distribution) -> UIView {
        let view = KeyboardSpacerView(frame: .zero)
        view.width = KeyboardAction.none.keyboardWidth(for: distribution)
        return view
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
        let bottom = buttonRows(for: [keyboard.bottomActions], distribution: .fillProportionally)
        keyboardStackView.addArrangedSubview(view)
        keyboardStackView.addArrangedSubviews(bottom)
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
