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
 to the `spaceText` (or `spaceView`).
 
 Note that this view only generates the space button content,
 since it is used in views where a button shape and gestures
 are applied later, e.g. the `SystemKeyboard`. If you want a
 complete space button, use `SystemKeyboardSpaceButton`.
 */
public struct SystemKeyboardSpaceButtonContent: View {
    
    /**
     Create a system keyboard space button content view.
     
     - Parameters:
       - localeText: The display name of the current locale.
       - spaceText: The localized name for "space".
     */
    public init(
        localeText: String,
        spaceText: String) {
        self.localeText = localeText
        self.spaceText = spaceText
        self.spaceView = nil
    }
    
    /**
     Create a system keyboard space button content view.
     
     - Parameters:
       - localeText: The display name of the current locale.
       - spaceView: The custom view to use in the space button.
     */
    public init<SpaceView: View>(
        localeText: String,
        spaceView: SpaceView) {
        self.localeText = localeText
        self.spaceText = ""
        self.spaceView = AnyView(spaceView)
    }
    
    private let localeText: String
    private let spaceText: String
    private let spaceView: AnyView?
    
    private static var lastLocaleText: String?
    
    @State private var showLocale = true
    
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
        text(localeText)
    }
    
    @ViewBuilder
    var nonLocaleView: some View {
        if let view = spaceView {
            view
        } else {
            text(spaceText)
        }
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
    
    static var spaceText: some View {
        SystemKeyboardSpaceButtonContent(
            localeText: KeyboardLocale.english.localizedName,
            spaceText: KKL10n.space.text(for: .english))
    }
    
    static var spaceView: some View {
        SystemKeyboardSpaceButtonContent(
            localeText: KeyboardLocale.spanish.localizedName,
            spaceView: Image.keyboardGlobe)
    }
    
    static var previews: some View {
        VStack {
            Group {
                spaceText
                spaceView
            }
            .padding()
            .background(Color.red)
            .cornerRadius(10)
        }
    }
}
