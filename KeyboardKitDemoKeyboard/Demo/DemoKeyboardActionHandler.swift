//
//  DemoKeyboardActionHandler.swift
//  KeyboardKitDemoKeyboard
//
//  Created by Daniel Saidi on 2019-04-24.
//  Copyright © 2021 Daniel Saidi. All rights reserved.
//

import KeyboardKit
import UIKit

/**
 This action handler inherits `StandardKeyboardActionHandler`
 and adds `UIKit` demo-specific functionality to it.
 */
class DemoKeyboardActionHandler: StandardKeyboardActionHandler {
    
    
    // MARK: - Overrides
    
    override func longPressAction(for action: KeyboardAction, sender: Any?) -> GestureAction? {
        switch action {
        case .image(_, _, let imageName): return { [weak self] in self?.saveImage(UIImage(named: imageName)!) }
        default: return super.longPressAction(for: action, sender: sender)
        }
    }
    
    override func tapAction(for action: KeyboardAction, sender: Any?) -> GestureAction? {
        switch action {
        case .emojiCategory(let cat): return { [weak self] in self?.switchToEmojiKeyboardCategory(cat) }
        case .image(_, _, let imageName): return { [weak self] in self?.copyImage(UIImage(named: imageName)!) }
        default: return super.tapAction(for: action, sender: sender)
        }
    }
    
    
    // MARK: - Functions
    
    /**
     Override this function to implement a way to alert text
     messages in the keyboard extension. You can't use logic
     that you use in real apps, e.g. `UIAlertController`.
     */
    func alert(_ message: String) {
        guard let input = inputViewController as? KeyboardViewController else { return }
        input.alerter.alert(message: message, in: input.view, withDuration: 4)
    }
    
    func copyImage(_ image: UIImage) {
        guard let input = inputViewController else { return }
        guard input.hasFullAccess else { return alert("You must enable full access to copy images.") }
        guard image.copyToPasteboard() else { return alert("The image could not be copied.") }
        alert("Copied to pasteboard!")
    }
    
    func saveImage(_ image: UIImage) {
        guard let input = inputViewController else { return }
        guard input.hasFullAccess else { return alert("You must enable full access to save images.") }
        let saveCompletion = #selector(handleImage(_:didFinishSavingWithError:contextInfo:))
        image.saveToPhotos(completionTarget: self, completionSelector: saveCompletion)
    }


    // MARK: - Image Functions

    @objc func handleImage(_ image: UIImage, didFinishSavingWithError error: Error?, contextInfo: UnsafeRawPointer) {
        if error == nil { alert("Saved!") }
        else { alert("Failed!") }
    }
}

private extension DemoKeyboardActionHandler {
    
    func switchToEmojiKeyboardCategory(_ cat: EmojiCategory) {
        guard
            let vc = inputViewController as? KeyboardViewController,
            let view = vc.emojiCollectionView
            else { return }
        view.moveToSection(byCategory: cat.title)
    }
}

private extension UIImage {
    
    func saveToPhotos(completionTarget: AnyObject?, completionSelector: Selector?) {
        UIImageWriteToSavedPhotosAlbum(self, completionTarget, completionSelector, nil)
    }
    
    func saveToPhotos(completion: @escaping (Error?) -> Void) {
        let service = StandardPhotosImageService()
        service.saveImageToPhotos(self, completion: completion)
    }
}

private class StandardPhotosImageService: NSObject {
    
    public typealias Completion = (Error?) -> Void

    private var completions = [Completion]()
    
    public func saveImageToPhotos(_ image: UIImage, completion: @escaping (Error?) -> Void) {
        completions.append(completion)
        image.saveToPhotos(completionTarget: self, completionSelector: #selector(didSave(_:error:contextInfo:)))
    }
    
    @objc func didSave(_ image: UIImage, error: NSError?, contextInfo: UnsafeRawPointer) {
        guard completions.count > 0 else { return }
        completions.removeFirst()(error)
    }
}
