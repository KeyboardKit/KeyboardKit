//
//  UserDefaults+KeyboardSettings.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2024-05-20.
//  Copyright © 2024 Daniel Saidi. All rights reserved.
//

import Foundation
import SwiftUI

public extension UserDefaults {
    
    /// This static instance can be used to persist keyboard
    /// related settings.
    ///
    /// This instance will be used by default by many of the
    /// `@AppStorage` persisted properties. Make sure to set
    /// this to a `suiteName`-based instance if you want the
    /// values to sync between the keyboard and the main app.
    ///
    /// To replace the standard instance with a new instance
    /// that syncs changes between the app and keyboard, you
    /// just have to do this with your specific app group ID:
    ///
    /// ```swift
    /// UserDefaults.keyboardSettings = .init(suiteName: "app-group-id")
    /// ```
    ///
    /// > Important: Since an @AppStorage annotated property
    /// will use the storage instance that is available when
    /// the property is initialized, make sure to set up any
    /// custom instances as soon as possible.
    static var keyboardSettings: UserDefaults? = .standard
}

#Preview {

    VStack {
        Color.red
    }
    .onAppear {
        UserDefaults.keyboardSettings = .init(suiteName: "foo")
    }
}
