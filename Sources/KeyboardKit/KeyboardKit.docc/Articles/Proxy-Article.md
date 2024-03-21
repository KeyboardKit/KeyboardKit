# Proxy Utilities

This article describes the KeyboardKit proxy engine and its utilities.

iOS keyboard extensions use a **UITextDocumentProxy** to integrate with the currently selected text field. The proxy lets you insert and delete text, get the currently selected text, move the input cursor, etc.

The native APIs are however quite limited, and make it hard to get detailed text information and to perform many standard operations. For instance, you have to write code to get the current word or sentence, understand where the cursor is, etc.

KeyboardKit therefore adds a bunch of extension to the `UITextDocumentProxy` to make things easier. ``KeyboardInputViewController`` also has a custom ``KeyboardInputViewController/textDocumentProxy`` that lets you do even more. 

👑 [KeyboardKit Pro][Pro] adds even more proxy capabilities, such as the ability to read the full content of the current document. Information about Pro features can be found at the end of this article. 



## Proxy namespace

KeyboardKit has a ``Proxy`` namespace that contains proxy-related types.

This namespace doesn't contain protocols, open classes or types of higher importance. For now, it only contains types when it's part of the KeyboardKit Pro build.



## Extensions

KeyboardKit extends the native ``UIKit/UITextDocumentProxy`` with additional capabilities, such as the ability to get more content from the document, analyze words, sentences & quotations, end the current sentence, etc. Tap the link for more information.



## 👑 Pro features

[KeyboardKit Pro][Pro] unlocks additional ``UIKit/UITextDocumentProxy`` capabilities, like the ability to read the full document content instead of just the content closest to the input cursor.


### How to read the full document context

As you may have noticed, the ``UIKit/UITextDocumentProxy`` ``UIKit/UITextDocumentProxy/documentContext`` functions don't return the full document content before and after the input cursor. Any new line may stop the proxy from looking for more content.

This means that you will most likely only get a partial text result, which makes it hard to build more complex features, like proof-reading a document, use other AI-based features that require more context, etc.

KeyboardKit Pro therefore unlocks additional capabilities to read *all* text from the document, by moving the text cursor in careful ways to unlock more content, then returning the input cursor to the original position.

To read *all* text from the document, just use the **fullDocumentContext** functions instead of the ``UIKit/UITextDocumentProxy/documentContext`` ones:

```swift
struct KeyboardView: View {

    @EnvironmentObject
    private var context: KeyboardContext

    var body: some View {
        VStack {
            Button("Get the full document context") {
                Task {
                    let proxy = context.textDocumentProxy
                    let result = try? await proxy.fullDocumentContext()
                    await MainActor.run {
                        print(result?.fullDocumentContext)
                        print(result?.fullDocumentContextBeforeInput)
                        print(result?.fullDocumentContextAfterInput)
                    }
                }
            }
        }
    }
}
```

These functions are async, since they will read the document by moving the input cursor in intricate ways. It's not a fail-safe operation, but has been tweaked to provide as accurate results as possible with the current approach.

You can pass in a custom configuration to configure the read operation. It lets you tweak factors like sleep time and how many times to try to read more content at the detected end.

Since the full document context functions are async, you must wrap them in a task when calling them from SwiftUI or non-async places.


[Pro]: https://github.com/KeyboardKit/KeyboardKitPro
