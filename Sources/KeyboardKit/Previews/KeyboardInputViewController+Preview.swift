//
//  KeyboardInputViewController+Preview.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2021-02-01.
//  Copyright © 2021-2023 Daniel Saidi. All rights reserved.
//

#if os(iOS) || os(tvOS)
import Foundation

public extension KeyboardInputViewController {
    
    /**
     This preview controller can be used in SwiftUI previews.
     */
    static var preview: KeyboardInputViewController {
        KeyboardInputViewController()
    }
}
#endif
