//
//  View+KeyboardToast.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2020-02-20.
//  Copyright © 2021 Daniel Saidi. All rights reserved.
//

import SwiftUI

public extension View {
    
    /**
     Present a centered toast, using a custom `content` view
     and a custom `background`.
     */
    func keyboardToast<Content: View, Background: View>(
        isActive: Binding<Bool>,
        content: Content,
        background: Background,
        duration: TimeInterval = 2) -> some View {
        KeyboardToast(
            isActive: isActive,
            content: content,
            background: background,
            duration: duration,
            presenter: { self }
        )
    }
    
    /**
     Present a centered toast, using a custom `content` view
     and a custom `background`.
     */
    func keyboardToast<Background: View>(
        context: KeyboardToastContext,
        background: Background,
        duration: TimeInterval = 2) -> some View {
        KeyboardToast(
            isActive: context.isActiveBinding,
            content: context.content,
            background: background,
            duration: duration,
            presenter: { self }
        )
    }
}
