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
 
 IMPORTANT: To use this demo keyboard, you have to enable it
 in system settings ("Settings/General/Keyboards") then give
 it full access (this requires enabling `RequestsOpenAccess`
 in `Info.plist`) if you want to use image buttons. You must
 also add a `NSPhotoLibraryAddUsageDescription`  to the host
 app's `Info.plist` if you want to be able to save images to
 the photo album. This is already taken care of in this demo
 app, so you can just copy the setup.
 
 */

import UIKit
import KeyboardKit

class KeyboardViewController: KeyboardInputViewController {
    
    
    // MARK: - View Controller Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        keyboardActionHandler = DemoKeyboardActionHandler(inputViewController: self)
        setupKeyboard(with: view.frame.size)
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        setupKeyboard(with: size)
    }
    
    override func viewWillSyncWithTextDocumentProxy() {
        super.viewWillSyncWithTextDocumentProxy()
//        let isDark = textDocumentProxy.keyboardAppearance == .dark
//        view.tintColor = isDark ? .white : .black
    }
    
    override func handleInputModeList(from view: UIView, with event: UIEvent) {
        super.handleInputModeList(from: view, with: event)
    }
    
    
    // MARK: - Setup
    
    func setupKeyboard(with size: CGSize) {
        setupTopSystemButtons()
        setupCollectionView()
        setupBottomSystemButtons()
    }
    
    func setupTopSystemButtons() {
        let actions: [KeyboardAction] = [.switchKeyboard, .character("2"), .character("3"), .character("4"), .character("5")]
        let row = KeyboardButtonRow(height: 44, actions: actions) { return button(for: $0) }
        row.buttonStackView.distribution = .equalSpacing
        keyboardStackView.addArrangedSubview(row)
    }
    
    func setupCollectionView() {
        let actions: [KeyboardAction] = [.switchKeyboard, .character("2"), .character("3"), .character("4"), .character("5")]
        let collectionView = KeyboardButtonCollectionView(actions: actions + actions) { [weak self] in return self?.button(for: $0) }
        collectionView.height = 120
        keyboardStackView.addArrangedSubview(collectionView)
    }
    
    func setupBottomSystemButtons() {
        let actions: [KeyboardAction] = [.switchKeyboard, .character("2"), .character("3"), .character("4"), .character("5")]
        let row = KeyboardButtonRow(height: 44, actions: actions) { return button(for: $0) }
        row.buttonStackView.distribution = .equalSpacing
        keyboardStackView.addArrangedSubview(row)
    }
//    
//    func setupKeyboard(for size: CGSize) {
//        let isLandscape = size.width > 400
//        let height: CGFloat = isLandscape ? 150 : 200
//        let rowsPerPage = isLandscape ? 3 : 4
//        let buttonsPerRow = isLandscape ? 8 : 6
//        gridPresenter.setup(withHeight: height, rowsPerPage: rowsPerPage, buttonsPerRow: buttonsPerRow)
//    }
    
    
    // MARK: - Properties
    
    var alerter = ToastAlert()
    var collectionView: UICollectionView!
    //var gridPresenter: GridKeyboardPresenter!
}


// MARK: - Private Functions

extension KeyboardViewController {
    
    func button(for action: KeyboardAction) -> UIView {
        let view = DemoButton.initWithDefaultNib(owner: self)
        view.setup(with: action, in: self, appearance: textDocumentProxy.keyboardAppearance ?? .dark, tintColor: .black)
        view.width = 50
        return view
    }
}
