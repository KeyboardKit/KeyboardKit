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
        let services = Keyboard.Services.preview
        let context = state.keyboardContext
        context.colorScheme = .dark
        context.deviceType = .phone
        context.isLiquidGlassEnabled = true
        context.returnKeyTypeOverride = type
        // context.screenSize = .iPhoneLargeScreen
        // context.interfaceOrientation = .landscapeLeft
        services.styleService = .standard(keyboardContext: context)
        let device = context.deviceType
        let preview = device.isPad ? "iPad" : "iPhone"

        return Image(preview, bundle: .keyboardKit)
            .resizable()
            .aspectRatio(contentMode: .fill)
            .ignoresSafeArea(.all)
            .overlay(alignment: .bottom) {
                KeyboardView(
                    state: state,
                    services: services
                )
                .keyboardButtonStyle {
                    $0.standardStyle(for: context)
                }
                .padding(.bottom, 70)
                .background { Color.keyboardBackground }
                // .opacity(0.1)
            }
    }

    return VStack {
        preview(.done)
    }
}
