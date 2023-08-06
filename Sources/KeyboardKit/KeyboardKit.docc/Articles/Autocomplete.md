# Autocomplete

This article describes the KeyboardKit autocomplete engine.

In KeyboardKit, an ``AutocompleteProvider`` can be used to provide autocomplete suggestions as the user types, triggers actions and moves the input cursor.

KeyboardKit doesn't have a standard provider as it has for most other services. Instead, it will use a ``DisabledAutocompleteProvider`` until you register a real one.

[KeyboardKit Pro][Pro] unlocks a local and a remote autocomplete provider implementation when you register a valid license. Information about these providers can be found at the end of this article.



## How to perform autocomplete

KeyboardKit will automatically call ``KeyboardController/performAutocomplete()`` as the user types, triggers actions and moves the input cursor. 

This will update the ``KeyboardInputViewController/autocompleteContext``, which causes views like ``AutocompleteToolbar`` to automatically update to show the latest suggestions.

If you ever need to reset the current autocomplete state, you can call the controller's ``KeyboardController/resetAutocomplete()`` or the context's ``AutocompleteContext/reset()`` functions.



## How to customize the autocomplete behavior

You can customize the autocomplete behavior by replacing ``KeyboardInputViewController/autocompleteProvider`` with a custom implementation or overriding the various controller functions.  

For instance, ``KeyboardInputViewController/autocompleteText`` is used to determine which text to pass into the provider. It uses ``KeyboardInputViewController/textDocumentProxy`` by default, but you can override it to customize which text to use.

If you want to temporarily or permanently disable autocomplete, just set the ``AutocompleteContext`` ``AutocompleteContext/isEnabled`` property to `false`.



## How to create a custom autocomplete provider

You can create a custom ``AutocompleteProvider`` to use any 3rd party service, SDK or api.

For instance, here's a custom provider that just adds a suffix to the provided text's current word:

```swift
class CustomAutocompleteProvider: AutocompleteProvider {
    
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

private extension CustomAutocompleteProvider {
    
    func suggestions(for text: String) -> [AutocompleteSuggestion] {
        [
            suggestion(text + "ly"),
            suggestion(text + "er", "Subtitle"),
            suggestion(text + "ter")
        ]
    }
    
    func suggestion(_ word: String, _ subtitle: String? = nil) -> AutocompleteSuggestion {
        AutocompleteSuggestion(
            text: word, 
            title: word, 
            subtitle: subtitle
        )
    }
}
```

To use this provider instead of the standard one, just set the input controller's ``KeyboardInputViewController/autocompleteProvider`` to your custom provider, like this:

```swift
class KeyboardViewController: KeyboardInputViewController {

    override func viewDidLoad() {
        autocompleteProvider = CustomAutocompleteProvider()
        super.viewDidLoad()
    }
}
```

This will make KeyboardKit use your custom implementation instead of the standard one.



## Views

KeyboardKit has a bunch of autocomplete-related views. 

For instance, the ``AutocompleteToolbar`` can be used to mimic a native iOS autocomplete toolbar. 

```swift
struct KeyboardView: View {

    // IMPORTANT: Make sure to use an unowned reference
    unowned var controller: KeyboardInputViewController
    
    @EnvironmentObject
    private var autocompleteContext: AutocompleteContext

    @EnvironmentObject
    private var keyboardContext: KeyboardContext

    var body: some View {
        VStack(spacing: 0) {
            autocompleteToolbar
            SystemKeyboard(
                controller: controller,
                autocompleteToolbar: .none
            )
        }
    }
}

private extension KeyboardView {

    var autocompleteToolbar: some View {
        AutocompleteToolbar(
            suggestions: autocompleteContext.suggestions,
            locale: keyboardContext.locale,
            suggestionAction: controller.insertAutocompleteSuggestion
        ).opacity(keyboardContext.prefersAutocomplete ? 1 : 0)  // Always allocate height to make room for callouts
    }
}
```

The ``SystemKeyboard`` will by default add an autocomplete toolbar unless you tell it not to.    



## 👑 Pro features

[KeyboardKit Pro][Pro] unlocks additional autocomplete providers and utilities.


### Local autocomplete provider

KeyboardKit Pro unlocks and sets up a `LocalAutocompleteProvider` when you register a valid license. You can inherit and customize this class to modify its default behavior.

The local provider uses on-device capabilities to perform autocomplete. It works offline, doesn't require full access and integrates with other system components, like the on-device lexicon.

This provider currently doesn't provide next word prediction, which means that no suggestion will be given when you end a word or sentence. 


### Remote autocomplete provider

KeyboardKit Pro also unlocks an `RemoteAutocompleteProvider` that can be configured to communicate with any APIs or web service. 

Since most autocomplete APIs require an API token or some form of authentication, the demo app doesn't include a remote provider demo keyboard.



[Pro]: https://github.com/KeyboardKit/KeyboardKitPro
