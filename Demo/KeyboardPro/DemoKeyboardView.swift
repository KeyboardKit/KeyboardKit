//
//  DemoKeyboardView.swift
//  KeyboardPro
//
//  Created by Daniel Saidi on 2022-02-04.
//  Copyright © 2022-2024 Daniel Saidi. All rights reserved.
//

import KeyboardKitPro
import SwiftUI

/// This demo-specific keyboard view uses a `SystemKeyboard`
/// as the keyboard view and customizes it with Pro features.
///
/// This view shows you how to customize the system keyboard,
/// by returning `$0.view` where the default views should be
/// used, or return custom views. This view will replace the
/// default toolbar with a Pro toggle toolbar.
///
/// > Important: When you customize your view, you must make
/// it observe the `KeyboardContext`. If you don't, the view
/// will not detect any changes in the context, and will not
/// update itself.
struct DemoKeyboardView: View {
    
    unowned var controller: KeyboardInputViewController
    
    @State
    private var theme: KeyboardTheme?
    
    @EnvironmentObject
    private var keyboardContext: KeyboardContext
    
    var body: some View {
        SystemKeyboard(
            state: controller.state,
            services: keyboardServices,
            buttonContent: { $0.view },
            buttonView: { $0.view },
            emojiKeyboard: { $0.view },
            toolbar: { params in
                try? Keyboard.ToggleToolbar(
                    toolbar: params.view,
                    toggledToolbar: DemoToolbar(
                        controller: controller,
                        theme: $theme,
                        proxy: controller.state.keyboardContext.textDocumentProxy
                    )
                )
                .foregroundColor(params.style.item.titleColor)
            }
        )
    }
}

private extension DemoKeyboardView {
    
    var keyboardServices: Keyboard.Services {
        let services = controller.services
        if let theme {
            if let provider = try? KeyboardStyle.ThemeBasedProvider(
                theme: theme,
                keyboardContext: controller.state.keyboardContext
            ) {
                services.styleProvider = provider
            }
        }
        return services
    }
}
