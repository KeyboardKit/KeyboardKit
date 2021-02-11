//
//  DemoListButton.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2021-02-11.
//  Copyright © 2021 Daniel Saidi. All rights reserved.
//

import SwiftUI

struct DemoListButton: View {
    
    init(
        _ image: Image? = nil,
        _ text: String,
        _ rightImage: Image? = nil,
        _ isNavigation: Bool = false,
        action: @escaping () -> Void) {
        self.item = DemoListItem(image, text, rightImage)
        self.action = action
    }
    
    private let item: DemoListItem
    private let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            item
        }.buttonStyle(PlainButtonStyle())
    }
}

struct DemoListButton_Previews: PreviewProvider {
    static var previews: some View {
        List {
            DemoListButton(.alert, "This is a list item", .alert, action: {})
        }
    }
}
