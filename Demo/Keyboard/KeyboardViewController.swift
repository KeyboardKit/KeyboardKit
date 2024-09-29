//
//  KeyboardViewController.swift
//  Keyboard
//
//  Created by Daniel Saidi on 2021-02-11.
//  Copyright © 2021-2024 Daniel Saidi. All rights reserved.
//

import KeyboardKit
import SwiftUI

/// This keyboard demonstrates how to setup KeyboardKit with
/// a `KeyboardApp` and customize the standard configuration.
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
        super.setup(for: .demoApp)

        /// 💡 These demo-specific configurations are placed
        /// in a file that is shared by the two keyboards.
        setupDemoServices(extraKey: .rocket)
        setupDemoState()

        /// 🧪 Uncomment the lines if you want to revert the
        /// experimental next keyboard key modes that aim to
        /// improve the next keyboard key behavior.
        // Keyboard.NextKeyboardButtonControllerMode.current = .classic
    }

    /// This function is called when the controller needs to
    /// create or update the keyboard view.
    ///
    /// 💡 You don't need to override this function when you
    /// want to use a regular `KeyboardView`. This demo just
    /// overrides it to show you how you can do it if needed.
    override func viewWillSetupKeyboardView() {

        /// 💡 Always call super :)
        super.viewWillSetupKeyboardView()

        /// 💡 You can play around with this view or replace
        /// it, to see how it affects the keyboard extension.
        setupKeyboardView { controller in
            KeyboardView(
                state: controller.state,
                services: controller.services,
                buttonContent: { $0.view },
                buttonView: { $0.view },
                emojiKeyboard: { $0.view },
                toolbar: { params in params.view }
            )
            /// 💡 You can disable autocorrection like this.
            // .autocorrectionDisabled()
        }
    }
}
