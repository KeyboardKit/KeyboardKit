//
//  Keyboard+SpaceContent.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2021-01-10.
//  Copyright © 2021-2024 Daniel Saidi. All rights reserved.
//

import SwiftUI

public extension Keyboard {
    
    /// This view renders standard system space key content.
    ///
    /// This view starts with showing a provided `localeText`,
    /// then fades to the provided `spaceText` or `spaceView`.
    struct SpaceContent<SpaceView: View>: View {
        
        /// Create a space key content view.
        ///
        /// - Parameters:
        ///   - localeText: The name of the current locale.
        ///   - spaceView: The custom view to use in the space button.
        public init(
            localeText: String,
            spaceView: SpaceView
        ) {
            self.localeText = localeText
            self.spaceView = spaceView
        }
        
        /// Create a space key content view.
        ///
        /// - Parameters:
        ///   - localeText: The name of the current locale.
        ///   - spaceText: The localized name for "space".
        init(
            localeText: String,
            spaceText: String
        ) where SpaceView == Keyboard.ButtonTitle {
            self.init(
                localeText: localeText,
                spaceView: .init(
                    text: spaceText,
                    action: .space
                )
            )
        }
        
        private let localeText: String
        private let spaceView: SpaceView
        
        @SwiftUI.State
        private var showLocale = true
        
        public var body: some View {
            ZStack {
                localeView.opacity(showLocale ? 1 : 0)
                nonLocaleView.opacity(!showLocale ? 1 : 0)
            }
            .transition(.opacity)
            .onAppear(perform: performAnimation)
        }
    }
}

private struct KeyboardSpaceContentState {
    
    static var lastLocaleText: String?
}

private extension Keyboard.SpaceContent {
    
    var localeView: Keyboard.ButtonTitle {
        .init(
            text: localeText,
            action: .space
        )
    }
    
    @ViewBuilder
    var nonLocaleView: some View {
        spaceView
    }
}

private extension Keyboard.SpaceContent {
    
    var isNewLocale: Bool {
        localeText != KeyboardSpaceContentState.lastLocaleText
    }
    
    func performAnimation() {
        showLocale = isNewLocale
        guard isNewLocale else { return }
        KeyboardSpaceContentState.lastLocaleText = localeText
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            withAnimation { showLocale = false }
        }
    }
}

#Preview {
    
    Group {
        Keyboard.SpaceContent(
            localeText: KeyboardLocale.english.locale.localizedName,
            spaceText: KKL10n.space.text(for: .english)
        )
        Keyboard.SpaceContent(
            localeText: KeyboardLocale.spanish.locale.localizedName,
            spaceView: Image.keyboardGlobe
        )
    }
    .padding()
    .background(Color.red)
    .cornerRadius(10)
}
