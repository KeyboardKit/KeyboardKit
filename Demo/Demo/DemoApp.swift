//
//  DemoApp.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2021-02-11.
//  Copyright © 2021-2024 Daniel Saidi. All rights reserved.
//

import SwiftUI

/// This is the main demo app.
///
/// The app has two keyboard extensions, that can be enabled
/// in System Settings. Full Access must be enabled for some
/// features to work.
@main
struct DemoApp: App {
    
    var body: some Scene {
        WindowGroup {
            HomeScreen()
        }
    }
}
