//
//  ExternalKeyboardContext.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2021-05-13.
//  Copyright © 2021-2023 Daniel Saidi. All rights reserved.
//

import Combine
import Foundation

#if os(iOS) || os(macOS) || os(tvOS)
import GameKit
#endif

/**
 This class can be used to detect whether or not an external
 keyboard is connected to the device.
 
 This context is not added to your keyboard input controller
 by default. To listen for external keyboards, simply create
 and add a context instance to your controller.
 
 Note that an Apple Smart Keyboard Folio is considered to be
 connected when it is snapped on to a device, even when it's
 not actively used.
 */
public class ExternalKeyboardContext: ObservableObject {
    
    public init(notificationCenter: NotificationCenter = .default) {
        #if os(iOS) || os(macOS) || os(tvOS)
        performSync()
        let sync = #selector(performSync)
        notificationCenter.addObserver(self, selector: sync, name: Notification.Name.GCKeyboardDidConnect, object: nil)
        notificationCenter.addObserver(self, selector: sync, name: Notification.Name.GCKeyboardDidDisconnect, object: nil)
        #endif
    }
    
    @Published
    public private(set) var isExternalKeyboardConnected = false
}

#if os(iOS) || os(macOS) || os(tvOS)
@objc
private extension ExternalKeyboardContext {
    
    func performSync() {
        isExternalKeyboardConnected = GCKeyboard.coalesced != nil
    }
}
#endif
