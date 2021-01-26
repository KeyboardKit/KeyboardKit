//
//  Font+Weight.swift
//  KeyboardKit
//
//  Created by Brennan Drew on 2021-01-16.
//

import UIKit
import SwiftUI

public extension Font {
    
    /**
     Get a weight variation of the font.
     */
    func weight(_ uiFontWeight: UIFont.Weight?) -> Font {
        guard let weight = uiFontWeight?.fontWeight else { return self }
        return self.weight(weight)
    }
}

private extension UIFont.Weight {
    
    var fontWeight: Font.Weight {
        switch self {
        case .black: return .black
        case .bold: return .bold
        case .heavy: return .heavy
        case .light: return .light
        case .medium: return .medium
        case .regular: return .regular
        case .semibold: return .semibold
        case .thin: return .thin
        case .ultraLight: return .ultraLight
        default: return .regular
        }
    }
}
