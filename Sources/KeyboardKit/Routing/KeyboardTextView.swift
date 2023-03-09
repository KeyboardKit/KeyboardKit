//
//  KeyboardTextView.swift
//  KeybaordKit
//
//  Created by Daniel Saidi on 2021-07-15.
//  Copyright © 2021-2023 Daniel Saidi. All rights reserved.
//

#if os(iOS) || os(tvOS)
import SwiftUI
import UIKit

/**
 This text view can be used within a keyboard extension.

 This text view will automatically register itself to become
 ``KeyboardInputViewController/textInputProxy`` when it gets
 focus and will also automatically unregister itself when it
 loses focus.

 You can provide a custom `config` function to customize the
 underlying `UITextView`.

 Note that you must use `FocusedState` to handle focus state: 

 ```
 struct MyView: View {

     @State
     private var text = ""

     @FocusState
     private var isEditing: Bool

     var body: some View {
         HStack(spacing: 0) {
             KeyboardTextView(text: $text)
                 .focused($isEditing)
             Button("x", action: endEditing)
         }
     }

     func endEditing() {
         isEditing = false
     }
 }
 ```
 */
public struct KeyboardTextView: UIViewRepresentable, KeyboardInputView {
    
    /**
     Create a keyboard text view instance.
     
     - Parameters:
       - text: A text binding that will be affected by the text view.
       - controller: The keyboard input view controller to affect.
       - hasFocus: A binding to communicate whether or not the text field has focus, by default `.constant(false)`.       
       - resignOnReturn: Whether or not to resign first responder when return is pressed, by default `false`.
       - config: A configuration block that can be used to configure the text view, by default an empty configuration.
     */
    public init(
        text: Binding<String>,
        controller: KeyboardInputViewController,
        hasFocus: Binding<Bool> = .constant(false),
        resignOnReturn: Bool = false,
        config: @escaping Configuration = { _ in }
    ) {
        self._text = text
        self.controller = controller
        self._hasFocus = hasFocus
        self.resignOnReturn = resignOnReturn
        self.config = config
    }
    
    
    /**
     This typealias represents a `UITextView` configuration.
     */
    public typealias Configuration = (UITextView) -> Void


    private weak var controller: KeyboardInputViewController?
    
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
        view.controller = controller
        view.hasFocus = $hasFocus
        view.resignOnReturn = resignOnReturn
        view.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
        configureUIView(view)
        return view
    }

    public func configureUIView(_ view: UITextView) {
        #if os(iOS) || os(macOS) || os(watchOS)
        view.backgroundColor = .systemBackground
        #endif
        view.font = UITextField().font
        view.layer.cornerRadius = 5
        config(view)
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

    weak var controller: KeyboardInputViewController?

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
