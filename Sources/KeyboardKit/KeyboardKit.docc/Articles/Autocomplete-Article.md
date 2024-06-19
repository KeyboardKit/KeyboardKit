# Autocomplete

This article describes the KeyboardKit autocomplete engine.

@Metadata {

    @PageImage(
        purpose: card,
        source: "Page",
        alt: "Page icon"
    )

    @PageColor(blue)
}

Autocomplete is an important part of the typing experience, where suggestions are shown as the user types.

In KeyboardKit, an ``AutocompleteService`` can provide suggestions to an ``AutocompleteContext`` whenever the user types. Unlike other service types, there is no open-source implementation of this protocol.

👑 [KeyboardKit Pro][Pro] unlocks local and remote autocomplete. Information about Pro features can be found at the end of this article.

[Pro]: https://github.com/KeyboardKit/KeyboardKitPro



## Namespace

KeyboardKit has an ``Autocomplete`` namespace that contains autocomplete-related types, models and views.



## Context

KeyboardKit has an observable ``AutocompleteContext`` that handles autocomplete state, such as if autocomplete is enabled, which suggestions to present, etc.

KeyboardKit automatically creates an instance of this class, injects it into ``KeyboardInputViewController/state`` and updates it whenever autocomplete is performed.



## Settings

KeyboardKit has an observable ``AutocompleteSettings`` that handles autocomplete settings, such as how many suggestions to display, whether or not autocomplete and autocorrect is enabled, etc.

KeyboardKit's settings types are observable and will automatically persist any changes made. KeyboardKit will observe these types and sync any changes made to them to their respective contexts, which will automatically update the affected views.

KeyboardKit automatically creates an instance of this class and injects it into ``KeyboardInputViewController/settings``. You can read more about how settings are handled in the <doc:Essentials> and <doc:Settings-Article> articles.



## Services

In KeyboardKit, an ``AutocompleteService`` can provide suggestions when the user types or the text input cursor moves in the text.

KeyboardKit doesn't have a standard autocomplete service implementation. Instead, it injects a disabled service into ``KeyboardInputViewController/services`` until you replace it with your own implementation or register [KeyboardKit Pro][pro].



## How to perform autocomplete

KeyboardKit will automatically call ``KeyboardController/performAutocomplete()`` whenever the keyboard text changes, then update the ``KeyboardInputViewController/state`` context with suggestions from the ``KeyboardInputViewController/services`` ``Keyboard/Services/autocompleteService``.

``KeyboardInputViewController`` has many open autocomplete-related functions that can be used to configure how it performs autocomplete, which text it uses, etc. You can also use the ``AutocompleteContext`` to configure how autocomplete behaves.

However, ieverything eventually comes down to which ``AutocompleteService`` you use. The ``Autocomplete/LocalService`` in [KeyboardKit Pro][pro] will honor all supported configurations, while ``Autocomplete/RemoteService`` will not.

Views like the autocomplete ``Autocomplete/Toolbar`` can list these suggestions and handle suggestion with the main ``KeyboardActionHandler``.



## How to configure autocomplete

You can override any autocomplete-related property or function in ``KeyboardInputViewController``, such as ``KeyboardInputViewController/autocompleteText`` or ``KeyboardInputViewController/performAutocomplete()``, to customize how autocomplete is handled by the controller.

You can also disable autocorrection by applying a ``SwiftUI/View/autocorrectionDisabled(with:)`` view modifier to the keyboard view.

You can use the ``AutocompleteContext`` to perform changes that are not persisted, such as using ``AutocompleteContext/isAutocorrectEnabled`` & ``AutocompleteContext/isAutocompleteEnabled`` to enable or disable autocomplete & autocorrect, ``AutocompleteContext/suggestionsDisplayCount``, etc. 

``AutocompleteContext`` also has an ``AutocompleteContext/autocorrectDictionary`` that can be used to add custom autocorrect text replacements, which for instance will be used by the ``Autocomplete/LocalProvider``.

You can use the ``AutocompleteSettings`` to perform changes that will automatically persist, and  automatically update the context. Settings can also sync between the main app and keyboard extensions. See <doc:Settings-Article> for more information.



## How to create a custom service

You can create a custom autocomplete service to customize the autocomplete behavior, to integrate with 3rd party tools, etc. You can implement ``AutocompleteService`` from scratch, or inherit and customize any of the [KeyboardKit Pro][Pro] services. 

For instance, here's a custom service that just adds a suffix to the current word:

