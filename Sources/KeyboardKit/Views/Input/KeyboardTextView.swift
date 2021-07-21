//
//  KeyboardTextView.swift
//  KeybaordKit
//
//  Created by Daniel Saidi on 2021-07-15.
//  Copyright © 2021 Daniel Saidi. All rights reserved.
//

import SwiftUI
import UIKit

/**
 This view can be used within a keyboard extension, when you
 want to provide a multi-line text view next to the keyboard
 and have that receive user input instead of the hosting app.
 
 The view will automatically register itself as an alternate
 proxy when it becomes first responder and unregister itself
 when it resigns first responder. This makes it receive user
 actions instead of the hosting app.
 
 `NOTE` that you must give this view a specific `height` for
 it to show up, otherwise it will collapse to zero height.
 */
public struct KeyboardTextView: UIViewRepresentable {
    
    /**
     Create a keyboard text view instance.
     
     - Parameters:
       - text: A text binding that will be affected by the text view.
       - resignOnReturn: Whether or not to resign first responder when return is pressed.
       - config: A configuration block that can be used to configure the text View.
     */
    public init(
        text: Binding<String>,
        resignOnReturn: Bool = true,
        config: @escaping ConfigAction = { _ in }) {
        self._text = text
        self.config = config
        self.resignOnReturn = resignOnReturn
    }
    
    @Binding private var text: String
    
    private let config: ConfigAction
    private let resignOnReturn: Bool
    
    public typealias ConfigAction = (UITextView) -> Void
    
    public func makeCoordinator() -> Coordinator {
        Coordinator(text: $text)
    }
    
    public func makeUIView(context: Context) -> UITextView {
        let view = KeyboardInputTextView()
        view.delegate = context.coordinator
        view.resignOnReturn = resignOnReturn
        config(view)
        return view
    }
    
    public func updateUIView(_ view: UITextView, context: Context) {
        view.text = text
    }
}

public extension KeyboardTextView {
    
    class Coordinator: NSObject, UITextViewDelegate {
        
        init(text: Binding<String>) {
            _text = text
        }
        
        @Binding private var text: String

        public func textViewDidChange(_ textView: UITextView) {
            text = textView.text
        }
    }
}

class KeyboardInputTextView: UITextView, KeyboardInputTextComponent {
    
    var resignOnReturn: Bool = true
    
    override func insertText(_ text: String) {
        guard handleInsertText(text) else { return }
        super.insertText(text)
    }
    
    override func becomeFirstResponder() -> Bool {
        handleBecomeFirstResponder()
        return super.becomeFirstResponder()
    }
    
    @discardableResult
    override func resignFirstResponder() -> Bool {
        handleResignFirstResponder()
        return super.resignFirstResponder()
    }
}
