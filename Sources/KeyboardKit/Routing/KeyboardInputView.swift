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
 be able to add a done button that makes them lose focus.

 You can add a custom done button to any `KeyboardInputView`
 by using the custom `focused` modifier, that takes a custom
 view builder, like this:

 ```swift
 KeyboardTextView(...)
     .focused($hasFocus) {
         Image(systemName: "x.circle.fill")
     }
 ```

 Note that you must add this custom `focused` modifier first.
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
