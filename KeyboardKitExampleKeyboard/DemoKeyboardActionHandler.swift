//
//  DemoKeyboardActionHandler.swift
//  KeyboardKitExampleKeyboard
//
//  Created by Daniel Saidi on 2019-04-24.
//  Copyright © 2019 Daniel Saidi. All rights reserved.
//

import KeyboardKit

class DemoKeyboardActionHandler: StandardKeyboardActionHandler {
    
    override func handleLongPress(on action: KeyboardAction) {
        super.handleLongPress(on: action)
        guard let image = image(for: action) else { return }
        guard let input = inputViewController as? KeyboardViewController else { return }
        guard input.hasFullAccess else { return alert("You must enable full access to save images to photos.") }
        let saveCompletion = #selector(handleImage(_:didFinishSavingWithError:contextInfo:))
        image.saveToPhotos(completionTarget: self, completionSelector: saveCompletion)
    }
    
    override func handleTap(on action: KeyboardAction) {
        super.handleTap(on: action)
        guard let image = image(for: action) else { return }
        guard let input = inputViewController as? KeyboardViewController else { return }
        guard input.hasFullAccess else { return alert("You must enable full access to copy images.") }
        guard image.copyToPasteboard() else { return alert("The image could not be copied.") }
        alert("Copied to pasteboard!")
    }
}

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
    
    func image(for action: KeyboardAction) -> UIImage? {
        switch action {
        case .image(_, _, let imageName): return UIImage(named: imageName)
        default: return nil
        }
    }
}
