//
//  NextKeyboardButtonPreview.swift
//  KeyboardKitSwiftUIPreviews
//
//  Created by Daniel Saidi on 2020-06-16.
//  Copyright © 2020 Daniel Saidi. All rights reserved.
//

import KeyboardKit
import KeyboardKitSwiftUI
import SwiftUI
import UIKit

struct NextKeyboardButtonPreview: View {
    var body: some View {
        NextKeyboardButton(
            controller: KeyboardInputViewController(),
            tintColor: .green,
            pointSize: 45,
            weight: .light,
            scale: .medium)
    }
}

struct NextKeyboardButtonPreview_Previews: PreviewProvider {
    static var previews: some View {
        NextKeyboardButtonPreview()
    }
}
