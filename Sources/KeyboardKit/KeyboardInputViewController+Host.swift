//
//  KeyboardViewController+Host.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2023-03-27.
//  Copyright © 2023 Daniel Saidi. All rights reserved.
//

#if os(iOS) || os(tvOS)
import SwiftUI
import UIKit

public extension KeyboardInputViewController {

    /**
     Get the bundle ID of the host app, which is the current
     app that is using the keyboard.

     Note that this implementation makes use of technologies
     that may stop working in any future iOS version. Do not
     rely solely on this and make sure to design your app to
     be able to function even if this suddenly stops working.

     Also note that the ID that is returned can differ based
     on the iOS version being used to fetch it.
     */
    var hostBundleId: String? {
        if let bundleId = hostBundleIdValue { return bundleId }
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

private extension KeyboardInputViewController {

    var hostBundleIdValue: String? {
        let value = parent?.value(forKey: "_hostBundleID") as? String
        return value != "<null>" ? value: nil
    }
}
#endif
