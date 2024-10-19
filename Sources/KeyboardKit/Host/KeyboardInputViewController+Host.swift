//
//  KeyboardInputViewController+Host.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2023-03-27.
//  Copyright © 2023-2024 Daniel Saidi. All rights reserved.
//

#if os(iOS) || os(tvOS) || os(visionOS)
import SwiftUI
import UIKit

public extension KeyboardInputViewController {
    
    /// The bundle ID of the host application, if any, or if
    /// within a host app, the bundle id of the main bundle.
    ///
    /// The property uses technologies that may stop working
    /// in any future iOS version. Do not rely solely on the
    /// function, and design the app to be able to work even
    /// if this feature suddenly stops working.
    var hostApplicationBundleId: String? {
        if Bundle.main.isExtension {
            if let id = hostBundleIdValueBefore16 { return id }
            return hostBundleIdValueFor16
        } else {
            return Bundle.main.bundleIdentifier
        }
    }
}

private extension KeyboardInputViewController {
    
    var hostBundleIdValueBefore16: String? {
        let value = parent?.value(forKey: "_hostBundleID") as? String
        return value != "<null>" ? value: nil
    }
    
    var hostBundleIdValueFor16: String? {
        guard let pid = parent?.value(forKey: "_hostPID") else { return nil }
        let selector = NSSelectorFromString("defaultService")
        guard let anyClass: AnyObject = NSClassFromString("PKService"),
           let pkService = anyClass as? NSObjectProtocol,
           pkService.responds(to: selector),
           let serverInis = pkService.perform(selector).takeUnretainedValue() as? NSObjectProtocol
        else { return nil }
        let lities = serverInis.perform(NSSelectorFromString("personalities")).takeUnretainedValue()
        let bundleId = Bundle.main.bundleIdentifier ?? ""
        guard let infos = lities.object(forKey: bundleId) as? AnyObject,
           let info = infos.object(forKey: pid) as? AnyObject,
           let con = info.perform(NSSelectorFromString("connection")).takeUnretainedValue() as? NSObjectProtocol
        else { return nil }
        let xpcCon = con.perform(NSSelectorFromString("_xpcConnection")).takeUnretainedValue()
        let handle = dlopen("/usr/lib/libc.dylib", RTLD_NOW)
        let sym = dlsym(handle, "xpc_connection_copy_bundle_id")
        typealias xpcFunc = @convention(c) (AnyObject) -> UnsafePointer<CChar>
        let cFunc = unsafeBitCast(sym, to: xpcFunc.self)
        let response = cFunc(xpcCon)
        let hostBundleId = NSString(utf8String: response)
        return hostBundleId as String?
    }
}
#endif
