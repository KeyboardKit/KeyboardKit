//
//  KeyboardView.swift
//  KeyboardKitDemo
//
//  Created by Daniel Saidi on 2020-06-10.
//  Copyright © 2021 Daniel Saidi. All rights reserved.
//

import KeyboardKit
import SwiftUI

/**
 This view is the main view that is used by the extension by
 calling `setup(with:)` in `KeyboardViewController`.
 
 The view must observe ``KeyboardContext`` either through an
 environment object as below or by injecting an instance and
 binding it to an observerd object (commented out). Otherwise
 to ensure that changes in
 the context do trigger updates in the view.
 */
struct KeyboardView: View {
    
    /*
    init(context: KeyboardContext) {
       _context = ObservedObject(wrappedValue: context)
    }
    */
    
    @State private var text = "Text"
    
    // @ObservedObject private var context: KeyboardContext
    
    @EnvironmentObject private var context: KeyboardContext
    
    var body: some View {
        VStack(spacing: 0) {
            if context.keyboardType != .emojis {
                DemoAutocompleteToolbar()
            }
            SystemKeyboard()
        }
    }
}


// MARK: - Private Views

private extension KeyboardView {
    
    var textField: some View {
        KeyboardTextField(text: $text) {
            $0.placeholder = "Try typing here, press return to stop."
            $0.borderStyle = .roundedRect
            $0.autocapitalizationType = .sentences
        }.padding(3)
    }
}
