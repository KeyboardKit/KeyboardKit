//
//  UIInputViewController+NextKeyboard
//
//  Created by Daniel Saidi on 2020-06-15.
//  Copyright © 2021 Daniel Saidi. All rights reserved.
//

import UIKit

public extension UIInputViewController {
    
    /**
     Setup any `UIButton` as a "next keyboard" system button.
     */
    func setupNextKeyboardButton(_ button: UIButton) {
        let action = #selector(handleInputModeList(from:with:))
        button.addTarget(self, action: action, for: .allTouchEvents)
    }
}
