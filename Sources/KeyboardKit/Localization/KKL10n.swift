import SwiftUI

/**
 This enum maps towards keys in `Localizable.strings` files.
 */
public enum KKL10n: String, CaseIterable, Identifiable {

    case
        locale,
        languageName,
        
        go,
        ok,
        `return`,
        search,
        space
    
    public var id: String { rawValue }
    var key: String { rawValue }
     
    var hasText: Bool { text != key }
    
    var text: String {
        let text = NSLocalizedString(key, bundle: .module, comment: "")
        let isMissing = text == key
        return isMissing ? "-" : text
    }
}

struct L10n_Previews: PreviewProvider {
    
    static var missing: [KKL10n] {
        KKL10n.allCases.filter { !$0.hasText }
    }

    static var previews: some View {
        NavigationView {
            List {
                if missing.count == 0 {
                    Text("All translations are done!")
                } else {
                    Text("Missing translations:")
                }
                ForEach(KKL10n.allCases.filter { !$0.hasText }) { item in
                    VStack(alignment: .leading) {
                        Text("\(item.key)").font(.footnote)
                        Text("\(item.text)")
                    }.padding(.vertical, 4)
                }
            }.navigationBarTitle("Translations")
        }
        .environment(\.locale, Locale(identifier: "sv"))
    }
}
