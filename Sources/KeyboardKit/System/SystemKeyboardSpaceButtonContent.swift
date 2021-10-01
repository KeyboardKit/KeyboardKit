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
 to the `spaceText` (or `spaceView` if it's set).
 */
public struct SystemKeyboardSpaceButtonContent: View {
    
    public init(
        localeText: String? = nil,
        spaceText: String? = nil,
        appearance: KeyboardAppearance) {
        self.localeText = localeText
        self.spaceText = spaceText
        self.spaceView = nil
        self.appearance = appearance
    }
    
    public init<SpaceView: View>(
        localeText: String? = nil,
        spaceView: SpaceView,
        appearance: KeyboardAppearance) {
        self.localeText = localeText
        self.spaceText = nil
        self.spaceView = AnyView(spaceView)
        self.appearance = appearance
    }
    
    private let localeText: String?
    private let spaceText: String?
    private let spaceView: AnyView?
    private let appearance: KeyboardAppearance
    
    private var action: KeyboardAction { .space }
    
    private var locale: Locale { context.locale }
    
    private static var lastLocaleText: String?
    
    private var localeDisplayText: String {
        localeText ??  locale.localizedString(forLanguageCode: locale.languageCode ?? "en") ?? ""
    }
    
    @State private var showLocale = true
    
    @EnvironmentObject private var context: KeyboardContext
    
    public var body: some View {
        ZStack {
            localeView.opacity(showLocale ? 1 : 0)
            nonLocaleView.opacity(!showLocale ? 1 : 0)
        }
        .transition(.opacity)
        .onAppear(perform: performAnimation)
    }
}

private extension SystemKeyboardSpaceButtonContent {
    
    var localeView: some View {
        SystemKeyboardButtonContent(
            action: action,
            appearance: appearance,
            text: localeDisplayText)
    }
    
    @ViewBuilder
    var nonLocaleView: some View {
        if let view = spaceView {
            view
        } else {
            let text = spaceText ?? KKL10n.space.text(for: context)
            SystemKeyboardButtonContent(
                action: action,
                appearance: appearance,
                text: text)
        }
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
            spaceText: "space",
            appearance: .preview)
            .keyboardPreview()
    }
}
