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
        setupTopSystemButtons()
        setupKeyboard()
        setupBottomSystemButtons()
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
//        setupKeyboard(for: size)
    }
    
    override func viewWillSyncWithTextDocumentProxy() {
        super.viewWillSyncWithTextDocumentProxy()
//        let isDark = textDocumentProxy.keyboardAppearance == .dark
//        view.tintColor = isDark ? .white : .black
    }
    
    
    // MARK: - Setup
    
    func setupTopSystemButtons() {
        let row = KeyboardButtonRow(rowHeight: 44)
        row.backgroundColor = .green
        row.buttonStackView.distribution = .equalSpacing
        keyboardStackView.addArrangedSubview(row)
        let actions: [KeyboardAction] = [.character("1"), .character("2"), .character("3"), .character("4"), .character("5")]
        row.addButtons(with: actions, actionHandler: keyboardActionHandler, buttonCreator: { return button(for: $0) })
    }
    
    func setupKeyboard() {
        let collectionView = KeyboardCollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        keyboardStackView.addArrangedSubview(collectionView)
        collectionView.backgroundColor = .yellow
        collectionView.heightConstraint.constant = 100
        let config = GridKeyboardPresenter.GridConfiguration(rowsPerPage: 3, buttonsPerRow: 5, rowHeight: 50)
        gridPresenter = DemoPresenter(id: "presenter", viewController: self, collectionView: collectionView, configuration: config)
    }
    
    func setupBottomSystemButtons() {
        let row = KeyboardButtonRow(rowHeight: 44)
        row.backgroundColor = .green
        row.buttonStackView.distribution = .equalSpacing
        keyboardStackView.addArrangedSubview(row)
        let actions: [KeyboardAction] = [.character("6"), .character("7"), .character("8"), .character("9"), .character("10")]
        row.addButtons(with: actions, actionHandler: keyboardActionHandler, buttonCreator: { return button(for: $0) })
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
    var gridPresenter: GridKeyboardPresenter!
    
    
    
    
    // MARK: - Layout
    
    /*override func layoutSystemButtons(_ buttons: [UIView], buttonSize: CGSize, startX: CGFloat, y: CGFloat) {
        super.layoutSystemButtons(buttons, buttonSize: buttonSize, startX: startX, y: y)
        buttons.forEach {
            let center = $0.center
            $0.frame.size = CGSize(width: 25, height: 25)
            $0.center = center
        }
    }*/
    
    
    // MARK: - UICollectionViewDataSource
    
//    open override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath)
//        guard
//            let action = keyboardAction(at: indexPath),
//            let buttonCell = cell as? DemoCell
//            else { return cell }
//        buttonCell.setup(with: action, appearance: keyboardAppearance, tintColor: collectionView.tintColor)
//        addLongPressGesture(for: action, to: buttonCell)
//        return cell
//    }
}


// MARK: - Private Functions

extension KeyboardViewController {
    
    func button(for action: KeyboardAction) -> UIView {
        let view = DemoButton.initWithDefaultNib(owner: self)
        view.setup(with: action, appearance: textDocumentProxy.keyboardAppearance ?? .dark, tintColor: .black)
        view.width = 50
        return view
    }
    
    func cell(for action: KeyboardAction) -> UIView {
        let view = DemoButton.initWithDefaultNib(owner: self)
        view.setup(with: action, appearance: textDocumentProxy.keyboardAppearance ?? .dark, tintColor: .black)
        view.width = 50
        return view
    }
}


class DemoPresenter: GridKeyboardPresenter {
    
//    open override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath)
//        guard
//            let action = keyboardAction(at: indexPath),
//            let buttonCell = cell as? DemoCell
//            else { return cell }
//        let appearance = viewController.textDocumentProxy.keyboardAppearance ?? .light
//        buttonCell.setup(with: action, appearance: appearance, tintColor: viewController.view.tintColor)
//        viewController.addLongPressGesture(for: action, to: buttonCell)
//        return cell
//    }
}
