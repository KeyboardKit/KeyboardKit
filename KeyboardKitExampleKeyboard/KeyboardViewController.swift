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
 it full access. 
 
 IMPORTANT: When you're creating your own keyboard extension,
 you must enable `RequestsOpenAccess` in `Info.plist` to get
 the `Full Access` option to show up in system settings. You
 must also add a `NSPhotoLibraryAddUsageDescription` setting
 to the hosting app's `Info.plist` if you want to be able to
 save images to the photo album. This is already done in the
 demo app, so you can just copy the setup.
 
 IMPORTANT: This demo app creates a custom keyboard switcher,
 which will only be displayed if the system does not already
 create one for you (e.g. on iPhone X). If you want to add a
 bunch of system keys, like backspace, shift, space etc. you
 can either use the
 
 */

import UIKit
import KeyboardKit

class KeyboardViewController: GridKeyboardInputViewController {
    
    
    // MARK: - View Controller Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupKeyboard(for: UIScreen.main.bounds.size)
        setupSystemButtons()
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        setupKeyboard(for: size)
    }
    
    
    // MARK: - Properties
    
    var alerter = ToastAlerter()
    
    var keyboardAppearance: UIKeyboardAppearance = .default {
        didSet {
            view.tintColor = keyboardAppearance == .dark ? .white : .black
        }
    }
    
    
    // MARK: - Setup
    
    open override func setupCollectionView() {
        super.setupCollectionView()
        collectionView.contentInset.top = 5
        collectionView.contentInset.bottom = 10
        collectionView.register(DemoCell.defaultNib, forCellWithReuseIdentifier: "Cell")
    }
    
    
    // MARK: - Layout
    
    override func layoutSystemButtons(_ buttons: [UIView], buttonSize: CGSize, startX: CGFloat, y: CGFloat) {
        super.layoutSystemButtons(buttons, buttonSize: buttonSize, startX: startX, y: y)
        buttons.forEach {
            let center = $0.center
            $0.frame.size = CGSize(width: 25, height: 25)
            $0.center = center
        }
    }
    
    
    // MARK: - Public Functions
    
    override func handleLongPress(on action: KeyboardAction) {
        super.handleLongPress(on: action)
        guard let image = action.image else { return }
        guard hasFullAccess else { return alert("You must enable full access to save images to photos.") }
        image.saveToPhotos(completionTarget: self, completionSelector: #selector(handleImage(_:didFinishSavingWithError:contextInfo:)))
    }
    
    @objc func handleImage(_ image: UIImage, didFinishSavingWithError error: Error?, contextInfo: UnsafeRawPointer) {
        if error == nil { alert("Saved!") }
        else { alert("Failed!") }
    }
    
    override func handleTap(on action: KeyboardAction) {
        super.handleTap(on: action)
        guard let image = action.image else { return }
        guard hasFullAccess else { return alert("You must enable full access to copy images.") }
        guard image.copyToPasteboard() else { return alert("The image could not be copied.") }
        alert("Copied to pasteboard!")
    }

    override func textDidChange(_ textInput: UITextInput?) {
        guard
            let appearance = textDocumentProxy.keyboardAppearance,
            appearance != keyboardAppearance
            else { return }
        keyboardAppearance = appearance
        collectionView.reloadData()
    }
    
    
    // MARK: - UICollectionViewDataSource
    
    open override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath)
        guard
            let button = action(at: indexPath),
            let buttonCell = cell as? DemoCell
            else { return cell }
        buttonCell.setup(with: button, appearance: keyboardAppearance, tintColor: collectionView.tintColor)
        addLongPressGesture(to: buttonCell, with: button)
        return cell
    }
}


// MARK: - Setup

fileprivate extension KeyboardViewController {
    
    func setupKeyboard(for size: CGSize) {
        let isLandscape = size.width > 400
        let height: CGFloat = isLandscape ? 150 : 200
        let rowsPerPage = isLandscape ? 3 : 4
        let buttonsPerRow = isLandscape ? 8 : 6
        setup(withKeyboard: DemoKeyboard(), height: height, rowsPerPage: rowsPerPage, buttonsPerRow: buttonsPerRow)
    }
    
    func setupSystemButtons() {
        setupLeftSystemButtons()
        setupRightSystemButtons()
    }
    
    func setupLeftSystemButtons() {
        leftSystemButtons = [
            createSystemButton(image: Asset.globe.image, action: .nextKeyboard),
            createSystemButton(image: Asset.space.image, action: .space)
            ].compactMap { $0 }
    }
    
    func setupRightSystemButtons() {
        rightSystemButtons = [
            createSystemButton(image: Asset.backspace.image, action: .backspace),
            createSystemButton(image: Asset.newline.image, action: .newLine)
            ].compactMap { $0 }
    }
}


// MARK: - Private Functions

fileprivate extension KeyboardViewController {
    
    func alert(_ message: String) {
        alerter.alert(message: message, in: view, withDuration: 4)
    }
}