```swift
class CustomAutocompleteService: AutocompleteService {

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

private extension CustomAutocompleteService {
    
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

To use this service instead of the standard one, just inject it into ``KeyboardInputViewController/services``:

```swift
class KeyboardViewController: KeyboardInputViewController {

    override func viewDidLoad() {
        services.actionHandler = CustomActionHandler(inputViewController: self)
        super.viewDidLoad()
    }
}
```

This will make KeyboardKit use your custom service instead of the standard one.



## Views

The ``Autocomplete`` namespace has autocomplete-specific views, that can be used to mimic native autocomplete toolbars and items.

@TabNavigator {
    
    @Tab("Toolbar") {
        
        The autocomplete ``Autocomplete/Toolbar`` mimics a native autocomplete toolbar, and can be used to present autocomplete suggestions to the user:
        
        @Row {
            @Column {}
            @Column(size: 2) {
                ![AutocompleteToolbar](autocompletetoolbar)
            }
            @Column {}
        }
        
        This view can be styled with a ``Autocomplete/ToolbarStyle``, which can be applied with the ``SwiftUI/View/autocompleteToolbarStyle(_:)`` view modifier. It can also use custom ``Autocomplete/ToolbarItem`` & ``Autocomplete/ToolbarSeparator`` views.
    }
    
    @Tab("ToolbarItem") {
        
        The autocomplete-specific ``Autocomplete/ToolbarItem`` and ``Autocomplete/ToolbarSeparator`` views can be used to customize the autocomplete ``Autocomplete/Toolbar``:
        
        @Row {
            @Column {}
            @Column(size: 2) {
                ![AutocompleteToolbar](autocompletetoolbar)
            }
            @Column {}
        }
        
        These views can be styled with the ``Autocomplete/ToolbarItemStyle`` and ``Autocomplete/ToolbarSeparatorStyle`` styles, which can be applied with the ``SwiftUI/View/autocompleteToolbarItemStyle(_:)`` and ``SwiftUI/View/autocompleteToolbarSeparatorStyle(_:)`` view modifiers.
    }
}


## 👑 KeyboardKit Pro

[KeyboardKit Pro][Pro] unlocks additional autocomplete services and injects a ``Autocomplete/LocalService`` into ``KeyboardInputViewController/services`` when you register a valid license key. The pro services are all open to inheritance, so you can inherit and customize them to fit your needs.


### Local Autocomplete

The ``Autocomplete/LocalService`` performs autocomplete operations locally, on-device. It supporst most keyboard locales, works offline, doesn't require Full Access and can integrate with system services, like the local lexicon.

> Important: This service currently doesn't provide next word prediction, since Apple removed these capabilities in iOS 16. 


### Remote Autocomplete

The ``Autocomplete/RemoteService`` can be used to perform autocomplete by integrating with an external API. It requires that the device is online, and requires that Full Access is enabled, to allow it to make network requests.


### Supported Locales

The ``Autocomplete/LocalService`` supports the following locales:

``KeyboardLocale/arabic``, ``KeyboardLocale/bulgarian``, ``KeyboardLocale/czech``, ``KeyboardLocale/danish``, ``KeyboardLocale/dutch``, ``KeyboardLocale/dutch_belgium``, ``KeyboardLocale/english``, ``KeyboardLocale/english_gb``, ``KeyboardLocale/english_us``, ``KeyboardLocale/filipino``, ``KeyboardLocale/finnish``, ``KeyboardLocale/french``, ``KeyboardLocale/french_belgium``, ``KeyboardLocale/french_switzerland``, ``KeyboardLocale/german``, ``KeyboardLocale/german_austria``, ``KeyboardLocale/german_switzerland``, ``KeyboardLocale/greek``, ``KeyboardLocale/hebrew``, ``KeyboardLocale/hungarian``, ``KeyboardLocale/irish``, ``KeyboardLocale/italian``, ``KeyboardLocale/norwegian``, ``KeyboardLocale/polish``, ``KeyboardLocale/portuguese_brazil``, ``KeyboardLocale/portuguese``, ``KeyboardLocale/romanian``, ``KeyboardLocale/russian``, ``KeyboardLocale/spanish``, ``KeyboardLocale/swedish``, ``KeyboardLocale/turkish``, ``KeyboardLocale/ukrainian``.

To support other locales, you must use a remote autocomplete service or create a custom service implementation.


[Pro]: https://github.com/KeyboardKit/KeyboardKitPro
