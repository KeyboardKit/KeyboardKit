//
//  NavigationLinkArrow.swift
//  SwiftUIKit
//
//  Created by Daniel Saidi on 2021-02-18.
//  Copyright © 2021-2025 Daniel Saidi. All rights reserved.
//

import SwiftUI

/// This view mimics the trailing navigation arrows that are
/// used by iOS navigation links.
struct NavigationLinkArrow: View {

    var body: some View {
        Image(systemName: "chevron.right")
            .padding(.leading, 2)
            .font(font)
            .opacity(0.3)
            .scaleEffect(scale)
    }
}

private extension NavigationLinkArrow {

    var font: Font {
        #if os(iOS)
        Font.footnote.weight(.semibold)
        #elseif os(tvOS)
        Font.caption.weight(.bold)
        #else
        Font.footnote.weight(.semibold)
        #endif
    }

    var scale: CGFloat {
        #if os(iOS)
        1.05
        #elseif os(tvOS)
        0.95
        #else
        1.00
        #endif
    }
}

#Preview {

    NavigationLinkArrow()
}
