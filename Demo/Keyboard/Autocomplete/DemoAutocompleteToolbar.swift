//
//  DemoAutocompleteToolbar.swift
//  Keyboard
//
//  Created by Daniel Saidi on 2021-09-16.
//  Copyright © 2021 Daniel Saidi. All rights reserved.
//

import KeyboardKit
import SwiftUI

/**
 This demo-specific toolbar always applies a height to avoid
 that the keyboard resizes when it gets suggestions and when
 it's empty. It also presents any subtitles as footnote text.
 */
struct DemoAutocompleteToolbar: View {
    
    @EnvironmentObject private var context: AutocompleteContext
    
    var body: some View {
        AutocompleteToolbar(
            suggestions: context.suggestions,
            itemBuilder: itemBuilder)
            .frame(height: 50)
    }
}

private extension DemoAutocompleteToolbar {
    
    func item(for suggestion: AutocompleteSuggestion) -> AnyView {
        guard let subtitle = suggestion.subtitle else { return AutocompleteToolbar.standardItem(for: suggestion) }
        return AnyView(VStack(spacing: 0) {
            AutocompleteToolbarItemText(suggestion: suggestion)
            Text(subtitle).font(.footnote)
        }.frame(maxWidth: .infinity))
    }
    
    func itemBuilder(suggestion: AutocompleteSuggestion) -> AnyView {
        AnyView(
            item(for: suggestion)
                .background(Color.clearInteractable)
        )
    }
}

struct DemoAutocompleteToolbar_Previews: PreviewProvider {
    static var previews: some View {
        DemoAutocompleteToolbar()
    }
}
