# Proxy

KeyboardKit defines a bunch of extensions to `UITextDocumentProxy` and ways to route text to other sources.


## Text Input Proxy

KeyboardKit has a `TextInputProxy` class that can be used to implement custom text document proxies.

This makes it possible to add text fields to the keyboard extension and redirect typing from the main app to the text field.

You can redirect typing by setting the `textInputProxy` of the input controller to a custom proxy.

The `KeyboardTextField` and `KeyboardTextView` views does this. You can either use them directly or look to them for inspiration.
 


## UITextDocumentProxy Extensions

KeyboardKit extends the limited `UITextDocumentProxy` functionality with public extensions, that you can use all by themselves, if you dont want to use the rest of the library.

Here are some of the extra properties and functions that KeyboardKit adds to `UITextDocumentProxy`:

### Autocomplete

* `hasAutocompleteInsertedSpace`
* `hasAutocompleteRemovedSpace`
* `insertAutocompleteSuggestion(...)`
* `tryInsertSpaceAfterAutocomplete()`
* `tryReinsertAutocompleteRemovedSpace()`
* `tryRemoveAutocompleteInsertedSpace()`

### Content

* `isCursorAtNewSentence`
* `isCursorAtNewWord`
* `sentenceBeforeInput`
* `wordBeforeInput`
* `sentenceDelimiters`
* `trimmedDocumentContextAfterInput`
* `trimmedDocumentContextBeforeInput`
* `wordDelimiters`
* `endSentence()`

### Current word

* `currentWord`
* `currentWordPreCursorPart`
* `currentWordPostCursorPart`
* `isCursorAtTheEndOfTheCurrentWord`
* `replaceCurrentWord(with:)`

### Delete

* `deleteBackward(times:)`
* `deleteBackward(range:)`

### Quotation

* `isOpenAlternateQuotationBeforeInput(for:)`
* `isOpenQuotationBeforeInput(for:)`

### Replace

* `preferredReplacement(for:locale:)`
