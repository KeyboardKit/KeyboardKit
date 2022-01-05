//
//  KKL10n.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2021-02-25.
//  Copyright © 2021 Daniel Saidi. All rights reserved.
//

import SwiftUI

/**
 This enum contains keyboard-specific, resource-based texts.
 
 Texts are embedded as resources in the package, and use the
 SPM generated `.module` bundle by default. If not using SPM,
 `.module` will be undefined and the linking will fail. This
 is solved with the `Bundle+module` file.
 
 Another problem with this is that SwiftUI previews will not
 work outside of this package, since the module is not found
 in previews. This will cause previews to crash. To fix this,
 use the `KeyboardPreviewMode`.
 
 `TODO` Add emoji category keyboard-specific texts.
 */
public enum KKL10n: String, CaseIterable, Identifiable {

    case
        locale,
        
        done,
        go,
        ok,
        `return`,
        search,
        space,
    
        keyboardTypeAlphabetic,
        keyboardTypeNumeric,
        keyboardTypeSymbolic
    
    /**
     Whether or not to use the `previewTextProvider` when a
     color is presented in a preview.
     */
    static var usePreviewTexts = false
}

public extension KKL10n {
    
    /**
     The item's unique identifier.
     */
    var id: String { rawValue }
    
    /**
     The item's localization key.
     */
    var key: String { rawValue }
    
    /**
     The item's localized text.
     */
    var text: String {
        if useRawText { return rawValue }
        return NSLocalizedString(key, bundle: .module, comment: "")
    }
    
    /**
     The item's localized text for a certain `context`.
     */
    func text(for context: KeyboardContext) -> String {
        text(for: context.locale)
    }
    
    /**
     The item's localized text for a certain `locale`.
     */
    func text(for locale: KeyboardLocale) -> String {
        text(for: locale.locale)
    }
    
    /**
     The item's localized text for a certain `locale`.
     */
    func text(for locale: Locale) -> String {
        if useRawText { return rawValue }
        guard
            let bundlePath = Bundle.module.bundlePath(for: locale),
            let bundle = Bundle(path: bundlePath)
        else { return "" }
        return NSLocalizedString(key, bundle: bundle, comment: "")
    }
}

extension KKL10n {
    
    var isSwiftUIPreview: Bool {
        ProcessInfo.processInfo.isSwiftUIPreview
    }
    
    var useRawText: Bool {
        isSwiftUIPreview && Self.usePreviewTexts
    }
}

extension Bundle {
    
    func bundlePath(for locale: Locale) -> String? {
        bundlePath(named: locale.identifier) ?? bundlePath(named: locale.languageCode)
    }
    
    func bundlePath(named name: String?) -> String? {
        path(forResource: name ?? "", ofType: "lproj")
    }
}

struct KKL10n_Previews: PreviewProvider {
    
    static let context: KeyboardContext = {
        let context = KeyboardContext.preview
        context.locale = KeyboardLocale.swedish.locale
        return context
    }()
    
    static var previews: some View {
        NavigationView {
            List {
                ForEach(KKL10n.allCases) { item in
                    VStack(alignment: .leading, spacing: 10) {
                        Text("\(item.key)")
                        VStack(alignment: .leading) {
                            Text("Locale: \(item.text(for: context))")
                            ForEach(KeyboardLocale.allCases) {
                                Text("\($0.id): \(item.text(for: $0))")
                            }
                        }.font(.footnote)
                    }.padding(.vertical, 4)
                }
            }.navigationBarTitle("Translations")
        }
    }
}
