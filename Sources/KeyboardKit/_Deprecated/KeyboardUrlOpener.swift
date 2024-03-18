//
//  KeyboardUrlOpener.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2023-05-29.
//  Copyright © 2023-2024 Daniel Saidi. All rights reserved.
//

import Foundation

/**
 This class can be used to open URLs from a keyboard without
 having to use `UIApplication`.
 
 This is deprecated in KeyboardKit 8.2. Instead of using the
 shared instance, use the controller openUrl directly or the
 action handler, by triggering ``KeyboardAction/url(_:id:)``.
 */
@available(*, deprecated, message: "This class is deprecated. Either use the controller directly, or trigger a KeyboardAction.url to handle URLs with the action handler.")
public class KeyboardUrlOpener {

    public init() {}

    public enum UrlError: Error {
        case nilUrl, noKeyboardController
    }

    /// A shared url opener.
    public static let shared = KeyboardUrlOpener()

    /// The controller to use to open the URL.
    public var controller: KeyboardController? {
        get { KeyboardUrlOpenerInternal.controller }
        set { KeyboardUrlOpenerInternal.controller = newValue
        }
    }

    /// Open a custom URL.
    public func open(_ url: URL?) throws {
        guard let controller else { throw UrlError.noKeyboardController }
        controller.openUrl(url)
    }
}

class KeyboardUrlOpenerInternal {
    
    public weak static var controller: KeyboardController?
}
