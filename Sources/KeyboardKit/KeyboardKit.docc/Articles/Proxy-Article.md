# Proxy Utilities

This article describes the KeyboardKit proxy engine and its utilities.

iOS keyboard extensions use a **UITextDocumentProxy** to integrate with the currently selected text field. It lets you insert and delete text, get the selected text, move the input cursor, etc.

The native proxy APIs are however quite limited, which makes it hard to get detailed information about the text and perform many standard keyboard operations. 

For instance, you have to manually write code to get the current word or sentence, understand where the cursor is, perform more sophisticated proxy operations, etc.

KeyboardKit adds a bunch of proxy extension to make things easier. ``KeyboardInputViewController`` also has a custom ``KeyboardInputViewController/textDocumentProxy`` that lets you do even more. 

[KeyboardKit Pro][Pro] adds even more proxy capabilities, such as the ability to read the full document context (content). Information about Pro features can be found at the end of this article. 



## Proxy namespace

KeyboardKit has a ``Proxy`` namespace that contains proxy-related types.

This namespace doesn't contain protocols, open classes or types of higher importance. For now, it only contains types when it's part of the KeyboardKit Pro build.



## Extensions

Since **UITextDocumentProxy** extensions are not included in the generated documentation, here is a list of extensions that you get access to by just importing KeyboardKit:


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

[KeyboardKit Pro][Pro] unlocks additional text document proxy capabilities, such as the ability to read the full document context (content) instead of the limited text you get access to by default.


### How to read the full document context

As you may have noticed, the **UITextDocumentProxy**  **documentContextBeforeInput** and **documentContextAfterInput** don't always return *all* text before and after the input cursor. 

Any new paragraph may stop the proxy from reading more content. This makes it hard to build more complex features, like proof-reading, AI-based features, etc.

KeyboardKit Pro therefore unlocks additional proxy extensions that let you read all text from the proxy, by moving the text cursor in careful ways to unlock more content. 

To read all the available text in the proxy, just use the **fullDocumentContext** alternatives instead of **documentContext**:

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

These functions read document by moving the input cursor to unlock more text. It's not a fail-safe operation, but has been tweaked to provide as accurate results as possible.

You can pass in a custom configuration to configure the read operation. It lets you tweak factors like sleep time and how many times to try to read more content at the detected end.

Since the full document context functions are `async`, you need to wrap them in a task when calling them from SwiftUI, or any non-async context.


[Pro]: https://github.com/KeyboardKit/KeyboardKitPro
