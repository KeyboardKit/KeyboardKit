//
//  MultilineTextField.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2020-06-08.
//  Copyright © 2020 Daniel Saidi. All rights reserved.
//

#if os(iOS)
import SwiftUI

/**
 This view wraps a `UITextView` and provides multi-line text
 editing with a specific keyboard appearance.
 */
public struct MultilineTextField: UIViewRepresentable {
    
    public init(
        text: Binding<String>,
        appearance: UIKeyboardAppearance = .default,
        configuration: @escaping Configuration = { _ in }
    ) {
        self._text = text
        self.appearance = appearance
        self.configuration = configuration
    }
    
    @Binding
    public var text: String
    
    private let appearance: UIKeyboardAppearance
    private let configuration: Configuration
    
    public typealias Configuration = (UITextView) -> Void

    public func makeUIView(context: Context) -> UITextView {
        let view = UITextView()
        view.backgroundColor = .clear
        view.font = .systemFont(ofSize: 20)
        view.isScrollEnabled = true
        view.isEditable = true
        view.isUserInteractionEnabled = true
        view.delegate = context.coordinator
        view.keyboardAppearance = appearance
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            view.becomeFirstResponder()
        }
        return view
    }
    
    public class Coordinator: NSObject, UITextViewDelegate {
        
        public init(text: Binding<String>) {
            self._text = text
        }
    
        @Binding
        public var text: String
        
        public func textViewDidChange(_ textView: UITextView) {
            text = textView.text
        }
    }
    
    public func makeCoordinator() -> Coordinator {
        Coordinator(text: $text)
    }

    public func updateUIView(_ uiView: UITextView, context: Context) {
        uiView.text = text
        configuration(uiView)
    }
}
#endif
