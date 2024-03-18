# Autocomplete

This article describes the KeyboardKit autocomplete engine.

Autocomplete is an important part of the typing experience, where suggestions are shown as the user types.

In KeyboardKit, an ``AutocompleteProvider`` can be used to provide suggestions, which in turn can be presented in views like the ``Autocomplete/Toolbar``.

KeyboardKit doesn't have a standard autocomplete provider. Instead, it injects a disabled provider into ``KeyboardInputViewController/services`` until you replace it with a custom provider or activate KeyboardKit Pro.

[KeyboardKit Pro][Pro] unlocks local and remote autocomplete. More information about Pro features can be found at the end of this article.



## Autocomplete namespace

KeyboardKit has an ``Autocomplete`` namespace that contains autocomplete-related types.

This namespace doesn't have protocols, open classes, or types that are meant to be top-level.



## Autocomplete context

KeyboardKit has an observable ``AutocompleteContext`` that can handle autocomplete state, such as if autocomplete is enabled, which suggestions to present, etc.

KeyboardKit automatically creates an instance of this class and injects it into ``KeyboardInputViewController/state``, then updates it whenever autocomplete is performed.



## How to perform autocomplete

KeyboardKit will automatically call ``KeyboardController/performAutocomplete()`` whenever the text changes, then update the ``KeyboardInputViewController/state`` context with suggestions from the ``KeyboardInputViewController/services`` provider.

Views like ``Autocomplete/Toolbar`` will automatically present the latest suggestions, and handle any tapped suggestion with the main ``KeyboardActionHandler``.



## How to disable autocomplete and autocorrect

You can set the state context's ``AutocompleteContext/isAutocorrectEnabled`` to **false** to disable autocorrection, and set ``AutocompleteContext/isAutocompleteEnabled`` to **false** tp disable autocomplete altogether.

You can also disable autocorrection by applying an **.autocorrectionDisabled()** view modifier to the keyboard view hierarchy.



## How to customize the autocomplete behavior

You can customize the autocomplete behavior by replacing the ``KeyboardInputViewController/services`` provider with a custom ``AutocompleteProvider`` implementation.

You can also customize the controller's autocomplete behavior by overriding the various ``KeyboardInputViewController`` functions and properties.

For instance, ``KeyboardInputViewController/autocompleteText`` determines which text to use for autocomplete. It uses ``KeyboardInputViewController/textDocumentProxy`` by default, but you can override it to customize which text to use.



## How to create a custom autocomplete provider

You can replace the ``KeyboardInputViewController/services`` autocomplete provider with a custom provider, for instance to integrate with a custom SDK or 3rd party provider.

For instance, here's a custom provider that just adds a suffix to the provided text's current word:

```swift
class CustomAutocompleteProvider: AutocompleteProvider {

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

private extension CustomAutocompleteProvider {
    
    func fakeSuggestions(for text: String) -> [Autocomplete.Suggestion] {
        [
            .init(text: text, isUnknown: true),
            .init(text: text, isAutocorrect: true),
            .init(text: text, subtitle: "Subtitle")
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

To use this provider instead of the standard one, just inject it into ``KeyboardInputViewController/services``:

```swift
class KeyboardViewController: KeyboardInputViewController {

    override func viewDidLoad() {
        services.autocompleteProvider = CustomAutocompleteProvider()
        super.viewDidLoad()
    }
}
```

This will make KeyboardKit use your custom implementation instead of the standard one.



## Views

KeyboardKit has an ``Autocomplete/Toolbar``, that mimics a native autocomplete toolbar.

![AutocompleteToolbar](autocompletetoolbar-350.jpg)

The bar can be customized, and styled with ``KeyboardStyle/AutocompleteToolbar``:

![AutocompleteToolbar](autocompletetoolbar-styled-350.jpg)

The ``Autocomplete`` namespace also has other view that you can use as standalone view as well, like ``Autocomplete/ToolbarItem`` and ``Autocomplete/ToolbarSeparator``. 



## 👑 Pro features

[KeyboardKit Pro][Pro] unlocks additional providers and injects a **LocalAutocompleteProvider** into ``KeyboardInputViewController/services`` when you register your license key.

These providers are open to inheritance, so you can inherit and customize them to modify their default behavior.

### LocalAutocompleteProvider

This provider performs autocomplete on device. It works offline, doesn't require Full Access and integrates with other system services, like the local lexicon. 

> Important: This provider currently doesn't provide next word prediction. 

### RemoteAutocompleteProvider

This provider can be used to integrate with external REST-based APIs and web services. It requires that the device is online and that Full Access is enabled, to make network requests. 


[Pro]: https://github.com/KeyboardKit/KeyboardKitPro
