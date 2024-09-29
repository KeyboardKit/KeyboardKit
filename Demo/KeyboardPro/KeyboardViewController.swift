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

        /// 💡 Always call super :)
        super.viewDidLoad()

        /// ‼️ Set up the keyboard for the demo app.
        super.setupPro(for: .demoApp) { result in

            /// 💡 These demo-specific configurations are in
            /// a file that is shared by the two keyboards.
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

        /// 🧪 Uncomment the lines if you want to revert the
        /// experimental next keyboard key modes that aim to
        /// improve the next keyboard key behavior.
        // Keyboard.NextKeyboardButtonControllerMode.current = .classic
        // Keyboard.NextKeyboardButtonProxyMode.current = .classic
    }

    /// This function is called when the controller needs to
    /// create or update the keyboard view.
    ///
    /// 💡 You don't need to override this function when you
    /// want to use a regular `KeyboardView`. This demo will
    /// however replace it with a custom view that adds more
    /// behavior to the reugular view.
    override func viewWillSetupKeyboardView() {

        /// 💡 Always call super :)
        super.viewWillSetupKeyboardView()

        /// 💡 Make the demo use a ``DemoKeyboardView``.
        ///
        /// This passes the `unowned` controller to the view,
        setupKeyboardView { controller in
            DemoKeyboardView(controller: controller)
        }
    }
}
