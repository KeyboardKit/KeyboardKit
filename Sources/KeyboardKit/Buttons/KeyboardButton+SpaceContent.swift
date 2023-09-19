//
//  KeyboardButton+SpaceContent.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2021-01-10.
//  Copyright © 2021-2023 Daniel Saidi. All rights reserved.
//

import SwiftUI

public extension KeyboardButton {
    
    /**
     This view renders the content of a system space button.
     
     This view starts with showing the provided `localeText`,
     then fades to the provided `spaceText` or `spaceView`.
     */
    struct SpaceContent<SpaceView: View>: View {
        
        /**
         Create a system keyboard space button content view.
         
         - Parameters:
           - localeText: The display name of the current locale.
           - spaceView: The custom view to use in the space button.
         */
        public init(
            localeText: String,
            spaceView: SpaceView
        ) {
            self.localeText = localeText
            self.spaceView = spaceView
        }
        
        /**
         Create a system keyboard space button content view.
         
         - Parameters:
           - localeText: The display name of the current locale.
           - spaceText: The localized name for "space".
         */
        init(
            localeText: String,
            spaceText: String
        ) where SpaceView == KeyboardButton.Title {
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
        
        @State
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

private struct KeyboardButtonSpaceContentState {
    
    static var lastLocaleText: String?
}

private extension KeyboardButton.SpaceContent {
    
    var localeView: KeyboardButton.Title {
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

private extension KeyboardButton.SpaceContent {
    
    var isNewLocale: Bool {
        localeText != KeyboardButtonSpaceContentState.lastLocaleText
    }
    
    func performAnimation() {
        showLocale = isNewLocale
        guard isNewLocale else { return }
        KeyboardButtonSpaceContentState.lastLocaleText = localeText
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            withAnimation { showLocale = false }
        }
    }
}

struct KeyboardButton_SpaceContent_Previews: PreviewProvider {
    
    static var spaceText: some View {
        KeyboardButton.SpaceContent(
            localeText: KeyboardLocale.english.locale.localizedName,
            spaceText: KKL10n.space.text(for: .english))
    }
    
    static var spaceView: some View {
        KeyboardButton.SpaceContent(
            localeText: KeyboardLocale.spanish.locale.localizedName,
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
