//
//  KeyboardView+StylePreview.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2025-07-28.
//  Copyright © 2025 Daniel Saidi. All rights reserved.
//

import SwiftUI

#Preview {

    func preview(
        _ type: Keyboard.ReturnKeyType
    ) -> some View {
        let state = Keyboard.State.preview
        let context = state.keyboardContext
        context.isLiquidGlassEnabled = true
        context.deviceType = .phone
        context.returnKeyTypeOverride = type
        context.screenSize = .iPhoneLargeScreen
        // context.interfaceOrientation = .landscapeLeft
        let device = context.deviceType
        let preview = device.isPad ? "iPad" : "iPhone"

        return Image(preview, bundle: .module)
            .resizable()
            .aspectRatio(contentMode: .fill)
            .ignoresSafeArea(.all)
            .overlay(alignment: .bottom) {
                KeyboardView(
                    state: state,
                    services: .preview
                )
                .padding(.bottom, 90)
                //.padding(.horizontal, 93)
                // .padding(.bottom, -2)
                // .padding(.leading, 6)
            }
    }

    return VStack {
        preview(.done)
    }
}
