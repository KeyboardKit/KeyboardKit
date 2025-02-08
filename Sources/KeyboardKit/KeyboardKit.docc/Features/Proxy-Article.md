# Proxy Utilities

This article describes the KeyboardKit proxy engine and its utilities.

@Metadata {

    @PageImage(
        purpose: card,
        source: "Page",
        alt: "Page icon"
    )
}

iOS keyboards use a ``UIKit/UITextDocumentProxy`` to integrate with the currently selected text field. The proxy lets you insert and delete text, get the currently selected text, move the input cursor, etc.

The native APIs are however quite limited, and make it hard to get detailed text information and to perform many standard operations. For instance, you have to write code to get the current word or sentence, understand where the cursor is, etc.

KeyboardKit therefore extends ``UIKit/UITextDocumentProxy`` to make things easier. ``KeyboardInputViewController`` also has a custom ``KeyboardInputViewController/textDocumentProxy`` that lets you do even more. 

👑 [KeyboardKit Pro][Pro] also unlocks ways for a ``UIKit/UITextDocumentProxy`` to read the full content of the current document. Information about Pro features can be found further down.



## Namespace

KeyboardKit has a ``Proxy`` namespace with proxy-related types. It currently only contains utils when it's part of a KeyboardKit Pro build.



## Extensions

KeyboardKit extends the native ``UIKit/UITextDocumentProxy`` with additional capabilities, such as the ability to get more content from the document, analyze words, sentences & quotations, end the current sentence, etc.

Here are some examples of extensions that are added to the proxy by KeyboardKit, to make it much more capable than it is by default, with more variants of certain operations listed in the full ``UIKit/UITextDocumentProxy`` documentation:

* ``UIKit/UITextDocumentProxy/currentWord``
* ``UIKit/UITextDocumentProxy/deleteBackward(range:)``
* ``UIKit/UITextDocumentProxy/deleteBackward(times:)``
* ``UIKit/UITextDocumentProxy/documentContext``
* ``UIKit/UITextDocumentProxy/endSentence(withText:)``
* ``UIKit/UITextDocumentProxy/fullDocumentContext(config:)``
* ``UIKit/UITextDocumentProxy/hasUnclosedQuotationBeforeInput(for:)``
* ``UIKit/UITextDocumentProxy/isCursorAtNewSentence``
* ``UIKit/UITextDocumentProxy/isCursorAtNewWord``
* ``UIKit/UITextDocumentProxy/isCursorAtTheEndOfTheCurrentWord``
* ``UIKit/UITextDocumentProxy/isReadingFullDocumentContext``
* ``UIKit/UITextDocumentProxy/replaceCurrentWord(with:)``
* ``UIKit/UITextDocumentProxy/sentenceBeforeInput``
* ``UIKit/UITextDocumentProxy/sentenceDelimiters``
* ``UIKit/UITextDocumentProxy/wordBeforeInput``
* ``UIKit/UITextDocumentProxy/wordDelimiters``

See the ``UIKit/UITextDocumentProxy`` documentation for more information and a full list of extension that are applied by KeyboardKit.



---


## 👑 KeyboardKit Pro

[KeyboardKit Pro][Pro] unlocks additional ``UIKit/UITextDocumentProxy`` capabilities, like the ability to read the full document content instead of just the content closest to the input cursor.


### Full Document Context

Apple's native text document proxy doesn't return all the text within the document. It instead cuts off the available text at any time, e.g. at the previous or next paragraph. This makes it hard to provide AI-based features that require more context.

KeyboardKit Pro therefore unlocks ``UIKit/UITextDocumentProxy/fullDocumentContext(config:)`` proxy extensions that let you read **all** text from the proxy:

```swift
let proxy = keyboardContext.textDocumentProxy
let result = try await proxy.fullDocumentContext()
```

This will provide you with all the text before and after the input cursor, as well as an aggregate of all the available text in the document. 

> Note: The full document read operation is a best effort operation, that makes the most of the very limited capabilities that are provided by the operating system. It's not guaranteed to return a valid result. You can configure the operation to yield better results, for instance by waiting longer when moving the input cursor, try to move more times around the edges, etc.
