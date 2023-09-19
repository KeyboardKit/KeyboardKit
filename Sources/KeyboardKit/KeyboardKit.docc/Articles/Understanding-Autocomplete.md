# Understanding Autocomplete

This article describes the KeyboardKit autocomplete engine.

KeyboardKit has an ``Autocomplete`` namespace that contains a bunch of autocomplete-specic types, except protocols and contexts.

An ``AutocompleteProvider`` can be used to provide suggestions as the user types, triggers actions and moves the input cursor.

KeyboardKit doesn't have a standard provider as it has for other services. Instead, it uses a ``DisabledAutocompleteProvider`` until you register a real one.

[KeyboardKit Pro][Pro] unlocks a local and a remote autocomplete provider when you register a valid license. Information about them can be found at the end of this article.



## How to perform autocomplete

KeyboardKit will automatically call ``KeyboardController/performAutocomplete()`` as the user types, triggers actions and moves the input cursor. This updates the ``KeyboardInputViewController/autocompleteContext``, which causes views like ``Autocomplete/Toolbar`` to update.

If you need to reset autocomplete state, you can call the controller's ``KeyboardController/resetAutocomplete()`` or the context's ``AutocompleteContext/reset()`` functions.



## How to customize the autocomplete behavior

You can customize the autocomplete behavior by replacing ``KeyboardInputViewController/autocompleteProvider`` with a custom implementation or overriding the various controller functions.  

For instance, ``KeyboardInputViewController/autocompleteText`` is determines which text to pass into the provider. It uses ``KeyboardInputViewController/textDocumentProxy`` by default, but you can override it to customize which text to use.

If you want to temporarily or permanently disable autocomplete, set the context's ``AutocompleteContext/isEnabled`` property to `false`.



## How to create a custom autocomplete provider

You can create a custom ``AutocompleteProvider`` to use any 3rd party service, SDK or api.

For instance, here's a custom provider that just adds a suffix to the provided text's current word:

```swift
class FakeAutocompleteProvider: AutocompleteProvider {

    init(match: String = "match") {
        self.match = match
    }

    private var match: String
    
    var locale: Locale = .current
    
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
    
    func autocompleteSuggestions(
        for text: String
    ) async throws -> [Autocomplete.Suggestion] {
        guard text.count > 0 else { return [] }
        if text == match {
            return matchSuggestions()
        } else {
            return fakeSuggestions(for: text)
        }
    }
}

private extension FakeAutocompleteProvider {
    
    func fakeSuggestions(for text: String) -> [Autocomplete.Suggestion] {
        [
            .init(text: text + "-1"),
            .init(text: text + "-2", subtitle: "Subtitle"),
            .init(text: text + "-3")
        ]
    }
    
    func fakeSuggestion(_ text: String, _ subtitle: String? = nil) -> Autocomplete.Suggestion {
        .init(text: text, subtitle: subtitle)
    }

    func matchSuggestions() -> [Autocomplete.Suggestion] {
        [
            .init(text: match, isUnknown: true),
            .init(text: match, isAutocorrect: true),
            .init(text: match),
        ]
    }
}
```

To use this provider instead of the standard one, just set ``KeyboardInputViewController/autocompleteProvider`` to this custom provider:

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

The ``Autocomplete`` namespace has a bunch of autocomplete-related views. 

For instance, an ``Autocomplete/Toolbar`` can be used to mimic a native iOS autocomplete toolbar. 

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
        Autocomplete.Toolbar(
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

KeyboardKit Pro unlocks and sets up a LocalAutocompleteProvider when you register a valid license. You can inherit and customize it to modify its default behavior.

This provider uses on-device capabilities to perform autocomplete. It works offline, doesn't require full access and integrates with other system components, like the on-device lexicon.

This provider currently doesn't provide next word prediction. 


### Remote autocomplete provider

KeyboardKit Pro also unlocks a RemoteAutocompleteProvider, which can be used to communicate with external REST-based APIs. 

Since most autocomplete APIs require an API token or some form of authentication, the demo app doesn't demo this provider.



[Pro]: https://github.com/KeyboardKit/KeyboardKitPro
