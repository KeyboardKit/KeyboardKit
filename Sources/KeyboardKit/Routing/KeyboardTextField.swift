//
//  KeyboardTextField.swift
//  KeybaordKit
//
//  Created by Daniel Saidi on 2021-07-15.
//  Copyright © 2021-2023 Daniel Saidi. All rights reserved.
//

#if os(iOS) || os(tvOS)
import SwiftUI
import UIKit

/**
 This text field can be used within a keyboard extension.

 The text field will automatically register itself to become
 ``KeyboardInputViewController/textInputProxy`` when it gets
 focus and will also automatically unregister itself when it
 loses focus.

 You can provide a custom `config` function to customize the
 underlying `UITextField`.

 Note that you must use `FocusedState` to handle focus state:

 ```
 struct MyView: View {

     @State
     private var text = ""

     @FocusState
     private var isEditing: Bool

     var body: some View {
         HStack(spacing: 0) {
             KeyboardTextField(text: $text)
                 .focused($isEditing)
             Button("x", action: endEditing)
         }
     }

     func endEditing() {
         withAnimation {
             isEditing = false
         }
     }
 }
 ```

 If you set `resignOnReturn` to `true`, this text field will
 resign as first responder when return is tapped, which will
 return focus to the main app. If you set it to `false`, you
 will have to provide manually handle the focus state.
 */
public struct KeyboardTextField: UIViewRepresentable, KeyboardInputView {
    
    /**
     Create a keyboard text field instance.
     
     - Parameters:
       - placeholder: An optional placeholder text to show when the text field is empty, by default `nil`.
       - text: A text binding that will be affected by the text field.
       - controller: The keyboard input view controller to affect.
       - hasFocus: A binding to communicate whether or not the text field has focus, by default `.constant(false)`.
       - resignOnReturn: Whether or not to resign first responder when return is pressed, by default `true`.
       - config: A configuration block that can be used to configure the text field, by default an empty configuration.
     */
    public init(
        _ placeholder: String? = nil,
        text: Binding<String>,
        controller: KeyboardInputViewController,
        hasFocus: Binding<Bool> = .constant(false),
        resignOnReturn: Bool = true,
        config: @escaping Configuration = { _ in }
    ) {
        self.placeholder = placeholder
        self._text = text
        self.controller = controller
        self._hasFocus = hasFocus
        self.resignOnReturn = resignOnReturn
        self.config = config
    }

    
    /**
     This typealias represents a `UITextField` configuration.
     */
    public typealias Configuration = (UITextField) -> Void


    private weak var controller: KeyboardInputViewController?

    @Binding
    private var text: String

    @Binding
    private var hasFocus: Bool
    
    private let placeholder: String?

    private let config: Configuration

    private let resignOnReturn: Bool

    public func makeCoordinator() -> Coordinator {
        Coordinator(text: $text)
    }
    
    public func makeUIView(context: Context) -> UITextField {
        let view = KeyboardInputTextField()
        view.controller = controller
        view.placeholder = placeholder
        view.addTarget(context.coordinator, action: #selector(context.coordinator.textFieldDidChange), for: .editingChanged)
        view.hasFocus = $hasFocus
        view.resignOnReturn = resignOnReturn
        view.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
        configureUIView(view)
        return view
    }

    public func configureUIView(_ view: UITextField) {
        #if os(iOS) || os(macOS) || os(watchOS)
        view.backgroundColor = .systemBackground
        #endif
        view.borderStyle = .roundedRect
        config(view)
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
        
        @Binding
        private var text: String

        @objc public func textFieldDidChange(_ textField: UITextField) {
            text = textField.text ?? ""
        }
    }
}

class KeyboardInputTextField: UITextField, KeyboardInputComponent {

    weak var controller: KeyboardInputViewController?
    
    var resignOnReturn: Bool = true
    var hasFocus: Binding<Bool> = .constant(false)

    override func insertText(_ text: String) {
        guard handleInsertText(text) else { return }
        super.insertText(text)
    }

    override func becomeFirstResponder() -> Bool {
        withAnimation {
            hasFocus.wrappedValue = true
        }
        handleBecomeFirstResponder()
        return super.becomeFirstResponder()
    }

    @discardableResult
    override func resignFirstResponder() -> Bool {
        withAnimation {
            hasFocus.wrappedValue = false
        }
        handleResignFirstResponder()
        return super.resignFirstResponder()
    }
}
#endif
