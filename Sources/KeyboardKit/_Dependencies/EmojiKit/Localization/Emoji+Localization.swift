//
//  Emoji+Localization.swift
//  EmojiKit
//
//  Created by Daniel Saidi on 2022-12-12.
//  Copyright © 2022-2025 Daniel Saidi. All rights reserved.
//

import Foundation
import SwiftUI

extension Emoji: Localizable {
    
    /// The `Localizable.strings` key to use when localizing.
    public var localizationKey: String {
        char
    }
}

#if os(iOS)
#Preview {

    struct Preview: View {

        let locale = Locale(identifier: "en")

        @AppStorage("com.emojikit.previews.emoji+location.scrollId")
        var id: String = ""

        @State
        var query = ""

        var body: some View {
            NavigationView {
                ScrollViewReader { scroll in
                    if #available(iOS 15.0, *) {
                        List {
                            ForEach(Emoji.all.matching(query, in: locale)) { emoji in
                                Label {
                                    VStack(alignment: .leading) {
                                        Text(emoji.localizedName)
                                        Text(emoji.unicodeName)
                                            .font(.footnote)
                                            .foregroundColor(.secondary)
                                    }
                                } icon: {
                                    Text(emoji.char)
                                }
                                .id(emoji.char)
                                .onTapGesture {
                                    id = emoji.char
                                    print(emoji.char)
                                }
                            }
                            .onAppear {
                                scroll.scrollTo(id)
                            }
                        }
                        .searchable(text: $query)
                    } else {
                        // Fallback on earlier versions
                    }
                }
            }
        }
    }

    return Preview()
}
#endif
