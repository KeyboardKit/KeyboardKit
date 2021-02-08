//
//  ImageKeyboard.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2019-10-15.
//  Copyright © 2021 Daniel Saidi. All rights reserved.
//

import KeyboardKit

/**
 This demo keyboard has 24 buttons per page, which fits this
 demo app's two different grid sizes for portrait/landscape.
 It features one page of real emoji characters and four with
 image buttons, which are handled by the demo action handler.
 
 If you make any changes to this keyboard (which you should,
 play with it) the keyboard may get an uneven set of buttons,
 which the grid engine handles by adding empty dummy buttons
 at the very end.
 */
struct ImageKeyboard: DemoKeyboard, DemoImageKeyboard {
    
    init(in viewController: KeyboardViewController, context: KeyboardContext) {
        self.bottomActions = Self.bottomActions(
            leftmost: .keyboardType(.alphabetic(.lowercased)),
            for: viewController)
        let isLandscape = context.deviceOrientation.isLandscape
        let rowsPerPage = isLandscape ? 3 : 4
        let buttonsPerRow = isLandscape ? 8 : 6
        gridConfig = UIKeyboardButtonRowCollectionView.Configuration(rowHeight: 50, rowsPerPage: rowsPerPage, buttonsPerRow: buttonsPerRow)
    }
    
    let bottomActions: KeyboardActions
    
    let gridConfig: UIKeyboardButtonRowCollectionView.Configuration
}
