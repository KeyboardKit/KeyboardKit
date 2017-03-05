//
//  UIPasteboard_FullAccess.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2017-03-05.
//  Copyright © 2017 Daniel Saidi. All rights reserved.
//

import UIKit

public extension UIPasteboard {
    
    public var hasFullAccess: Bool
    {
        if #available(iOSApplicationExtension 10.0, *) {
            let pasteboard = UIPasteboard.general
            if pasteboard.hasURLs || pasteboard.hasColors || pasteboard.hasStrings || pasteboard.hasImages {
                return true
            }
            
            pasteboard.string = "Goth Emoji Test"
            let fullAccess = pasteboard.hasStrings
            pasteboard.string = ""
            return fullAccess
        } else {
            return hasFullAccess_legacy
        }
    }
    
    
    fileprivate var hasFullAccess_legacy: Bool {
        var pasteboard: UIPasteboard?
        pasteboard = UIPasteboard.general
        return pasteboard != nil
    }
}
