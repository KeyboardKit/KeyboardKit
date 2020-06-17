//
//  KeyboardViewController.swift
//  KeyboardKitDemoKeyboard_SwiftUI
//
//  Created by Daniel Saidi on 2020-06-10.
//  Copyright © 2020 Daniel Saidi. All rights reserved.
//

import UIKit
import KeyboardKit
import KeyboardKitSwiftUI

/**
 This SwiftUI-based demo keyboard demonstrates how to create
 a SwiftUI-based keyboard extension using `KeyboardKit`.
 
 This demo keyboard handles a bunch of actions, sends string
 and emoji inputs to the text proxy, copies tapped images to
 the pasteboard and saves long pressed images to photos etc.
 It also has a topmost auto complete toolbar with three fake
 suggestions for the currently active word.
 
 `IMPORTANT` To use this keyboard, you must enable it in the
 system keyboard settings ("Settings/General/Keyboards") and
 give it full access, which is unfortunately required to use
 some features like haptic and audio feedback, access to the
 user's photos etc.
 
 If you want to use these features in your own app, you must
 add `RequestsOpenAccess` to the extension `Info.plist`, add
 a `NSPhotoLibraryAddUsageDescription` to the **host** app's
 `Info.plist` etc. This is already done in this demo app, so
 you can just copy the setup into your own app.
 */
class KeyboardViewController: KeyboardInputViewController {

    @IBOutlet var nextKeyboardButton: UIButton!
        
    override func viewDidLoad() {
        super.viewDidLoad()
        setup(with: KeyboardView(controller: self))
    }
    
    override func viewWillLayoutSubviews() {
        //self.nextKeyboardButton.isHidden = !self.needsInputModeSwitchKey
        super.viewWillLayoutSubviews()
    }
}
