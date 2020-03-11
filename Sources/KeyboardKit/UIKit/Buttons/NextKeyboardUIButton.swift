//
//  NextKeyboardUIButton.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2020-03-11.
//  Copyright © 2020 Daniel Saidi. All rights reserved.
//

import UIKit

@available(iOS 13.0, *)
public class NextKeyboardUIButton: UIButton {
    
    public convenience init(
        controller: KeyboardInputViewController,
        pointSize: CGFloat = 25,
        weight: UIImage.SymbolWeight = .light,
        scale: UIImage.SymbolScale = .medium) {
        self.init(type: .custom)
        let image = UIImage.globe(
            pointSize: pointSize,
            weight: weight,
            scale: scale)
        setImage(image, for: [])
        controller.setupNextKeyboardButton(self)
    }
}
