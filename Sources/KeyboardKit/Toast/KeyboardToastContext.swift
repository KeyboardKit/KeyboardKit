//
//  KeyboardToastContext.swift
//  SwiftUIKit
//
//  Created by Daniel Saidi on 2020-03-18.
//  Copyright © 2020 Daniel Saidi. All rights reserved.
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
 .keyboardToast(isPresented: $context.isActive, content: sheetContext.sheet, background: ...)
 ```
 
 Note that the context only manages the toast content, since
 the background, style etc. can be set when a toast is bound
 to a view.
 ```
 */
public class KeyboardToastContext: ObservableObject {
    
    public init() {}
    
    @Published public var isActive = false
    @Published public var content = AnyView(EmptyView())
    
    public func present(_ text: String) {
        present(Text(text).multilineTextAlignment(.center))
    }
    
    public func present<Content: View>(_ content: Content) {
        self.content = AnyView(content)
        self.isActive = true
    }
}
