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
 
 Note that this view only generates the space button content,
 since it is used in views where a button shape and gestures
 are applied later, e.g. the `SystemKeyboard`. If you want a
 complete space button, use `SystemKeyboardSpaceButton`.
 */
public struct SystemKeyboardSpaceButtonContent: View {
    
    /**
     Create a system keyboard space button content view.
     
     - Parameters:
       - localeText: The name of the current locale, if any.
       - spaceText: The localized name for "space", if any.
       - appearance: The appearance to apply to the button.
     */
    public init(
        localeText: String? = nil,
        spaceText: String? = nil,
        appearance: KeyboardAppearance) {
        self.localeText = localeText
        self.spaceText = spaceText
        self.spaceView = nil
        self.appearance = appearance
    }
    
    /**
     Create a system keyboard space button content view.
     
     - Parameters:
       - localeText: The name of the current locale, if any.
       - spaceView: The custom view to use in the space button.
       - appearance: The appearance to apply to the button.
     */
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
    
    private var locale: Locale { context.locale }
    
    private static var lastLocaleText: String?
    
    private var localeDisplayText: String {
        localeText ??  locale.localizedLanguageName ?? ""
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
    
    func text(_ text: String) -> some View {
        SystemKeyboardButtonText(text: text, action: .space)
    }
    
    var localeView: some View {
        text(localeDisplayText)
    }
    
    @ViewBuilder
    var nonLocaleView: some View {
        if let view = spaceView {
            view
        } else {
            text(spaceText ?? KKL10n.space.text(for: context))
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
    
    static var defaultTexts: some View {
        SystemKeyboardSpaceButtonContent(
            localeText: nil,
            spaceText: nil,
            appearance: .preview)
    }
    
    static var specificTexts: some View {
        SystemKeyboardSpaceButtonContent(
            localeText: "LOCALE",
            spaceText: "SPACE",
            appearance: .preview)
    }
    
    static var spaceView: some View {
        SystemKeyboardSpaceButtonContent(
            localeText: "locale",
            spaceView: Image.keyboardGlobe,
            appearance: .preview)
    }
    
    static var previews: some View {
        VStack {
            defaultTexts
            specificTexts
            spaceView
        }.keyboardPreview()
    }
}
