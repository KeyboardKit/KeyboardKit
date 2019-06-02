//
//  DemoKeyboardActionHandler.swift
//  KeyboardKitExampleKeyboard
//
//  Created by Daniel Saidi on 2019-04-24.
//  Copyright © 2019 Daniel Saidi. All rights reserved.
//

/*
 
 This action handler inherits `StandardKeyboardActionHandler`
 and adds demo-specific functionality to it.
 
 */

import KeyboardKit

class DemoKeyboardActionHandler: StandardKeyboardActionHandler {
    
    enum ShiftState {
        case
        normal,
        uppercased,
        capsLock
    }
    
    var keyboardShiftState = ShiftState.normal
    
    var isUppercased: Bool {
        switch keyboardShiftState {
        case .normal:
            return false
        case .uppercased, .capsLock:
            return true
        }
    }
    
    var demoViewController: KeyboardViewController? {
        return inputViewController as? KeyboardViewController
    }
    
    func animateButtonTap(for view: UIView) {
        (view as? KeyboardButton)?.animateStandardTap()
    }
    
    override func handleLongPress(on action: KeyboardAction, view: UIView) {
        animateButtonTap(for: view)
        switch action {
        case .shift:
            keyboardShiftState = .capsLock
            demoViewController?.keyboardType = .alphabetic(uppercased: isUppercased)
        case .image: saveImage(for: action)
        default: super.handleLongPress(on: action, view: view)
        }
    }
    
    override func handleTap(on action: KeyboardAction, view: UIView) {
        animateButtonTap(for: view)
        super.handleTap(on: action, view: view)
        switch action {
        case .shift:
            keyboardShiftState = .uppercased
            demoViewController?.keyboardType = .alphabetic(uppercased: isUppercased)
        case .shiftDown:
            keyboardShiftState = .normal
            demoViewController?.keyboardType = .alphabetic(uppercased: isUppercased)
        case .character:
            // shift key only works for next character, then back to regular
            if keyboardShiftState == .uppercased {
                keyboardShiftState = .normal
                demoViewController?.keyboardType = .alphabetic(uppercased: isUppercased)
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
}
