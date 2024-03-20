# Proxy Utilities

This article describes the KeyboardKit proxy engine and its utilities.

iOS keyboard extensions use a **UITextDocumentProxy** to integrate with the currently selected text field. The proxy lets you insert and delete text, get the currently selected text, move the input cursor, etc.

The native APIs are however quite limited, and make it hard to get detailed text information and to perform many standard operations. 

For instance, you have to write code to get the current word or sentence, understand where the cursor is, perform more sophisticated text document proxy operations, etc.

KeyboardKit therefore adds a bunch of extension to the `UITextDocumentProxy` to make things easier. ``KeyboardInputViewController`` also has a custom ``KeyboardInputViewController/textDocumentProxy`` that lets you do even more. 

👑 [KeyboardKit Pro][Pro] adds even more proxy capabilities, such as the ability to read the full document context (content). Information about Pro features can be found at the end of this article. 



## Proxy namespace

KeyboardKit has a ``Proxy`` namespace that contains proxy-related types.

This namespace doesn't contain protocols, open classes or types of higher importance. For now, it only contains types when it's part of the KeyboardKit Pro build.



## Extensions

KeyboardKit extends the native **UITextDocumentProxy** type with a lot of additional capabilities. Here's a list of extensions that you get access to by just importing KeyboardKit:


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

[KeyboardKit Pro][Pro] unlocks additional text document proxy capabilities, such as the ability to read the full document context (content) instead of just the limited text that you get access to by default.


### How to read the full document context

As you may have noticed, the **UITextDocumentProxy**  **documentContextBeforeInput** and **documentContextAfterInput** don't always (most often, actually) return all text before and after the input cursor.

Instead, the proxy has very limited access to the document. Any new paragraph or content may stop it from reading more content from the document, and only lets you access a partial text result.

This limitation makes it hard to build more complex features, like proof-reading and spellchecking the text, use AI-based features, etc.

KeyboardKit Pro therefore unlocks additional capabilities that make it possible for the context to read all text from the proxy, by moving the text cursor in careful ways to unlock more content. 

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

These functions are async, since they will read the document by moving the input cursor in intricate ways. It's not a fail-safe operation, but has been tweaked to provide as accurate results as possible.

You can pass in a custom configuration to configure the read operation. It lets you tweak factors like sleep time and how many times to try to read more content at the detected end.

Since the full document context functions are async, you must wrap them in a task when calling them from SwiftUI or non-async places.


[Pro]: https://github.com/KeyboardKit/KeyboardKitPro
