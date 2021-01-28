//
//  KeyboardToast.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2020-03-05.
//  Copyright © 2021 Daniel Saidi. All rights reserved.
//

import SwiftUI

/**
 A `KeyboardToast` is a brief overlay with a custom `content`
 and `background`. It is intended to present information for
 a short while, then hide itself.
 
 The easiest and preferred way to add a `Toast` to a `View`,
 is to use the `keyboardToast(...)` view modifier.
 */
public struct KeyboardToast<Presenter: View, Content: View, Background: View>: View {
    
    public init(
        isActive: Binding<Bool>,
        content: Content,
        background: Background,
        duration: TimeInterval,
        @ViewBuilder presenter: @escaping(() -> Presenter)) {
        self._isActive = isActive
        self.content = content
        self.background = background
        self.duration = duration
        self.presenter = presenter
    }

    @Binding var isActive: Bool
    
    public let content: Content
    public let background: Background
    public let duration: TimeInterval
    public let presenter: () -> Presenter
    
    public var body: some View {
        if isActive { hide(after: duration) }
        return ZStack(alignment: .center) {
            presenter()
            content
                .padding()
                .background(background)
                .opacity(isActive ? 1 : 0)
        }
    }
}

private extension KeyboardToast {
    
    func hide(after seconds: TimeInterval) {
        DispatchQueue.main.asyncAfter(deadline: .now() + seconds) {
            withAnimation { self.isActive = false }
        }
    }
}
