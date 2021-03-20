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
    
    public var id: String { rawValue }
    
    public var key: String { rawValue }
    
    public var text: String {
        NSLocalizedString(key, bundle: .module, comment: "")
    }
}

struct L10n_Previews: PreviewProvider {
    
    static var previews: some View {
        NavigationView {
            List {
                ForEach(KKL10n.allCases) { item in
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
