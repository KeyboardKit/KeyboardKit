//
//  KeyboardStateContext.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2021-02-18.
//  Copyright © 2021-2024 Daniel Saidi. All rights reserved.
//

#if os(iOS) || os(tvOS) || os(visionOS)
import Foundation
import Combine
import UIKit

/// This context can be used to observe the enabled state of
/// a keyboard extension.
///
/// It can check if a keyboard is enabled in System Settings,
/// if Full Access is enabled, if a keyboard is active, etc.
///
/// This type supports bundle ID wildcards, which means that
/// it can inspect multiple keyboards at once, for instance:
///
/// ```
/// @StateObject
/// var state = KeyboardStateContext(bundleId: "com.myapp.*")
/// ```
///
/// This context is not added to the input controller, since
/// it's intended to be used in the main app, not a keyboard.
public class KeyboardStateContext: KeyboardStateInspector, ObservableObject {

    /**
     Create an instance of this observable state class.

     Make sure to use the `bundleId` of the keyboard and not
     the main application.

     - Parameters:
       - bundleId: The bundle ID of the keyboard extension.
       - notificationCenter: The notification center to use to observe changes.
     */
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

    /**
     Whether or not a keyboard extension with the ``bundleId``
     is currently being used.
     */
    @Published
    public var isKeyboardActive: Bool = false

    /**
     Whether or not a keyboard extension with the ``bundleId``
     has been enabled in System Settings.
     */
    @Published
    public var isKeyboardEnabled: Bool = false

    /**
     Refresh state for the currently used keyboard extension.
     */
    public func refresh() {
        isKeyboardActive = isKeyboardActive(withBundleId: bundleId)
        isKeyboardEnabled = isKeyboardEnabled(withBundleId: bundleId)
    }
}

private extension KeyboardStateContext {

    var activePublisher: NotificationCenter.Publisher {
        notificationCenter.publisher(for: UIApplication.didBecomeActiveNotification)
    }

    var textPublisher: NotificationCenter.Publisher {
        notificationCenter.publisher(for: UITextInputMode.currentInputModeDidChangeNotification)
    }
}
#endif
