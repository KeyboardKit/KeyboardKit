//
//  DemoList.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2021-02-11.
//  Copyright © 2021 Daniel Saidi. All rights reserved.
//

import SwiftUI

struct DemoList<Content: View>: View {
    
    init(_ title: String, @ViewBuilder content: @escaping () -> Content) {
        self.title = title
        self.content = content
    }
    
    private let title: String
    private let content: () -> Content
    
    var body: some View {
        List {
            content()
        }
        .navigationTitle(title)
        .withPlatformSpecificListStyle()
        .navigationBarTitleDisplayMode(.inline)
    }
}

private extension View {
    
    func withPlatformSpecificListStyle() -> some View {
        #if os(iOS) || os(tvOS) || os(watchOS)
        return self.listStyle(InsetGroupedListStyle())
        #else
        return self
        #endif
    }
}

struct DemoList_Previews: PreviewProvider {
    static var previews: some View {
        DemoList("List") {
            Text("This")
            Text("is")
            Text("a")
            Text("Spartan")
            Text("list!")
        }
    }
}
