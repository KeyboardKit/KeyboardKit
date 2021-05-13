//
//  ExternalKeyboardContext.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2021-05-13.
//  Copyright © 2021 Daniel Saidi. All rights reserved.
//

import GameKit

/**
 This class can be used to detect whether or not an external
 keyboard is connected to the device.
 
 Note that Apple's Smart Keyboard Folio is connected when it
 is snapped on to a device, even if it's not open and active.
 */
@available(iOS 14.0, *)
public class ExternalKeyboardContext: ObservableObject {
    
    public init(notificationCenter: NotificationCenter = .default) {
        sync()
        let sync = #selector(sync)
        notificationCenter.addObserver(self, selector: sync, name: Notification.Name.GCKeyboardDidConnect, object: nil)
        notificationCenter.addObserver(self, selector: sync, name: Notification.Name.GCKeyboardDidDisconnect, object: nil)
    }
    
    @Published public private(set) var isExternalKeyboardConnected = false
}

@available(iOS 14.0, *)
@objc private extension ExternalKeyboardContext {
    
    func sync() {
        isExternalKeyboardConnected = GCKeyboard.coalesced != nil
    }
}
