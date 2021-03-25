//
//  KKL10n.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2021-02-25.
//  Copyright © 2021 Daniel Saidi. All rights reserved.
//

import SwiftUI

/**
 This enum maps towards keys in `Localizable.strings` files.
 */
public enum KKL10n: String, CaseIterable, Identifiable {

    case
        locale,
        
        done,
        go,
        ok,
        `return`,
        search,
        space
}

public extension KKL10n {
    
    var id: String { rawValue }
    
    var key: String { rawValue }
    
    var text: String {
        NSLocalizedString(key, bundle: .module, comment: "")
    }
    
    func text(for context: KeyboardContext) -> String {
        text(for: context.locale.identifier)
    }
    
    func text(for locale: KeyboardLocale) -> String {
        text(for: locale.id)
    }
    
    func text(for language: String) -> String {
        guard
            let bundlePath = Bundle.module.path(forResource: language, ofType: "lproj"),
            let bundle = Bundle(path: bundlePath)
        else { return "" }
        return NSLocalizedString(key, bundle: bundle, comment: "")
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
