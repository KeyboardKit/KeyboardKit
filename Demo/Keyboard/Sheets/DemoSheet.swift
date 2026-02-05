//
//  DemoSheet.swift
//  KeyboardPro
//
//  Created by Daniel Saidi on 2024-11-25.
//  Copyright © 2024-2025 Daniel Saidi. All rights reserved.
//

import SwiftUI

/// This enum defines the sheets that in the Pro keyboard.
///
/// The file is added to the app as well, to enable previews.
enum DemoSheet: String, Identifiable {
    case autocompleteSettings
    case clipboardSettings
    case experimentSettings
    case feedbackSettings
    case fontSettings
    case fullDocumentReader
    case hostApplicationInfo
    case keyboardSettings
    case localeSettings
    case themeSettings

    var id: String { rawValue }
}
