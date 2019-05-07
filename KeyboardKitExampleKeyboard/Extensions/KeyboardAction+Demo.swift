//
//  KeyboardAction+Demo.swift
//  KeyboardKitExampleKeyboard
//
//  Created by Daniel Saidi on 2019-04-30.
//  Copyright © 2019 Daniel Saidi. All rights reserved.
//

import UIKit
import KeyboardKit

extension KeyboardAction {

    var keyboardImage: UIImage? {
        switch self {
        case .image(_, let keyboardImageName, _): return UIImage(named: keyboardImageName)
        default: return nil
        }
    }
    
    var keyboardText: String? {
        switch self {
        case .character(let text): return text
        default: return nil
        }
    }
    
    var keyboardWidth: CGFloat {
        switch self {
        case .none: return 20
        case .space: return 100
        case .switchKeyboard: return 60
        default: return 50
        }
    }
    
    func keyboardWidth(for distribution: UIStackView.Distribution) -> CGFloat {
        let adjust = distribution == .fillProportionally
        return adjust ? keyboardWidth * 100 : keyboardWidth
    }
}
