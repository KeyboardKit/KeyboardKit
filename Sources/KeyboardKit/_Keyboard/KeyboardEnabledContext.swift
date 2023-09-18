//
//  KeyboardEnabledContext.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2021-02-18.
//  Copyright © 2021-2023 Daniel Saidi. All rights reserved.
//

#if os(iOS) || os(tvOS)
import Foundation
import Combine
import UIKit

/**
 This class can be used to observe the enabled state of your
 keyboard extension.

 This type lets you check if a keyboard extension is enabled
 in System Settings, if it's currently active and if the app
 has been given full access.

 This type supports bundle id wildcards, which means that it
 can inspect the state of multiple keyboard extensions:

 ```
 let state = KeyboardEnabledContext(bundleId: "com.myapp.*")
 ```

 This context is not added to your keyboard input controller,
 since its intended to be used in the main app, where it can
 be used to display the keyboard extension state.
 */
public class KeyboardEnabledContext: KeyboardEnabledStateInspector, ObservableObject {

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

private extension KeyboardEnabledContext {

    var activePublisher: NotificationCenter.Publisher {
        notificationCenter.publisher(for: UIApplication.didBecomeActiveNotification)
    }

    var textPublisher: NotificationCenter.Publisher {
        notificationCenter.publisher(for: UITextInputMode.currentInputModeDidChangeNotification)
    }
}
#endif
