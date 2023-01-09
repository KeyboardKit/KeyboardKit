# Autocomplete

This article describes the KeyboardKit autocomplete engine and how to use it.

In KeyboardKit, an ``AutocompleteProvider`` can be used to provide the keyboard with autocomplete suggestions as the user types.

KeyboardKit doesn't have a standard autocomplete provider as it has for most other services, since it is a Pro feature. You can however create your own and integrate with any autocomplete engines, SDKs or services that you want.

[KeyboardKit Pro][Pro] specific features are described at the end of this document.



## How to perform autocomplete

Autocomplete is performed automatically, since ``KeyboardInputViewController`` calls ``KeyboardInputViewController/performAutocomplete()`` when its text changes. You can also call this function at any time to perform an autocomplete operation whenever you want. 

A successful autocomplete operation will update the controller's ``KeyboardInputViewController/autocompleteContext``, after which its ``AutocompleteContext/suggestions`` can be used, for instance by passing them into an ``AutocompleteToolbar``.

The input controller has a ``KeyboardInputViewController/autocompleteText`` property that it uses when performing autocomplete. It uses the ``KeyboardInputViewController/textDocumentProxy`` text before the input cursor by default, but you can override the function to customize this behavior. 

You can also override ``KeyboardInputViewController/performAutocomplete()`` and ``KeyboardInputViewController/resetAutocomplete()`` to customize the default autocomplete behavior. 

If you ever need to reset the current autocomplete state, you can call ``KeyboardInputViewController/resetAutocomplete()`` to reset any existing suggestions.



## How to create a custom provider

You can create a custom ``AutocompleteProvider`` to integrate with an embedded framework, external api etc.

For instance, here's a custom provider that just adds a suffix to the provided text's current word:


```swift
class MyAutocompleteProvider: AutocompleteProvider {
    
    var locale: Locale = .current

    func autocompleteSuggestions(for text: String, completion: AutocompleteCompletion) {
        let word = text.split(by: String.wordDelimiters).last ?? ""
        if text.isEmpty { return completion(.success([])) }
        completion(.success(suggestions(for: text)))
    }
    
    var canIgnoreWords: Bool { false }
    var canLearnWords: Bool { false }
    var ignoredWords: [String] = []
    var learnedWords: [String] = []
    
    func hasIgnoredWord(_ word: String) -> Bool { false }
    func hasLearnedWord(_ word: String) -> Bool { false }
    func ignoreWord(_ word: String) {}
    func learnWord(_ word: String) {}
    func removeIgnoredWord(_ word: String) {}
    func unlearnWord(_ word: String) {}
}

private extension MyAutocompleteProvider {
    
    func suggestions(for text: String) -> [AutocompleteSuggestion] {
        [
            suggestion(text + "ly"),
            suggestion(text + "er", "Subtitle"),
            suggestion(text + "ter")
        ]
    }
    
    func suggestion(_ word: String, _ subtitle: String? = nil) -> AutocompleteSuggestion {
        StandardAutocompleteSuggestion(
            text: word, 
            title: word, 
            subtitle: subtitle)
    }
}
```

To use this provider instead of the standard one, just set the input controller's ``KeyboardInputViewController/autocompleteProvider`` to the new provider:

```swift
class MyKeyboardViewController: KeyboardInputViewController {

    override func viewDidLoad() {
        autocompleteProvider = MyAutocompleteProvider()
        super.viewDidLoad()
    }
}
```

This will make KeyboardKit use your custom implementation instead of the standard one.



## Views

KeyboardKit has a bunch of autocomplete-specific views.  For instance, the ``AutocompleteToolbar`` toolbar can be added above a keyboard, to mimic the iOS keyboard autocomplete toolbar.



## 👑 Pro features

[KeyboardKit Pro][Pro] unlocks additional autocomplete capabilities.


### Standard autocomplete provider

KeyboardKit Pro unlocks a ``StandardAutocompleteProvider`` and applies it to the input controller's ``KeyboardInputViewController/autocompleteProvider`` when a pro license is registered.

The standard provider uses on-devices autocomplete capabilities that generate suggestions that are not comparable in quality with the ones in native iOS keyboards. They will however make your keyboard look and behave more like a native keyboard than if you don't have any autocomplete in place. 

You can inherit this class and customize it if you find that some of its predictions are not what you want.


### Remote autocomplete provider

KeyboardKit Pro also unlocks an ``ExternalAutocompleteProvider``, which can fetch autocomplete suggestions from any external api or data source. It can be customized to great extent, for instance to modify the request url path and parameters. 

Since most autocomplete api:s require a secret api token or some form of authentication, the demo app doesn't include a provider from start. You must create one yourself and manually register it in the Pro demo.



[Pro]: https://github.com/KeyboardKit/KeyboardKitPro
