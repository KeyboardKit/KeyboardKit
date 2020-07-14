//
//  Image+KeyboardPreviews.swift
//  KeyboardKitSwiftUIPreviews
//
//  Created by Daniel Saidi on 2020-06-16.
//  Copyright © 2020 Daniel Saidi. All rights reserved.
//

import KeyboardKitSwiftUI
import SwiftUI

struct Image_KeyboardPreviews: View {
    var body: some View {
        VStack(spacing: 20) {
            Image.backspace
            Image.globe
            Image.newLine
        }
    }
}

struct Image_KeyboardPreviews_Previews: PreviewProvider {
    static var previews: some View {
        Image_KeyboardPreviews()
    }
}
