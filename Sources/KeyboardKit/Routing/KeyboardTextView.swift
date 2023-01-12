//
//  KeyboardTextView.swift
//  KeybaordKit
//
//  Created by Daniel Saidi on 2021-07-15.
//  Copyright © 2021 Daniel Saidi. All rights reserved.
//

#if os(iOS) || os(tvOS)
import SwiftUI
import UIKit

/**
 This view can be used when you want to have multi-line text
 input in a keyboard extension, and the input should receive
 the text that is typed on the keyboard.
 
 The view will automatically register itself as an alternate
 proxy when it becomes first responder and unregister itself
 when it resigns as the first responder.

 > Note: You can't use `resignFirstResponder` to end editing.
 Instead, bind a standard SwiftUI `FocusedState` to the view
 and set it to false to end editing.

 ```
 struct MyView: View {

     @State
     private var text = ""

     @FocusState
     private var isEditing: Bool

     var body: some View {
         KeyboardTextView(text: $text)
             .isFocused(isEditing)
     }

     func endEditing() {
         isEditing = false
     }
 }
 ```
 */
public struct KeyboardTextView: UIViewRepresentable {
    
    /**
     Create a keyboard text view instance.
     
     - Parameters:
       - text: A text binding that will be affected by the text view.
       - hasFocus: A binding to communicate whether or not the text field has focus, by default `.constant(false)`.       
       - resignOnReturn: Whether or not to resign first responder when return is pressed, by default `true`.
       - config: A configuration block that can be used to configure the text view, by default an empty configuration.
     */
    public init(
        text: Binding<String>,
        hasFocus: Binding<Bool> = .constant(false),
        resignOnReturn: Bool = true,
        config: @escaping Configuration = { _ in }
    ) {
        self._text = text
        self._hasFocus = hasFocus
        self.resignOnReturn = resignOnReturn
        self.config = config
    }
    
    
    /**
     This typealias represents a `UITextView` configuration.
     */
    public typealias Configuration = (UITextView) -> Void
    
    @Binding
    private var text: String

    @Binding
    private var hasFocus: Bool
    
    private let config: Configuration
    private let resignOnReturn: Bool
    
    
    public func makeCoordinator() -> Coordinator {
        Coordinator(text: $text)
    }
    
    public func makeUIView(context: Context) -> UITextView {
        let view = KeyboardInputTextView()
        view.delegate = context.coordinator
        view.hasFocus = $hasFocus
        view.resignOnReturn = resignOnReturn
        view.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
        config(view)
        return view
    }
    
    public func updateUIView(_ view: UITextView, context: Context) {
        view.text = text
    }
}

public extension KeyboardTextView {

    /**
     This coordinator is used to keep the views in sync when
     the text changes in the embedded text view.
     */
    class Coordinator: NSObject, UITextViewDelegate {
        
        init(text: Binding<String>) {
            _text = text
        }
        
        @Binding
        private var text: String

        public func textViewDidChange(_ textView: UITextView) {
            text = textView.text
        }
    }
}

class KeyboardInputTextView: UITextView, KeyboardInputComponent {
    
    var resignOnReturn: Bool = true
    var hasFocus: Binding<Bool> = .constant(false)
    
    override func insertText(_ text: String) {
        guard handleInsertText(text) else { return }
        super.insertText(text)
    }
    
    override func becomeFirstResponder() -> Bool {
        hasFocus.wrappedValue = true
        handleBecomeFirstResponder()
        return super.becomeFirstResponder()
    }
    
    @discardableResult
    override func resignFirstResponder() -> Bool {
        hasFocus.wrappedValue = false
        handleResignFirstResponder()
        return super.resignFirstResponder()
    }
}
#endif
