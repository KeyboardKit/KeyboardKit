//
//  DemoKeyboardActionHandler.swift
//  KeyboardKitExampleKeyboard
//
//  Created by Daniel Saidi on 2019-04-24.
//  Copyright © 2019 Daniel Saidi. All rights reserved.
//

import KeyboardKit

class DemoKeyboardActionHandler: StandardKeyboardActionHandler {
    
    var demoViewController: KeyboardViewController? {
        return inputViewController as? KeyboardViewController
    }
    
    override func handleLongPress(on view: UIView, action: KeyboardAction) {
        super.handleLongPress(on: view, action: action)
        saveImage(for: action)
    }
    
    override func handleTap(on view: UIView, action: KeyboardAction) {
        super.handleTap(on: view, action: action)
        switch action {
        case .shift: demoViewController?.keyboardMode = .uppercased
        case .switchToAlphabeticKeyboard: demoViewController?.keyboardMode = .alphabetic
        case .switchToNumericKeyboard: demoViewController?.keyboardMode = .numeric
        case .switchToSymbolicKeyboard: demoViewController?.keyboardMode = .symbolic
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
