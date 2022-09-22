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
 
 Note that this view does not render the shape of the button
 or adds any gestures to the content. The reason is that the
 view is used in other views where button shape and gestures
 are applied later. If you want a complete space button, use
 the `SystemKeyboardSpaceButton` view instead.
 */
public struct SystemKeyboardSpaceButtonContent<SpaceView: View>: View {

    /**
     Create a system keyboard space button content view that
     presents a custom view after presenting the locale.
     
     - Parameters:
       - localeText: The display name of the current locale.
       - spaceView: The custom view to use in the space button.
     */
    public init(
        localeText: String,
        spaceView: SpaceView
    ) {
        self.localeText = localeText
        self.spaceText = ""
        self.spaceView = spaceView
    }
    
    private let localeText: String
    private let spaceText: String
    private let spaceView: SpaceView?
    
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

public extension SystemKeyboardSpaceButtonContent where SpaceView == AnyView {
    
    /**
     Create a system keyboard space button content view that
     presents a custom text after presenting the locale.

     - Parameters:
       - localeText: The display name of the current locale.
       - spaceText: The localized name for "space".
     */
    init(
        localeText: String,
        spaceText: String) {
        self.localeText = localeText
        self.spaceText = spaceText
        self.spaceView = nil
    }
}

private struct SystemKeyboardSpaceButtonContentState {
    
    static var lastLocaleText: String?
}

private extension SystemKeyboardSpaceButtonContent {
    
    var localeView: SystemKeyboardButtonText {
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
    
    func text(_ text: String) -> SystemKeyboardButtonText {
        SystemKeyboardButtonText(text: text, action: .space)
    }
}

private extension SystemKeyboardSpaceButtonContent {
    
    var isNewLocale: Bool {
        localeText != SystemKeyboardSpaceButtonContentState.lastLocaleText
    }
    
    func performAnimation() {
        showLocale = isNewLocale
        guard isNewLocale else { return }
        SystemKeyboardSpaceButtonContentState.lastLocaleText = localeText
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
