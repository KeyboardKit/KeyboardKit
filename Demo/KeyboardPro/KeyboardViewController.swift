//
//  KeyboardViewController.swift
//  KeyboardPro
//
//  Created by Daniel Saidi on 2023-02-13.
//  Copyright © 2023-2024 Daniel Saidi. All rights reserved.
//

import KeyboardKitPro
import SwiftUI

/// This keyboard demonstrates how to set up KeyboardKit Pro
/// with a `KeyboardApp`, then customize the standard config.
///
/// To use the keyboard, simply enable it in System Settings,
/// then switch to it with the 🌐 key when typing in any app.
///
/// See ``DemoApp`` for important, demo-specific information.
class KeyboardViewController: KeyboardInputViewController {

    /// This function is called when the controller launches.
    /// Use it to set up your keyboard.
    ///
    /// Below, we make demo-specific keyboard configurations.
    /// Play around with them to see how it affects the demo.
    override func viewDidLoad() {

        /// 💡 Call super to perform the base initialization.
        super.viewDidLoad()

        /// ‼️ Set up keyboard features like settings, dictation, etc.
        super.setupPro(for: .demoApp) { result in

            /// 💡 Make demo-specific configurations.
            self.setupDemoServices(extraKey: .emojiIfNeeded)
            self.setupDemoState()

            /// 💡 Set up a theme-based style service.
            ///
            /// This is throwing since themes need a license.
            self.services.styleService = (try? .themeBased(
                theme: .standard,
                keyboardContext: self.state.keyboardContext
            )) ?? self.services.styleService
        }

        /// 🧪 Enable this to test the experimental keyboard
        /// switcher mode. To try it, use `.keyboardSwitcher`
        /// as extra key above.
        /// Read more at https://github.com/KeyboardKit/KeyboardKit/issues/799
        // Keyboard.NextKeyboardButtonControllerMode.current = .experimentalNilTarget
        // Keyboard.NextKeyboardButtonProxyMode.current = .experimental
    }

    /// This function is called when the controller needs to
    /// create or update the keyboard view.
    ///
    /// Below, we make demo-specific keyboard configurations.
    /// Play around with them to see how it affects the demo.
    ///
    /// 💡 You don't need to override this function when you
    /// want to use a regular `KeyboardView`.
    override func viewWillSetupKeyboardView() {

        /// 💡 Call super to perform base view configuration.
        super.viewWillSetupKeyboardView()

        /// 💡 Make the demo use a ``DemoKeyboardView``.
        ///
        /// This passes the `unowned` controller to the view,
        setupKeyboardView { controller in
            DemoKeyboardView(controller: controller)
        }
    }
}
