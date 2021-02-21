//
//  SystemKeyboardSpaceButtonContent.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2021-01-10.
//  Copyright © 2021 Daniel Saidi. All rights reserved.
//

import SwiftUI

/**
 This view mimics the content of a system space button, that
 starts with displaying the provided `localeText` then fades
 in the `spaceText`.
 */
public struct SystemKeyboardSpaceButtonContent: View {
    
    public init(
        localeText: String? = nil,
        spaceText: String = KKL10n.space.text) {
        self.localeText = localeText
        self.spaceText = spaceText
    }
    
    private let localeText: String?
    private let spaceText: String
    private var action: KeyboardAction { .space }
    
    private static var lastLocaleText: String?
    
    private var localeDisplayText: String {
        localeText ??  context.locale.localizedString(forLanguageCode: context.locale.languageCode ?? "en") ?? ""
    }
    
    @State private var showLocale = true
    
    @EnvironmentObject private var context: KeyboardContext
    
    public var body: some View {
        ZStack {
            SystemKeyboardButtonContent(action: action, text: localeDisplayText).opacity(showLocale ? 1 : 0)
            SystemKeyboardButtonContent(action: action, text: spaceText).opacity(!showLocale ? 1 : 0)
        }
        .transition(.opacity)
        .onAppear(perform: performAnimation)
    }
}

private extension SystemKeyboardSpaceButtonContent {
    
    var isNewLocale: Bool {
        localeDisplayText != Self.lastLocaleText
    }
    
    func performAnimation() {
        showLocale = isNewLocale
        guard isNewLocale else { return }
        Self.lastLocaleText = localeDisplayText
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            withAnimation { showLocale = false }
        }
    }
}

struct SystemKeyboardSpaceButtonContent_Previews: PreviewProvider {
    
    static var previews: some View {
        SystemKeyboardSpaceButtonContent(
            localeText: nil,
            spaceText: "space").environmentObject(KeyboardContext(controller: .preview))
    }
}
