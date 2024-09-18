//
//  DemoKeyboardView.swift
//  KeyboardPro
//
//  Created by Daniel Saidi on 2022-02-04.
//  Copyright © 2022-2024 Daniel Saidi. All rights reserved.
//

import KeyboardKitPro
import SwiftUI

/// This demo-specific keyboard view sets up a `KeyboardView`
/// as the keyboard view and customizes it with Pro features.
///
/// The view shows how to customize the keyboard view, where
/// you return `$0.view` (or `params in params.view`) to use
/// the default component view, or return a custom view that
/// you want to replace the default one with.
///
/// This view replaces the default toolbar with a Pro toggle
/// toolbar that lets users toggle between two toolbars.
struct DemoKeyboardView: View {

    /// This is (for now) required by the ``DemoToolbar``.
    unowned var controller: KeyboardInputViewController

    @State
    private var theme: KeyboardTheme?

    var body: some View {
        KeyboardView(
            state: controller.state,
            services: keyboardServices,
            buttonContent: { $0.view },
            buttonView: { $0.view },
            emojiKeyboard: { $0.view },
            toolbar: { params in    // <- All view builders has parameters with more information
                DemoToolbar(
                    controller: controller,
                    toolbar: params.view,
                    theme: $theme
                )
            }
        )
    }
}

private extension DemoKeyboardView {

    var keyboardServices: Keyboard.Services {
        let services = controller.services
        if let theme {
            if let service = try? KeyboardStyle.ThemeBasedService(
                theme: theme,
                keyboardContext: controller.state.keyboardContext
            ) {
                services.styleService = service
            }
        }
        return services
    }
}
