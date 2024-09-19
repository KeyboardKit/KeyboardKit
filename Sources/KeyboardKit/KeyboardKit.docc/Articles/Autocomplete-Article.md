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

Autocomplete is an important part of the typing experience, where word suggestions are shown above the keyboard as the user types.

In KeyboardKit, an ``AutocompleteService`` can provide autocomplete suggestions to the main ``AutocompleteContext``. Unlike other service types, there is no open-source implementation of this service protocol.

👑 [KeyboardKit Pro][Pro] unlocks local and remote autocomplete. Information about Pro features can be found at the end of this article.

[Pro]: https://github.com/KeyboardKit/KeyboardKitPro



## Autocomplete Namespace

KeyboardKit has an ``Autocomplete`` namespace that contains autocomplete-related types and views, like the ``Autocomplete/Suggestion`` model that is returned by an ``AutocompleteService`` when performing autocomplete.



## Autocomplete Context

KeyboardKit has an observable ``AutocompleteContext`` that provides observable autocomplete state, such as the ``AutocompleteContext/suggestions`` to present. The state properties are modified as the keyboard performs autocomplete.

The context also has persistent, observable settings, such as  ``AutocompleteContext/isAutocompleteEnabled``, ``AutocompleteContext/suggestionsDisplayCount``, etc. You can read more about how settings are handled in the <doc:Essentials> and <doc:Settings-Article> articles.

KeyboardKit automatically creates an instance of this class, injects it into ``KeyboardInputViewController/state`` and updates it whenever autocomplete is performed.



## Autocomplete Services

In KeyboardKit, an ``AutocompleteService`` can provide suggestions when the user types or the text input cursor moves in the text.

KeyboardKit doesn't have a standard autocomplete service. Instead, it injects a ``AutocompleteService/disabled`` service into ``KeyboardInputViewController/services`` until you register [KeyboardKit Pro][pro] or inject your own service implementation.

KeyboardKit Pro unlocks a ``Autocomplete/LocalService``, which performs on-device autocomplete, and a ``Autocomplete/RemoteService``, which can be used to integrate with any remote, REST-based API.

You can easily resolve various ``AutocompleteService`` implementations with these shorthands, sorted by relevance:

* ``AutocompleteService/local(context:locale:)`` (👑 KeyboardKit Pro)
* ``AutocompleteService/disabled``
* ``AutocompleteService/disabled(suggestions:)``
* ``AutocompleteService/preview``



## How to perform autocomplete

KeyboardKit will automatically call the ``KeyboardInputViewController``'s ``KeyboardController/performAutocomplete()`` whenever the keyboard text changes, then update the context ``AutocompleteContext/suggestions`` with the suggestions that are returned from the current autocomplete service.

You can configure the ``AutocompleteContext`` and override the ``KeyboardInputViewController``'s autocomplete properties and functions, such as ``KeyboardInputViewController/autocompleteText`` or ``KeyboardInputViewController/performAutocomplete()``, to customize how autocomplete behaves.

You can disable autocomplete and autocorrect with ``AutocompleteContext/isAutocompleteEnabled`` and ``AutocompleteContext/isAutocorrectEnabled``, and also disable autocorrection by applying a ``SwiftUI/View/autocorrectionDisabled(with:)`` view modifier to the view hierarchy.

You can set ``AutocompleteContext/isAutolearnEnabled`` to `true` to make a ``KeyboardActionHandler``  automatically tell ``AutocompleteService`` to learn all unknown suggestions that the action handler applies.

The ``KeyboardView`` will automatically add an ``Autocomplete``.``Autocomplete/Toolbar`` that lists the autocomplete context ``AutocompleteContext/suggestions`` and also gives the keyboard some additional top space for callouts to render without being clipped.



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
    
    @Tab("Autocomplete.Toolbar") {
        
        The ``Autocomplete``.``Autocomplete/Toolbar`` mimics a native autocomplete bar, and can be used to present autocomplete suggestions to the user:
        
        @Row {
            @Column {}
            @Column(size: 3) {
                ![AutocompleteToolbar](autocompletetoolbar)
            }
            @Column {}
        }
        
        This view can be styled with ``Autocomplete``.``Autocomplete/ToolbarStyle``, which can be applied with ``SwiftUI/View/autocompleteToolbarStyle(_:)``. It can also use custom ``Autocomplete``.``Autocomplete/ToolbarItem`` & ``Autocomplete/ToolbarSeparator`` views.
    }
}


## 👑 KeyboardKit Pro

[KeyboardKit Pro][Pro] unlocks a ``Autocomplete/LocalService`` and ``Autocomplete/RemoteService`` and injects a ``Autocomplete/LocalService`` into ``KeyboardInputViewController/services`` when you register a valid license key. These services are open to inheritance, so you can inherit and customize them to fit your needs.


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
