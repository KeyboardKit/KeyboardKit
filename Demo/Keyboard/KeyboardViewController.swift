//
//  KeyboardViewController.swift
//  Keyboard
//
//  Created by Daniel Saidi on 2021-02-11.
//  Copyright © 2021-2024 Daniel Saidi. All rights reserved.
//

import KeyboardKit
import SwiftUI

/// This keyboard demonstrates how to set up KeyboardKit and
/// customize the standard configuration.
///
/// To use the keyboard, simply enable it in System Settings,
/// then switch to it with the 🌐 key when typing in any app.
class KeyboardViewController: KeyboardInputViewController {

    /// This function is called when the controller launches.
    ///
    /// Below, we make demo-specific keyboard configurations.
    /// Play around with them to see how it affects the demo.
    override func viewDidLoad() {

        // MARK: - App Group Synced Settings

        // Call this as early as possible to set up keyboard
        // settings to sync between the app and its keyboard.
        // KeyboardSettings.setupStore(withAppGroup: "group.com.your-app-id")

        /// 🧪 Enable this to test the experimental next keyboard controller mode.
        /// To try it, just set up a `.keyboardSwitcher` as extra key further down.
        /// The switch should work without crashes when using the experimental mode.
        /// Read more at https://github.com/KeyboardKit/KeyboardKit/issues/799
        // Keyboard.NextKeyboardButtonControllerMode.current = .experimentalNilTarget

        /// 💡 Set up demo-specific services.
        setupDemoServices(extraKey: .rocket)

        /// 💡 Set up demo-specific state.
        setupDemoState()

        /// 💡 Call super to perform the base initialization.
        super.viewDidLoad()
    }

    /// This function is called whenever the keyboard should
    /// be created or updated.
    ///
    /// Here, we just setup a standard keyboard view to show
    /// to do it. You can customize any part of this view or
    /// replace it with a completely custom view if you want.
    override func viewWillSetupKeyboard() {
        super.viewWillSetupKeyboard()

        /// 💡 Make the demo use a standard ``KeyboardView``.
        setup { controller in
            KeyboardView(
                state: controller.state,
                services: controller.services,
                buttonContent: { $0.view },
                buttonView: { $0.view },
                emojiKeyboard: { $0.view },
                toolbar: { params in
                    params.view
                    // TempScrollToolbar()
                }
            )
            /// 💡 You can disable autocorrection like this.
            // .autocorrectionDisabled()
        }
    }
}

/// This toolbar can be used to test a bug where buttons can
/// get stuck in a pressed state if you touch them while you
/// also scroll the scroll view. The buttons now restore any
/// corrupt state, but it would be nice to reduce that delay.
private struct TempScrollToolbar: View {
    
    var body: some View {
        ScrollView(.horizontal) {
            ZStack {
                Color.yellow
                HStack {
                    ForEach((0...30), id: \.self) { index in
                        Button {} label: {
                            Text("Button \(index)")
                                .frame(maxHeight: .infinity)
                        }
                    }
                }
            }
        }
        .buttonStyle(.bordered)
    }
}
