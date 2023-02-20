//
//  KeyboardTextContext.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2023-01-22.
//  Copyright © 2023-2023 Daniel Saidi. All rights reserved.
//

import Foundation

/**
 This class provides keyboard extensions with contextual and
 observable information about the text in the document proxy.

 KeyboardKit automatically creates an instance of this class
 and binds the created instance to the keyboard controller's
 ``KeyboardInputViewController/keyboardTextContext``.

 You can get this information directly from the proxy, using
 either the controller or the ``KeyboardContext`` to get the
 proxy instance, but the controller will continously sync it
 from the proxy to the context to let you observe it as well.
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
     to read the full document context, so have a look at it
     if you need this functionality.
     */
    @Published
    public var documentContextBeforeInput: String?

    /**
     The document context (content) after the input cursor.

     Note that for longer texts, this will most often not be
     the full content, since keyboard extensions get limited
     text back from the proxy. KeyboardKit Pro unlocks a way
     to read the full document context, so have a look at it
     if you need this functionality.
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
     to read the full document context, so have a look at it
     if you need this functionality.
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
