//
//  KeyboardEnabledState.swift
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
 This observable class can be used to observe the state of a
 keyboard extension.

 This type lets you check if a keyboard extension is enabled
 in System Settings, if it's active (currently being used to
 type) and if it has been given full access.

 Note that you can use bundle id wildcards, which means that
 you can inspect multiple keyboards, using a single instance:

 ```
 let state = KeyboardEnabledState(bundleId: "com.myapp.*")
 ```

 This class implements ``KeyboardEnabledStateInspector`` and
 uses the protocol extensions to sync the keyboard state for
 the provided `bundleId` to its published prooperties.
 */
public class KeyboardEnabledState: KeyboardEnabledStateInspector, ObservableObject {

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

private extension KeyboardEnabledState {

    var activePublisher: NotificationCenter.Publisher {
        notificationCenter.publisher(for: UIApplication.didBecomeActiveNotification)
    }

    var textPublisher: NotificationCenter.Publisher {
        notificationCenter.publisher(for: UITextInputMode.currentInputModeDidChangeNotification)
    }
}
#endif
