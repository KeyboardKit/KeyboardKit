//
//  ObservableKeyboardContext.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2020-06-15.
//  Copyright © 2021 Daniel Saidi. All rights reserved.
//

import UIKit

/**
 This keyboard context is an `ObservableObject` and provides
 observable properties.
 */
open class ObservableKeyboardContext: KeyboardContext, ObservableObject {
    
    public init(
        locale: Locale = .current,
        device: UIDevice = .current,
        controller: KeyboardInputViewController,
        keyboardType: KeyboardType = .alphabetic(.lowercased)) {
        self.locale = locale
        self.device = device
        self.keyboardType = keyboardType
        self.sync(with: controller)
    }
    
    public let device: UIDevice
    
    @Published public var keyboardType: KeyboardType
    @Published public var deviceOrientation: UIInterfaceOrientation = .portrait
    @Published public var hasDictationKey: Bool = false
    @Published public var hasFullAccess: Bool = false
    @Published public var locale: Locale
    @Published public var needsInputModeSwitchKey: Bool = true
    @Published public var primaryLanguage: String?
    @Published public var textDocumentProxy: UITextDocumentProxy = PreviewTextDocumentProxy()
    @Published public var textInputMode: UITextInputMode?
    @Published public var traitCollection: UITraitCollection = UITraitCollection()
}
