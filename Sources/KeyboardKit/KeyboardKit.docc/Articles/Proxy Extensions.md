# Proxy Extensions

This article describes the KeyboardKit `UITextDocumentProxy` extension engine.

A ``KeyboardInputViewController`` has a `textDocumentProxy`, which is the way the keyboard extension is expected to integrate with the active app. 

The proxy lets you insert and remove text, move the cursor, etc. The native APIs are however very basic and require you to implement a lot of functionality to do more advanced things. 

KeyboardKit therefore adds a bunch of extensions that make the proxy more capable. Some have to work around various system limitiations, but overall they unlock many new capabilities. 

[KeyboardKit Pro][Pro] specific extensions are described at the end of this document.



## Extensions

Since extensions are not included in the generated documentation, this article describes the extensions you get to by simply importing KeyboardKit.


### Autocomplete

- `hasAutocompleteInsertedSpace`
- `hasAutocompleteRemovedSpace`
- `insertAutocompleteSuggestion(:tryInsertSpace)`
- `tryInsertSpaceAfterAutocomplete()`
- `tryReinsertAutocompleteRemovedSpace()`
- `tryRemoveAutocompleteInsertedSpace`

### Content

- `documentContext`

### Delete

- `deleteBackward(range:)`
- `deleteBackward(times:)`

### Quotation

- `hasUnclosedQuotationBeforeInput(for:)`
- `hasUnclosedAlternateQuotationBeforeInput(for:)`
- `preferredQuotationReplacement(whenInserting:for:)`

### Sentences

- `isCursorAtNewSentence`
- `isCursorAtNewSentenceWithTrailingWhitespace`
- `sentenceBeforeInput`
- `sentenceDelimiters`
- `endSentence()`

### Words

- `currentWord`
- `currentWordPreCursorPart`
- `currentWordPostCursorPart`
- `hasCurrentWord`
- `isCursorAtNewWord`
- `isCursorAtTheEndOfTheCurrentWord`
- `wordBeforeInput`
- `wordDelimiters`
- `replaceCurrentWord(with replacement: String)`



## 👑 Pro features

[KeyboardKit Pro][Pro] unlocks additional text document proxy capabilities.


### Getting the full document context

As you may have noticed, `documentContextBeforeInput` and `documentContextAfterInput` don't return *all* text before and after the input cursor. Any line breaks may at any time stop the proxy from reading more content, which makes it hard to do more complex operations from a keyboard extension, such as proof-reading a document, provide AI-based functionality etc.

KeyboardKit Pro therefore unlocks some `UITextDocumentProxy` extensions that let you read all text from the proxy:

- `func fullDocumentContext() async throws -> FullDocumentContextResult`
- `func fullDocumentContextBeforeInput() async throws -> String`
- `func fullDocumentContextAfterInput() async throws -> String`

They all read the text by moving the input cursor around to get access to more text.

Since these functions are `async`, you need to wrap them in a task when calling them from SwiftUI, for instance:

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

Note that calling these functions will cause the keyboard extension to navigate through the entire text mass by moving the input cursor around in the text document, after which it will return the cursor to its original position.



[Pro]: https://github.com/KeyboardKit/KeyboardKitPro
