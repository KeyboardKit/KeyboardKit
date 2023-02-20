//
//  ExternalKeyboardContext.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2021-05-13.
//  Copyright © 2021-2023 Daniel Saidi. All rights reserved.
//

import Foundation

#if os(iOS) || os(macOS) || os(tvOS)
import GameKit
#endif

/**
 This class can be used to detect whether or not an external
 keyboard is connected to the device.
 
 Note that Apple's Smart Keyboard Folio is connected when it
 is snapped on to a device, even if it's not open and active.
 */
public class ExternalKeyboardContext: ObservableObject {
    
    public init(notificationCenter: NotificationCenter = .default) {
        performSync()
        let sync = #selector(performSync)
        #if os(iOS) || os(macOS) || os(tvOS)
        notificationCenter.addObserver(self, selector: sync, name: Notification.Name.GCKeyboardDidConnect, object: nil)
        notificationCenter.addObserver(self, selector: sync, name: Notification.Name.GCKeyboardDidDisconnect, object: nil)
        #endif
    }
    
    @Published
    public private(set) var isExternalKeyboardConnected = false
}

@objc
private extension ExternalKeyboardContext {
    
    func performSync() {
        #if os(iOS) || os(macOS) || os(tvOS)
        isExternalKeyboardConnected = GCKeyboard.coalesced != nil
        #endif
    }
}
