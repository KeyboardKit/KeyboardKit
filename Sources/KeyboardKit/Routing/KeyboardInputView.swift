//
//  KeyboardInputView.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2023-03-09.
//  Copyright © 2023 Daniel Saidi. All rights reserved.
//

import SwiftUI

/**
 This protocol can be implemented by input views that should
 be used to insert text within a keyboard extension.

 You can add a custom done button to any `KeyboardInputView`
 by using its custom `focused` modifier, that takes a custom
 view builder, like this:

 ```swift
 KeyboardTextView(...)
     .focused($hasFocus) {
         Image(systemName: "x.circle.fill")
     }
 ```

 This will cause the text input view to slide in this button
 whenever the view gets focus. Tapping the button will cause
 the view to lose focus and resign as the first responder.

 Note that you must add this custom `focused` modifier first
 in the chain of modifiers.
 */
public protocol KeyboardInputView: View {}

@available(iOS 15.0, macOS 12.0, tvOS 15.0, watchOS 9.0, *)
public extension KeyboardInputView {

    /**
     Apply a `FocusState` together with a custom `doneButton`
     that automatically appears when the view gets focus and
     removes focus when it's tapped.
     */
    @ViewBuilder
    func focused<DoneButton: View>(
        _ value: FocusState<Bool>.Binding,
        @ViewBuilder doneButton: @escaping () -> DoneButton
    ) -> some View {
        HStack(spacing: 0) {
            self
                .focused(value, equals: true)
                .animation(.default, value: value.wrappedValue)

            Button {
                value.wrappedValue = false
            } label: {
                doneButton()
            }
            .frame(width: value.wrappedValue ? nil : 0)
            .clipped()
            .padding(.horizontal, value.wrappedValue ? 3 : 0)
            .animation(.default, value: value.wrappedValue)
        }
    }
}
