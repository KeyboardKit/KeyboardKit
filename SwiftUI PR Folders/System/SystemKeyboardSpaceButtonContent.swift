//
//  SystemKeyboardSpaceButtonContent.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2021-01-10.
//  Copyright © 2020 Daniel Saidi. All rights reserved.
//

import KeyboardKit
import SwiftUI

/**
 This view mimics the content of a system space button, that
 starts with displaying the provided `localeText` then fades
 in the `spaceText`.
 */
public struct SystemKeyboardSpaceButtonContent: View {
    
    public init(localeText: String, spaceText: String) {
        self.localeText = localeText
        self.spaceText = spaceText
    }
    
    private let localeText: String
    private let spaceText: String
    private var action: KeyboardAction { .space }
    
    @State private var showLocale = true
    
    private static var lastLocaleText: String?
    
    
    public var body: some View {
        ZStack {
            SystemKeyboardButtonContent(action: action, text: localeText).opacity(showLocale ? 1 : 0)
            SystemKeyboardButtonContent(action: action, text: spaceText).opacity(!showLocale ? 1 : 0)
        }
        .transition(.opacity)
        .onAppear(perform: performAnimation)
    }
}

private extension SystemKeyboardSpaceButtonContent {
    
    var isNewLocale: Bool {
        localeText != Self.lastLocaleText
    }
    
    func performAnimation() {
        showLocale = isNewLocale
        guard isNewLocale else { return }
        Self.lastLocaleText = localeText
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            withAnimation { showLocale = false }
        }
    }
}

struct SystemKeyboardSpaceButtonContent_Previews: PreviewProvider {
    static var previews: some View {
        SystemKeyboardSpaceButtonContent(localeText: "Swedish", spaceText: "space")
    }
}
