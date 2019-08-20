//
//  DemoKeyboardActionHandler.swift
//  KeyboardKitExampleKeyboard
//
//  Created by Daniel Saidi on 2019-04-24.
//  Copyright © 2019 Daniel Saidi. All rights reserved.
//

import KeyboardKit

/**
 
 This action handler inherits `StandardKeyboardActionHandler`
 and adds demo-specific functionality to it.
 
 */
class DemoKeyboardActionHandler: StandardKeyboardActionHandler {
    
    
    // MARK: - Initialization
    
    public init(inputViewController: UIInputViewController) {
        super.init(
            inputViewController: inputViewController,
            tapHapticFeedback: .standardTapFeedback,
            longPressHapticFeedback: .standardLongPressFeedback
        )
    }
    
    
    // MARK: - Properties
    
    var keyboardShiftState = KeyboardShiftState.lowercased
    
    var demoViewController: KeyboardViewController? {
        return inputViewController as? KeyboardViewController
    }
    
    
    // MARK: - Functions
    
    func animateButtonTap(for view: UIView) {
        (view as? KeyboardButton)?.animateStandardTap()
    }
    
    override func handleLongPress(on action: KeyboardAction, view: UIView) {
        animateButtonTap(for: view)
        switch action {
        case .shift: switchToAlphabeticKeyboard(.capsLocked)
        case .image: saveImage(for: action)
        default: super.handleLongPress(on: action, view: view)
        }
    }
    
    override func handleTap(on action: KeyboardAction, view: UIView) {
        animateButtonTap(for: view)
        super.handleTap(on: action, view: view)
        switch action {
        case .shift: switchToAlphabeticKeyboard(.uppercased)
        case .shiftDown: switchToAlphabeticKeyboard(.lowercased)
        case .character:
            if keyboardShiftState == .uppercased {
                switchToAlphabeticKeyboard(.lowercased)
            }
        case .switchToKeyboard(let type): demoViewController?.keyboardType = type
        default: copyImage(for: action)
        }
    }
}


// MARK: - Image Functions

@objc extension DemoKeyboardActionHandler {
    
    func handleImage(_ image: UIImage, didFinishSavingWithError error: Error?, contextInfo: UnsafeRawPointer) {
        if error == nil { alert("Saved!") }
        else { alert("Failed!") }
    }
}


// MARK: - Private Extensions

private extension DemoKeyboardActionHandler {
    
    func alert(_ message: String) {
        guard let input = inputViewController as? KeyboardViewController else { return }
        input.alerter.alert(message: message, in: input.view, withDuration: 4)
    }
    
    func copyImage(for action: KeyboardAction) {
        guard let image = image(for: action) else { return }
        guard let input = inputViewController as? KeyboardViewController else { return }
        guard input.hasFullAccess else { return alert("You must enable full access to copy images.") }
        guard image.copyToPasteboard() else { return alert("The image could not be copied.") }
        alert("Copied to pasteboard!")
    }
    
    func image(for action: KeyboardAction) -> UIImage? {
        switch action {
        case .image(_, _, let imageName): return UIImage(named: imageName)
        default: return nil
        }
    }
    
    func saveImage(for action: KeyboardAction) {
        guard let image = image(for: action) else { return }
        guard let input = inputViewController as? KeyboardViewController else { return }
        guard input.hasFullAccess else { return alert("You must enable full access to save images to photos.") }
        let saveCompletion = #selector(handleImage(_:didFinishSavingWithError:contextInfo:))
        image.saveToPhotos(completionTarget: self, completionSelector: saveCompletion)
    }
    
    func switchToAlphabeticKeyboard(_ state: KeyboardShiftState) {
        keyboardShiftState = state
        demoViewController?.keyboardType = .alphabetic(uppercased: state.isUppercased)
    }
}
