//
//  ExternalKeyboardContext.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2021-05-13.
//  Copyright © 2021-2025 Daniel Saidi. All rights reserved.
//

import SwiftUI

/// This context can be used to keep track of if an external
/// keyboard is connected to the device.
///
/// KeyboardKit Pro automatically keeps this context updated
/// as external keyboards are connected and disconnected.
///
/// > Important: The Apple Smart Keyboard Folio keyboard can
/// be connected to a device without being actively used. It
/// should be fixed to only be considered connected when the
/// keyboard is actively being used.
public class ExternalKeyboardContext: ObservableObject {

    /// Create an external keyboard context.
    ///
    /// - Parameters:
    ///   - notificationCenter: The notification center to use.
    public init(
        notificationCenter: NotificationCenter = .default
    ) {
        self.notificationCenter = notificationCenter
    }

    /// The notification center to use for observations.
    public let notificationCenter: NotificationCenter

    /// Whether an external keyboard is connected.
    @Published var isExternalKeyboardConnected = false
}
