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
 
 Texts are embedded as resources in this KeyboardKit package
 and use the SPM generated `.module` bundle by default. When
 not using SPM, `.module` will be undefined and this linking
 will fail. CocoaPods solves this by adding a `Bundle+module`
 file that is ignored by SPM.
 
 Another problem with this is that SwiftUI previews will not
 work outside of this package, but crash since the module is
 not found. If your previews keeps crashing due to this, you
 can set the `usePreviewTexts` property to `true`. This will
 cause the texts to use their raw values.
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
    
    var id: String { rawValue }
    
    var key: String { rawValue }
    
    var text: String {
        NSLocalizedString(key, bundle: .module, comment: "")
    }
    
    func text(for context: KeyboardContext) -> String {
        text(for: context.locale)
    }
    
    func text(for locale: KeyboardLocale) -> String {
        text(for: locale.locale)
    }
    
    func text(for locale: Locale) -> String {
        if isSwiftUIPreview && Self.usePreviewTexts { return rawValue }
        guard
            let bundlePath = Bundle.module.bundlePath(for: locale),
            let bundle = Bundle(path: bundlePath)
        else { return "" }
        return NSLocalizedString(key, bundle: bundle, comment: "")
    }
}

private extension KKL10n {
    
    var isSwiftUIPreview: Bool {
        ProcessInfo.processInfo.isSwiftUIPreview
    }
}

private extension Bundle {
    
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
