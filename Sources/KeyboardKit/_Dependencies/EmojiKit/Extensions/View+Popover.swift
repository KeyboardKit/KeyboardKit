//
//  View+Popover.swift
//  EmojiKit
//
//  Created by Daniel Saidi on 2023-12-14.
//  Copyright © 2023-2024 Daniel Saidi. All rights reserved.
//

import SwiftUI

extension View {
    
    @ViewBuilder
    func popoverIfAvailable<Popover: View>(
        _ isPresented: Binding<Bool>,
        @ViewBuilder view: @escaping () -> Popover
    ) -> some View {
        #if os(iOS) || os(macOS)
        if #available(iOS 16.4, macOS 12, *) {
            self.popover(isPresented: isPresented) {
                view().popoverSizeIfAvailable()
            }
        } else {
            self
        }
        #else
        self
        #endif
    }
    
    @ViewBuilder
    func popoverSizeIfAvailable() -> some View {
        #if os(iOS)
        if #available(iOS 16.4, macOS 12, *) {
            self.presentationCompactAdaptation(.none)
        } else {
            self
        }
        #else
        self
        #endif
    }
}
