//
//  KeyboardTextContext.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2023-01-22.
//  Copyright © 2023 Daniel Saidi. All rights reserved.
//

import Combine
import Foundation

/**
 This class provides keyboard extensions with contextual and
 observable information about the text in the document proxy.

 You can get this information directly from the proxy or the
 keyboard context, but this class makes that text observable.
 
 These properties are not added to ``KeyboardContext`` since
 it would cause any views that use that context to re-render
 whenever the text changes.
 
 KeyboardKit automatically creates an instance of this class
 and binds it to ``KeyboardInputViewController/keyboardState``
 when the keyboard is created. 
 */
public class KeyboardTextContext: ObservableObject {

    /**
     Create a context instance.
     */
    public init() {}

    /**
     The document context (content) before the input cursor.

     Note that for longer texts, this will most often not be
     the full content, since keyboard extensions get limited
     text back from the proxy. KeyboardKit Pro unlocks a way
     to read the full document context.
     */
    @Published
    public var documentContextBeforeInput: String?

    /**
     The document context (content) after the input cursor.

     Note that for longer texts, this will most often not be
     the full content, since keyboard extensions get limited
     text back from the proxy. KeyboardKit Pro unlocks a way
     to read the full document context.
     */
    @Published
    public var documentContextAfterInput: String?

    /**
     The currently selected text, if any.

     Note that for longer texts, this will most often not be
     the full content, since keyboard extensions get limited
     text back from the proxy.
     */
    @Published
    public var selectedText: String?
}

public extension KeyboardTextContext {

    /**
     Get the before and after document context combined.

     Note that for longer texts, this will most often not be
     the full content, since keyboard extensions get limited
     text back from the proxy. KeyboardKit Pro unlocks a way
     to read the full document context.
     */
    var documentContext: String? {
        let before = documentContextBeforeInput ?? ""
        let after = documentContextAfterInput ?? ""
        return before + after
    }
}

#if os(iOS) || os(tvOS)
public extension KeyboardTextContext {

    /**
     Sync the context with the current state of the keyboard
     input view controller.
     */
    func sync(with controller: KeyboardInputViewController) {
        DispatchQueue.main.async {
            self.syncAfterAsync(with: controller)
        }
    }
}

extension KeyboardTextContext {

    /**
     Perform this after an async delay, to make sure that we
     have the latest information.
     */
    func syncAfterAsync(with controller: KeyboardInputViewController) {
        let proxy = controller.textDocumentProxy
        if documentContextBeforeInput != proxy.documentContextBeforeInput {
            documentContextBeforeInput = proxy.documentContextBeforeInput
        }
        if documentContextAfterInput != proxy.documentContextAfterInput {
            documentContextAfterInput = proxy.documentContextAfterInput
        }
        if selectedText != proxy.selectedText {
            selectedText = proxy.selectedText
        }
    }
}
#endif
