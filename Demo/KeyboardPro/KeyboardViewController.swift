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
/// and customize the standard configuration.
///
/// To use the keyboard, simply enable it in System Settings,
/// then switch to it with the 🌐 key when typing in any app.
///
/// This keyboard uses KeyboardKit Pro `KeyboardApp` screens
/// to open keyboard and language settings as sheet overlays.
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

        /// 💡 Set up demo-specific state.
        setupDemoState()

        /// 💡 Call super to perform the base initialization.
        super.viewDidLoad()
    }

    /// This function is called whenever the keyboard should
    /// be created or updated.
    ///
    /// Here, we pass in the demo app's license key then use
    /// the custom ``DemoKeyboardView`` as the keyboard view.
    override func viewWillSetupKeyboard() {

        /// 💡 Call `super` to perform any fundamental setup.
        super.viewWillSetupKeyboard()
        
        /// 💡 Make the demo use a ``DemoKeyboardView``.
        ///
        /// This passes the `unowned` controller to the view,
        /// which must keep it unowned to avoid memory leaks!
        setupPro(
            withLicenseKey: KeyboardApp.demoApp.licenseKey ?? "",
            licenseConfiguration: setupServices,  // Specified below
            view: { controller in DemoKeyboardView(controller: controller) }
        )
    }


    // MARK: - Setup

    /// This function is called to set up keyboard services.
    func setupServices(with license: License) {

        /// 💡 Set up demo-specific services.
        setupDemoServices()
        
        /// 💡 Set up a KeyboardKit Pro theme-based service.
        ///
        /// Themes are powerful ways to specify styles for a
        /// keyboard. You can insert any theme below.
        services.styleProvider = .themed(
            with: .standard,
            keyboardContext: state.keyboardContext,
            fallback: services.styleProvider
        )
    }
}
