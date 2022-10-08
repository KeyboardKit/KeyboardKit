# Understanding Proxy Extensions

This article describes how KeyboardKit extends `UITextDocumentProxy` with a lot of additional functionality.


## Overview

iOS keyboard extensions provide their input view controller with a `textDocumentProxy`, which is the way the keyboard is intended to work with the current text document. It let's you insert text, move the cursor forward and backward, delete backwards etc.

However, this proxy's functionality is very basic, and requires you to implement a bunch of fundamental functionality from scratch if you want your keyboard to do things that you would expect a keyboard to be able to do.

KeyboardKit therefore provides you with a lot of extensions that make the proxy more capable. Some extensions have to work around the limitiations of the keyboard extension, but overall these extensions will make a lot of operations a lot easier to implement. 

Since extensions are not included in the generated documentation, this article describes the extensions you get access to by simply importing KeyboardKit. You could even use these extensions by themselves and ignore all other parts of this library.

[KeyboardKit Pro][Pro] unlocks even more extensions, such as the ability to fetch all the text instead of just the text closest to the input cursor.



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

These extensions are used by the library, but you can probably find some use for them as well. 



## Delete

By default, the proxy only lets you delete backwards a single time. KeyboardKit extends this functionality:

- `deleteBackward(times:)`
- `deleteBackward(range:)`

This makes it easier to e.g. delete an entire word or sentence. 



## Quotation

KeyboardKit defines two functions for analyzing the current quotation state:

- `isOpenAlternateQuotationBeforeInput(for:)`
- `isOpenQuotationBeforeInput(for:)`

These functions are used to know when the keyboard needs to close a currently open quotation. 



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



[Pro]: https://github.com/KeyboardKit/KeyboardKitPro
