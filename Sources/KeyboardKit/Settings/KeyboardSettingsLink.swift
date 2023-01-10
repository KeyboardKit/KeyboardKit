//
//  KeyboardSettingsLink.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2023-01-09.
//  Copyright © 2023 Daniel Saidi. All rights reserved.
//

import SwiftUI

/**
 This link can be used to navigate a user to System Settings.

 The link behavior is a bit inconsistent, where iOS can link
 to either application settings, or the System Settings root.
 */
@available(iOS 14.0, tvOS 14.0, macOS 11.0, watchOS 7.0, *)
public struct KeyboardSettingsLink: View, UrlOpener {

    /**
     Create an enabled label.

     - Parameters:
       - title: The button text, by default `System Settings`.
       - icon: The button icon, by default `.keyboardSettings`.
       - url: The url to navigate to, by default `.keyboardSettings`.
     */
    public init(
        title: String = "System Settings",
        icon: Image = .keyboardSettings,
        url: URL? = .keyboardSettings
    ) {
        self.title = title
        self.icon = icon
        self.url = url
    }

    private let title: String
    private let icon: Image
    private let url: URL?

    public var body: some View {
        Button(action: { tryOpen(url) }) {
            Label {
                Text(title)
            } icon: {
                icon
            }
        }
    }
}


// MARK: - UrlOpener

private protocol UrlOpener {

    typealias OpenUrlCompletion = (_ success: Bool) -> Void
}

private extension UrlOpener {

    /**
     Whether or not the opener can open the provided `url`.
     */
    func canOpen(_ url: URL) -> Bool {
        #if os(iOS)
        return app.canOpenURL(url)
        #elseif os(macOS)
        return true
        #else
        return failForUnsupportedPlatform()
        #endif
    }

    /**
     Whether or not the opener can open the provided `url`.
     */
    func canOpen(_ url: URL?) -> Bool {
        guard let url = url else { return false }
        return canOpen(url)
    }

    /**
     Whether or not the opener can open the provided url.
     */
    func canOpen(urlString: String?) -> Bool {
        canOpen(URL(string: urlString ?? ""))
    }

    /**
     Try opening the provided `url`.
     */
    func tryOpen(_ url: URL, completion: @escaping OpenUrlCompletion = { _ in }) {
        #if os(iOS)
        app.open(url, options: [:], completionHandler: completion)
        #elseif os(macOS)
        completion(workspace.open(url))
        #else
        failForUnsupportedPlatform()
        #endif
    }

    /**
     Try opening the provided `url`.
     */
    func tryOpen(_ url: URL?, completion: @escaping OpenUrlCompletion = { _ in }) {
        guard let url = url else { return completion(false) }
        tryOpen(url, completion: completion)
    }

    /**
     Try opening the provided url.
     */
    func tryOpen(urlString: String?, completion: @escaping OpenUrlCompletion = { _ in }) {
        tryOpen(URL(string: urlString ?? ""), completion: completion)
    }
}


// MARK: - Private Functionality

private extension UrlOpener {

    #if os(iOS)
    var app: UIApplication { .shared }
    #elseif os(macOS)
    var workspace: NSWorkspace { .shared }
    #endif

    @discardableResult
    func failForUnsupportedPlatform() -> Bool {
        assertionFailure("UrlOpener: Unsupported platform")
        return false
    }
}
