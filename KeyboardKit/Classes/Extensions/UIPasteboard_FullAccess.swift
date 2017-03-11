//
//  UIPasteboard_FullAccess.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2017-03-05.
//  Copyright © 2017 Daniel Saidi. All rights reserved.
//

import UIKit

public extension UIPasteboard {
    
    public var hasFullAccess: Bool {
        if #available(iOS 10.0, *) {
            let string = UIPasteboard.general.string
            UIPasteboard.general.string = "TEST"
            defer { UIPasteboard.general.string = string ?? "" }
            return UIPasteboard.general.hasStrings
        }
        return hasFullAccess_legacy
    }
    
    fileprivate var hasFullAccess_legacy: Bool {
        var pasteboard: UIPasteboard?
        pasteboard = UIPasteboard.general
        return pasteboard != nil
    }
    
}
