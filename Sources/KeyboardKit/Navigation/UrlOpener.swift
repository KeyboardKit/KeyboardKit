//
//  UrlOpener.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2024-09-12.
//  Copyright © 2024 Daniel Saidi. All rights reserved.
//

import Foundation

#if os(iOS) || os(tvOS) || os(visionOS)
import UIKit
#endif

/// This protocol can be implemented by any type that can be
/// used to open URLs from anywhere.
///
/// While you must implement ``openUrl(_:)`` it can call the
/// ``openUrlDefault(_:)`` function internally.
public protocol UrlOpener: UIResponder {

    /// Try to open a URL.
    func openUrl(_ url: URL?)
}

public extension UrlOpener {

    /// Try to open a URL with the default logic.
    ///
    /// This is currently only available when `UIApplication`
    /// is available. Other platforms must add their own way
    /// of opening URLs.
    func openUrlDefault(_ url: URL?) {
        guard let url else { return }
        #if os(iOS) || os(tvOS) || os(visionOS)
        if #available(iOS 18.0, tvOS 18.0, visionOS 2.0, *) {
            let selector = sel_registerName("openURL:options:completionHandler:")
            let responder = findResponder(for: selector)
            if let app = responder as? UIApplication {
                app.open(url, options: .init(), completionHandler: nil)
            } else if let scene = responder as? UIScene {
                scene.open(url, options: .init(), completionHandler: nil)
            }
        } else {
            let selector = sel_registerName("openURL:")
            let responder = findResponder(for: selector)
            _ = responder?.perform(selector, with: url)
        }
        #else
        print("UrlOpener.openUrl: Unsupported platform")
        #endif
    }
}

private extension UrlOpener {

    func findResponder(for selector: Selector) -> UIResponder? {
        var responder = self as UIResponder?
        while let r = responder, !r.responds(to: selector) {
            responder = r.next
        }
        return responder
    }
}
