# Understanding Proxy Utilities

This article describes the KeyboardKit proxy engine.

iOS keyboard extensions use the native **UITextDocumentProxy** to integrate with the currently active application. It lets you insert and delete text, get the selected text, move the input cursor, etc.

The native proxy APIs are however quite limited, which makes it hard to get detailed information and perform many standard keyboard operations. For instance, you have to manually write code to get the current word, understand where the cursor is, etc.

KeyboardKit adds a bunch of **UITextDocumentProxy** extension to make things easier. ``KeyboardInputViewController`` also has a custom ``KeyboardInputViewController/textDocumentProxy`` property that lets you do more than with the native proxy. 

[KeyboardKit Pro][Pro] adds even more proxy capabilities, such as the ability to read the full document context. Information about Pro features can be found at the end of this article. 



## Proxy namespace

KeyboardKit has a ``Proxy`` namespace that contains proxy-related types.

For now, this namespace will only contain types when it's part of the KeyboardKit Pro build.

The namespace doesn't contain protocols, open classes or types that are meant to be top-level ones. It's meant to contain types used by top-level types, to make the library easier to overview.



## Extensions

Since **UITextDocumentProxy** extensions are not included in the generated documentation, here is a list of extensions that you get access to by simply importing KeyboardKit into your project:


### Autocomplete

- hasAutocompleteInsertedSpace
- hasAutocompleteRemovedSpace
- insertAutocompleteSuggestion(_:tryInsertSpace:)
- tryInsertSpaceAfterAutocomplete()
- tryReinsertAutocompleteRemovedSpace()
- tryRemoveAutocompleteInsertedSpace

### Content

- documentContext  
- isReadingFullDocumentContext

### Delete

- deleteBackward(range:)
- deleteBackward(times:)

### Quotation

- hasUnclosedQuotationBeforeInput(for:)
- hasUnclosedAlternateQuotationBeforeInput(for:)
- preferredQuotationReplacement(whenInserting:for:)

### Sentences

- isCursorAtNewSentence
- isCursorAtNewSentenceWithTrailingWhitespace
- sentenceBeforeInput
- sentenceDelimiters
- endSentence()

### Words

- currentWord
- currentWordPreCursorPart
- currentWordPostCursorPart
- hasCurrentWord
- isCursorAtNewWord
- isCursorAtTheEndOfTheCurrentWord
- wordBeforeInput
- replaceCurrentWord(with replacement: String)



## 👑 Pro features

[KeyboardKit Pro][Pro] unlocks additional text document proxy capabilities when you register a valid license.

The Silver and Gold licenses provide ways to read the full document context from the text document proxy, instead of the limited text amount you can read by default.


### How to read the full document context

As you may have noticed, the proxy's **documentContextBeforeInput** and **documentContextAfterInput** properties don't return all text before and after the input cursor. Any new paragraph may at any time stop the proxy from reading more content.

This makes it hard to perform more complex operations, such as proof-reading a document, provide AI-based functionality, etc.

KeyboardKit Pro therefore unlocks additional **UITextDocumentProxy** extensions to let you read all text from the text document proxy:

- fullDocumentContext(_:)
- fullDocumentContextBeforeInput(_:)
- fullDocumentContextAfterInput(_:)

These async functions tries to read the full document text by moving the input cursor back and forward to get access to more text. It's not a fail-safe operation, but has been tweaked to provide as accurate results as possible to as many device types as possible.

Calling these functions will cause the keyboard extension to navigate through the entire text mass by moving the input cursor around in the text document, after which it will return the cursor to its original position.


### How to configure the full document read operation

If you need to configure the read operation, you can pass in a custom **Proxy.FullDocumentConfiguration** that lets you tweak factors like sleep time and how many times to try to read more content at the detected end.


### How to use async functions in SwiftUI

Since the full document context functions are `async`, you need to wrap them in a task when calling them from SwiftUI, for instance:

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


[Pro]: https://github.com/KeyboardKit/KeyboardKitPro
