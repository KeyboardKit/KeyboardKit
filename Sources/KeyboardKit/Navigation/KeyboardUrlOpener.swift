//
//  KeyboardUrlOpener.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2023-05-29.
//  Copyright © 2023 Daniel Saidi. All rights reserved.
//

import Foundation

/**
 This class can be used to open URLs from a keyboard without
 having to use `UIApplication`.

 You can use ``KeyboardUrlOpener/shared`` to avoid having to
 create custom instances. Note that you have to manually set
 the ``controller`` when you create a custom opener or use a
 custom controller.
 */
public class KeyboardUrlOpener {

    public init() {}

    public enum UrlError: Error {
        case nilUrl, noKeyboardController
    }

    /// A shared url opener.
    public static let shared = KeyboardUrlOpener()

    /// The controller to use to open the URL.
    public unowned var controller: KeyboardController?

    /// Open a custom URL.
    public func open(_ url: URL?) throws {
        guard let controller else { throw UrlError.noKeyboardController }
        controller.openUrl(url)
    }
}
