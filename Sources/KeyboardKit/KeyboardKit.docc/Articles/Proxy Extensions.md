# Proxy Extensions

This article describes how KeyboardKit extends `UITextDocumentProxy` with a lot of additional functionality.

Keyboard input view controllers have a `textDocumentProxy`, which is the way a keyboard integrates with the currently active app. It lets you insert and remove text, move the cursor forward and backward etc. 

However, its capabilities are very basic and requires you to implement a bunch of functionality if you want your keyboard to do more things.

KeyboardKit therefore provides you with a lot of `UITextDocumentProxy` extensions that make the proxy more capable. Some have to work around the limitiations of what an iOS keyboard extension can do, but overall they make a lot of operations easier to perform. 

Since extensions are not included in the generated documentation, this article describes the extensions you get to by simply importing KeyboardKit. In fact, you could import KeyboardKit just to get access to these extensions and ignore all other parts of the library, and it would still bring a lot of value.

[KeyboardKit Pro][Pro] specific extensions are described at the end of this document.



## Autocomplete

KeyboardKey defines a couple of autocomplete-specific extensions that are used by the library.

- `hasAutocompleteInsertedSpace`
- `hasAutocompleteRemovedSpace`
- `insertAutocompleteSuggestion(:tryInsertSpace)`
- `tryInsertSpaceAfterAutocomplete()`
- `tryReinsertAutocompleteRemovedSpace()`
- `tryRemoveAutocompleteInsertedSpace`

You will probably not have to use these extensions, but they are there for you if you ever need them.



## Content

KeyboardKit defines two content-specific extensions:

- `trimmedDocumentContextAfterInput`
- `trimmedDocumentContextBeforeInput`

Note that the proxy doesn't have access to all text in the text document, but will only give you the text closest to the input cursor. [KeyboardKit Pro][Pro] however adds ways to get all the text. 



## Delete

KeyboardKit extends the text document proxy's by default limited functionality of only being able to delete backwards a single time:

- `deleteBackward(times:)`
- `deleteBackward(range:)`

This makes it easier to e.g. delete an entire word or sentence. 



## Quotation

KeyboardKit defines two functions for analyzing the current quotation state:

- `isOpenAlternateQuotationBeforeInput(for:)`
- `isOpenQuotationBeforeInput(for:)`

These properties let you check if there are an unclosed quotation before the text input cursor.

The quotation and alternate quotation characters differ between locales, which is why you need to provide a `Locale`. 



## Replacements

KeyboardKit defines a function for getting preferred text replacements:

- `preferredReplacement(for:locale:)`

This function is for instance used to replace an opening quotation if the text actually needs a closing quotation.



## Sentences

KeyboardKit defines a bunch of sentence-specific extensions:

- `isCursorAtNewSentence`
- `isCursorAtNewSentenceWithSpace`
- `sentenceBeforeInput`
- `sentenceDelimiters`
- `endSentence()`

These properties and functions make it easier to work with sentences.


## Words

KeyboardKit defines a bunch of word-specific extensions:

- `currentWord`
- `currentWordPreCursorPart`
- `currentWordPostCursorPart`
- `hasCurrentWord`
- `isCursorAtNewWord`
- `isCursorAtTheEndOfTheCurrentWord`
- `wordBeforeInput`
- `wordDelimiters`
- `replaceCurrentWord(with replacement: String)`

These properties and functions make it easier to work with words.



## 👑 Pro features

[KeyboardKit Pro][Pro] unlocks additional text document proxy capabilities.


### Getting the full document context

As you may have noticed, The `UITextDocumentProxy` `documentContextBeforeInput` and `documentContextAfterInput` properties don't return *all* content before and after the text input cursor,. Any line break may at any time stop the proxy from reading more content, which makes it hard to do more complex operations from a keyboard extension, such as proof-reading a document.

KeyboardKit Pro therefore unlocks some `UITextDocumentProxy` extensions that let you access all text from the proxy:

- `func fullDocumentContext() async throws -> FullDocumentContextResult`
- `func fullDocumentContextBeforeInput() async throws -> String`
- `func fullDocumentContextAfterInput() async throws -> String`

`fullDocumentContext()` resolves all text before and after the input, while the others can be used if you just need the text before or after the input.

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

Note that calling these functions will cause the keyboard extension to navigate through the entire text mass by moving the input cursor around in the text document, after which it will try to return the cursor to its original position.

Since this feature is new and the way it works uses unreliable operations, please report any incorrect behavior so that it can be improved if needed.



[Pro]: https://github.com/KeyboardKit/KeyboardKitPro
