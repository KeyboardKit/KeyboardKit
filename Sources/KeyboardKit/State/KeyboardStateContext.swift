//
//  KeyboardStateContext.swift
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
 This class can be used to observe the state of any keyboard.

 This lets us check if a keyboard has been enabled in System
 Settings, if Full Access is granted, and if it's being used.

 This type supports bundle id wildcards, which means that it
 can be used to inspect multiple keyboards, with a single id:

 ```
 @StateObject
 var state = KeyboardStateContext(bundleId: "com.myapp.*")
 ```

 The context is not added to the input controller, since the
 keyboard state is intended to be used in the main app.
 */
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
