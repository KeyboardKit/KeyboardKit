//
//  KeyboardStatusContext.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2021-02-18.
//  Copyright © 2021-2024 Daniel Saidi. All rights reserved.
//

#if os(iOS) || os(tvOS) || os(visionOS)
import Foundation
import Combine
import UIKit

/// This class has observable, keybpard status-related state.
///
/// This class can be used to check if a keyboard is enabled
/// in System Settings, if Full Access is enabled, etc.
///
/// This type supports bundle ID wildcards, which means that
/// it can inspect multiple keyboards at once, for instance:
///
/// ```
/// @StateObject
/// var status = KeyboardStatusContext(bundleId: "com.myapp.*")
/// ```
///
/// This context is not added to the input controller, since
/// it's intended to be used in the main app, not a keyboard.
public class KeyboardStatusContext: KeyboardStatusInspector, ObservableObject {

    /// Create an instance of this observable state class.
    ///
    /// Make sure to use the `bundleId` of the keyboard, not
    /// the main application.
    ///
    /// - Parameters:
    ///   - bundleId: The bundle ID of the keyboard extension.
    ///   - notificationCenter: The notification center to use to observe changes.
    public init(
        bundleId: String,
        notificationCenter: NotificationCenter = .default
    ) {
        self.bundleId = bundleId
        self.notificationCenter = notificationCenter
        activePublisher
            .sink(receiveValue: { [weak self] _ in self?.refresh() })
            .store(in: &cancellables)
        textPublisher
            .delay(for: 0.5, scheduler: RunLoop.main)
            .sink(receiveValue: { [weak self] _ in self?.refresh() })
            .store(in: &cancellables)
        refresh()
    }

    public let bundleId: String

    private var cancellables = Set<AnyCancellable>()
    private let notificationCenter: NotificationCenter

    /// Whether the keyboard extension is actively used.
    @Published
    public var isKeyboardActive: Bool = false

    /// Whether the keyboard extension has been enabled.
    @Published
    public var isKeyboardEnabled: Bool = false

    /// Refresh the observable state.
    public func refresh() {
        isKeyboardActive = isKeyboardActive(withBundleId: bundleId)
        isKeyboardEnabled = isKeyboardEnabled(withBundleId: bundleId)
    }
}

private extension KeyboardStatusContext {

    var activePublisher: NotificationCenter.Publisher {
        notificationCenter.publisher(
            for: UIApplication.didBecomeActiveNotification
        )
    }

    var textPublisher: NotificationCenter.Publisher {
        notificationCenter.publisher(
            for: UITextInputMode.currentInputModeDidChangeNotification
        )
    }
}
#endif
