//
//  DemoKeyboardView.swift
//  KeyboardPro
//
//  Created by Daniel Saidi on 2022-02-04.
//  Copyright © 2022-2023 Daniel Saidi. All rights reserved.
//

import KeyboardKitPro
import SwiftUI

/**
 This view uses a `SystemKeyboard` as the keyboard view, and
 customizes it with some Pro features.
 
 Note that `setup` and `setupPro` will use a `SystemKeyboard`
 by default. This demo customizes it a bit, to show how this
 is done. Just return `$0.view` in the `SystemKeyboard` view
 builders, if you just want to use the default view.
 
 > Important: When you customize your view, you need to make
 it observe the `KeyboardContext` in the environment. If you
 don't, this view will not detect any changes in the context
 and will not update itself.
 */
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
                try? ToggleToolbar.init(
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
    
    var keyboardServices: Keyboard.KeyboardServices {
        let services = controller.services
        if let theme {
            if let provider = try? ThemeBasedKeyboardStyleProvider(
                theme: theme,
                keyboardContext: controller.state.keyboardContext
            ) {
                services.styleProvider = provider
            }
        }
        return services
    }
}
