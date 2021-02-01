//
//  KeyboardToastContext.swift
//  SwiftUIKit
//
//  Created by Daniel Saidi on 2020-03-18.
//  Copyright © 2021 Daniel Saidi. All rights reserved.
//

import SwiftUI

/**
 This context can be used to present toasts over a view.
 
 To use this context within your view, create an instance of
 it then call `present(_ text: String)` to show a plain text
 toast, or call `present<Content: View>(_ content: Content)`
 to present a custom view as a toast.
 
 To bind a toast to a view, use the `keyboardToast` modifier:
 
 ```swift
 .keyboardToast(context: context, background: ...)
 ```
 
 Note that the context only manages the toast content, since
 the appearance can be set with the `toast` modifier.
 ```
 */
public class KeyboardToastContext: ObservableObject {
    
    public init() {}
    
    @Published public var isActive = false
    @Published public var content = AnyView(EmptyView())
    
    public var isActiveBinding: Binding<Bool> {
        .init(get: { self.isActive },
              set: { self.isActive = $0 }
        )
    }
    
    public func present(_ text: String) {
        present(Text(text).multilineTextAlignment(.center))
    }
    
    public func present<Content: View>(_ content: Content) {
        self.content = AnyView(content)
        self.isActive = true
    }
}
