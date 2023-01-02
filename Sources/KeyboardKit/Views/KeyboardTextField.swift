//
//  KeyboardTextField.swift
//  KeybaordKit
//
//  Created by Daniel Saidi on 2021-07-15.
//  Copyright © 2021 Daniel Saidi. All rights reserved.
//

#if os(iOS) || os(tvOS)
import SwiftUI
import UIKit

/**
 This view can be used when you want to have a text field in
 a keyboard extension, and the text field should receive the
 text that is typed on the keyboard.
 
 The view will automatically register itself as an alternate
 proxy when it becomes first responder and unregister itself
 when it resigns as the first responder.
 */
public struct KeyboardTextField: UIViewRepresentable {
    
    /**
     Create a keyboard text field instance.
     
     - Parameters:
       - placeholder: An optional placeholder text to show when the text field is empty, by default `nil`.
       - text: A text binding that will be affected by the text field.
       - hasFocus: A binding to communicate whether or not the text field has focus, by default `.constant(false)`.
       - resignOnReturn: Whether or not to resign first responder when return is pressed, by default `true`.
       - config: A configuration block that can be used to configure the text field, by default an empty configuration.
     */
    public init(
        _ placeholder: String? = nil,
        text: Binding<String>,
        hasFocus: Binding<Bool> = .constant(false),
        resignOnReturn: Bool = true,
        config: @escaping ConfigAction = { _ in }
    ) {
        self.placeholder = placeholder
        self._text = text
        self._hasFocus = hasFocus
        self.config = config
        self.resignOnReturn = resignOnReturn
    }
    
    
    /**
     This typealias represents the configuration action that
     will be used to customize the embedded `UITextField`.
     */
    public typealias ConfigAction = (UITextField) -> Void
    
    @Binding
    private var text: String

    @Binding
    private var hasFocus: Bool
    
    private let placeholder: String?
    private let config: ConfigAction
    private let resignOnReturn: Bool
    
    
    public func makeCoordinator() -> Coordinator {
        Coordinator(text: $text)
    }
    
    public func makeUIView(context: Context) -> UITextField {
        let view = KeyboardInputTextField()
        view.placeholder = placeholder
        view.addTarget(context.coordinator, action: #selector(context.coordinator.textFieldDidChange), for: .editingChanged)
        view.resignOnReturn = resignOnReturn
        view.hasFocus = $hasFocus
        view.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
        config(view)
        return view
    }
    
    public func updateUIView(_ view: UITextField, context: Context) {
        view.text = text
    }
}

public extension KeyboardTextField {
    
    /**
     This coordinator is used to keep the views in sync when
     the text changes in the embedded text field.
     */
    class Coordinator: NSObject {
        
        init(text: Binding<String>) {
            _text = text
        }
        
        @Binding private var text: String

        @objc public func textFieldDidChange(_ textField: UITextField) {
            text = textField.text ?? ""
        }
    }
}

class KeyboardInputTextField: UITextField, KeyboardInputComponent {
    
    var resignOnReturn: Bool = true
    var hasFocus: Binding<Bool> = .constant(false)
    
    override func becomeFirstResponder() -> Bool {
        hasFocus.wrappedValue = true
        handleBecomeFirstResponder()
        return super.becomeFirstResponder()
    }
    
    override func insertText(_ text: String) {
        guard handleInsertText(text) else { return }
        super.insertText(text)
    }
    
    @discardableResult
    override func resignFirstResponder() -> Bool {
        hasFocus.wrappedValue = false
        handleResignFirstResponder()
        return super.resignFirstResponder()
    }
}
#endif
