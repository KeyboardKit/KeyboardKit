//
//  DemoListItem.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2021-02-11.
//  Copyright © 2021 Daniel Saidi. All rights reserved.
//

import SwiftUI

struct DemoListItem: View {
    
    init(_ image: Image? = nil, _ text: String, _ rightImage: Image? = nil) {
        self.text = text
        self.image = image
        self.rightImage = rightImage
    }
    
    private let text: String
    private let image: Image?
    private let rightImage: Image?
    
    var body: some View {
        HStack {
            if let image = image {
                image.frame(width: 20).padding(.trailing, 10)
            }
            Text(text)
            if let image = rightImage {
                Spacer()
                rightImageView(for: image)
            }
        }.background(Color.white.opacity(0.0001))
    }
}

private extension DemoListItem {
    
    func rightImageView(for image: Image) -> some View {
        image
            .padding(.leading, 10)
            .font(SwiftUI.Font.footnote.bold())
            .opacity(0.2)
            .scaleEffect(1.05)
    }
}

struct DemoListItem_Previews: PreviewProvider {
    static var previews: some View {
        List {
            DemoListItem(.alert, "This is a list item", .alert)
        }
    }
}
