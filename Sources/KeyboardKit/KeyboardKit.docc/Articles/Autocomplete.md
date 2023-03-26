# Autocomplete

This article describes the KeyboardKit autocomplete engine and how to use it.

In KeyboardKit, an ``AutocompleteProvider`` can be used to provide the keyboard with autocomplete suggestions as the user types, triggers actions and moves the input cursor around.

KeyboardKit doesn't have a standard autocomplete provider as it has for most other services. Instead, it will use a disabled provider until you register a real one.

You can unlock a ``LocalAutocompleteProvider`` and an ``ExternalAutocompleteProvider`` with [KeyboardKit Pro][Pro] or create a custom implementation that uses custom logic.

[KeyboardKit Pro][Pro] specific features are described at the end of this document.



## How to perform autocomplete

KeyboardKit will automatically perform autocomplete as the user types, triggers actions and moves the input cursor around. This is done by calling ``KeyboardController/performAutocomplete()``, which is defined by ``KeyboardController`` and implemented by ``KeyboardInputViewController``, whenever autocomplete should be performed. You can also call this function at any time, whenever needed. 

A successful autocomplete operation will update the observable ``KeyboardInputViewController/autocompleteContext``, after which the context's ``AutocompleteContext/suggestions`` can be used, for instance by passing them into an ``AutocompleteToolbar``. If you ever need to reset the current autocomplete state, you can call the controller's ``KeyboardController/resetAutocomplete()`` or the context's ``AutocompleteContext/reset()`` functions.



## How to customize the autocomplete behavior

The most profound way to customize the autocomplete behavior is to replace the ``KeyboardInputViewController/autocompleteProvider``, which is the service that performs autocomplete. 

You can however also tweak the behavior regardless of which engine is used. 

For instance, ``KeyboardInputViewController`` has an ``KeyboardInputViewController/autocompleteText`` property that it uses to determine which text to pass into the provider. It uses the ``KeyboardInputViewController/textDocumentProxy`` text before the input cursor by default, but you can override the property to customize this behavior.

``KeyboardInputViewController`` also has two ``KeyboardInputViewController/performAutocomplete()`` and ``KeyboardInputViewController/resetAutocomplete()`` functions that can be called at any time, and overridden if you want to customize the default autocomplete behavior.



## How to disable autocomplete

If you want to temporarily or permanently disable autocomplete, you can set ``AutocompleteContext/isEnabled`` to `false`.

You can also replace the current ``KeyboardInputViewController/autocompleteProvider`` with a ``DisabledAutocompleteProvider`` to permanently disable autocomplete.



## How to create a custom autocomplete provider

You can create a custom ``AutocompleteProvider`` to integrate with any 3rd party autocomplete engine, SDK, api or service.

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

To use this provider instead of the standard one, just set the input controller's ``KeyboardInputViewController/autocompleteProvider`` to your custom provider:

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

KeyboardKit has a bunch of autocomplete-related views. For instance, the ``AutocompleteToolbar`` can be used to mimic a native iOS autocomplete toolbar:

```swift
struct KeyboardView: View {

    var controller: KeyboardInputViewController
    
    @EnvironmentObject
    private var autocompleteContext: AutocompleteContext

    @EnvironmentObject
    private var keyboardContext: KeyboardContext

    var body: some View {
        VStack(spacing: 0) {
            autocompleteToolbar
            SystemKeyboard(controller: controller)
        }
    }
}

private extension KeyboardView {

    var autocompleteToolbar: some View {
        AutocompleteToolbar(
            suggestions: autocompleteContext.suggestions,
            locale: keyboardContext.locale,
            action: controller.insertAutocompleteSuggestion
        ).opacity(keyboardContext.prefersAutocomplete ? 1 : 0)  // Still allocate height to make room for callouts
    }
}
```

The ``SystemKeyboard`` will however by default add an autocomplete toolbar above itself unless you explicitly tell it not to.    



## 👑 Pro features

[KeyboardKit Pro][Pro] unlocks additional autocomplete providers and utilities.


### Standard autocomplete provider

KeyboardKit Pro unlocks a ``StandardAutocompleteProvider`` and applies it to the input controller's ``KeyboardInputViewController/autocompleteProvider`` when you setup KeyboardKit with a Pro license. You can inherit and customize this class to modify its behavior.

The standard provider uses on-devices capabilities to generate suggestions. It doesn't require full access, works offline and integrates with other system components, like the on-device lexicon.

Note that these standard autocomplete suggestions are not comparable in quality with the ones in a native iOS keyboard. For instance, there's no next word prediction and limited autocorrect. These suggestions will however make your keyboard look and behave more like a native keyboard than if you don't have any autocomplete at all. 


### Remote autocomplete provider

KeyboardKit Pro also unlocks an ``ExternalAutocompleteProvider`` that can fetch autocomplete suggestions from external APIs and data sources. It can be customized to great extent, for instance to modify the request url, parameters and headers. 

Since most autocomplete APIs require a secret api token or some form of authentication, the demo app doesn't include a provider demo. You must create one yourself and manually register it in the Pro demo.



[Pro]: https://github.com/KeyboardKit/KeyboardKitPro
