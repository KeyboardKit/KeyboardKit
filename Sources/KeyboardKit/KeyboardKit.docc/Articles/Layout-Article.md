# Layout

This article describes the KeyboardKit layout engine.

@Metadata {

    @PageImage(
        purpose: card,
        source: "Page",
        alt: "Page icon"
    )

    @PageColor(blue)
}

A flexible keyboard layout is an important part of a software keyboard, and must consider many factors like the current locale, device, screen orientation, user preferences, etc.

In KeyboardKit, a ``KeyboardLayout`` describes the full keyboard layout, which can use an ``InputSet`` to define the input keys, then surround them with additional keys.

KeyboardKit has a ``KeyboardLayoutService`` protocol that is implemented by classes that can create keyboard layouts, as well as many base classes that create standard layouts that can then be customized.

👑 [KeyboardKit Pro][Pro] unlocks localized input sets and layout services for all locales, as well as additional sets like ``InputSet/qwertz`` and ``InputSet/azerty``, and support for iPad Pro. Information about Pro features can be found at the end of this article.



## KeyboardLayout namespace

KeyboardKit has a ``KeyboardLayout`` type that is also a namespace for other layout-related types like ``KeyboardLayout/Configuration``, ``KeyboardLayout/Item``, etc.


## Input Sets

An ``InputSet`` set specifies the input keys of a keyboard. It makes it easy to define different input keys for the same keyboard layout.

KeyboardKit comes with some pre-defined input sets, like ``InputSet/qwerty``, ``InputSet/numeric(currency:)`` and ``InputSet/symbolic(currencies:)``. KeyboardKit Pro unlocks more input sets, e.g. QWERTZ, AZERTY, and specific input sets for each locale.



## Keyboard Layouts

A ``KeyboardLayout`` specifies the full set of keys om a keyboard. Layouts vary greatly for different device types, screen orientations, locales, keyboard configurations, etc.

For instance, *most* iOS keyboards have 3 input rows, with input keys that are surrounded by action keys, as well as a bottom row with a space bar and contextual action keys. This is however not true for all locales, where the layout can vary greatly.



## Keyboard Layout Services

Given all this, the layout engine has to be flexible. KeyboardKit has a ``KeyboardLayoutService`` that generates layouts at runtime, based on many different factors. Layout services can use any information to tweak any part of a layout at any time.

KeyboardKit automatically creates an instance of ``KeyboardLayout/StandardService`` and injects it into ``KeyboardInputViewController/services``. You can replace it at any time, as described further down, or inject custom services into it.

You can easily resolve various ``KeyboardLayoutService`` implementations with these shorthands, sorted by relevance:

* ``KeyboardLayoutService/standard(baseService:localizedServices:)``
* ``KeyboardLayoutService/localized(for:)`` (👑 KeyboardKit Pro)
* ``KeyboardLayoutService/disabled``
* ``KeyboardLayoutService/preview``



## How to create a custom layout service

You can create a custom layout service to customize the layout for certain locales or devices, or define a completely custom layout.

You can implement the ``KeyboardLayoutService`` protocol from scratch, or inherit and customize any of the ``KeyboardLayout/StandardService``, ``KeyboardLayout/BaseService``, ``KeyboardLayout/iPadService``, ``KeyboardLayout/iPadProService``, or ``KeyboardLayout/iPhoneService`` base classes, for instance:

```swift
class CustomKeyboardLayoutService: KeyboardLayout.StandardService {
    
    // Never use array indices if it can cause a crash.
    override func keyboardLayout(for context: KeyboardContext) -> KeyboardLayout {
        var layout = super.keyboardLayout(for: context)
        // Perform any modifications here
        return layout
    }
}
```

The ``KeyboardLayout/StandardService`` and ``KeyboardLayout/ProService`` base classes have different functions that you can override, and the ``KeyboardLayout`` model also provodes ways to modify the layout, although they are a bit complicated at the moment.

To use your custom service instead of the standard one, just inject it into ``KeyboardInputViewController/services`` by replacing its ``Keyboard/Services/layoutService`` property:

```swift
class KeyboardViewController: KeyboardInputViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        services.layoutService = CustomKeyboardLayoutService()
    }
}
```

This will make KeyboardKit use your custom implementation instead of the standard one.



## How to customize the layout for a specific locale

If a service inherits ``KeyboardLayout/StandardService``, you can use ``KeyboardLayoutService/tryRegisterLocalizedService(_:)`` or the ``Keyboard/Services`` convenient ``Keyboard/Services/tryRegisterLocalizedLayoutService(_:)`` to register a custom service for a certain ``KeyboardLocale``.

For instance, this is how you could make KeyboardKit Pro use the QWERTY layout for ``KeyboardLocale/german``:

```swift
class KeyboardViewController: KeyboardInputViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        services.tryRegisterLocalizedLayoutService(
            try! KeyboardLayout.ProService.German(alphabeticInputSet: .qwerty) 
        )
    }
}
```

This makes it easy to replace the default service for a certain locale in KeyboardKit Pro, where you can subclass ``KeyboardLayout/ProService`` or any localized Pro service, and make customizations to it.



## 👑 KeyboardKit Pro

[KeyboardKit Pro][Pro] unlocks a localized ``KeyboardLayoutService`` for every locale in your license, which are then injected into the main ``Keyboard/Services/layoutService`` when a valid license is registered.

KeyboardKit Pro also unlocks more input sets, adds more capabilities to the ``KeyboardLayout`` and makes it easier to handle layouts.


### More Input Sets

KeyboardKit Pro unlocks more input sets, like ``InputSet/qwertz`` and ``InputSet/azerty``. These are used by some of the localized layouts, but you can use them separately as well.


### More KeyboardLayout functionality

KeyboardKit Pro unlocks more ``KeyboardLayout`` capabilities, like ``KeyboardLayout/adjusted(for:layoutConfiguration:)``, ``KeyboardLayout/copy()``, and ``KeyboardLayout/createIdealItem(for:width:alignment:)``, which are used by some Pro features as well.


### iPad Pro Support

KeyboardKit Pro unlocks an ``KeyboardLayout/iPadProService`` that can be used to generate iPad Pro-specific layouts. It's used by most locales, and will be added to more over time. 


### Pro Layout Services

KeyboardKit Pro unlocks a localized ``KeyboardLayout/ProService`` for every locale in your license. They are injected into the main ``Keyboard/Services/layoutService`` when a valid license is registered.

You can access any localized service in your license like this, after successfully registering your license key:

```swift
let swedish = try KeyboardLayout.ProService.Swedish()
```

> Important: These services will throw a license error if their locales are not included in the license.


### How to customize a Pro service

You can inherit and customize any ``KeyboardLayout/ProService`` in your license, then manually register your service *after* registering your license key:

```swift
class CustomService: KeyboardLayout.ProService.Swedish {

    override func keyboardLayout(for context: KeyboardContext) -> KeyboardLayout {
        let service = keyboardLayoutService(for: context)
        var layout = service.keyboardLayout(for: context)
        guard let item = layout.tryCreateBottomRowItem(
            for: .character("🇸🇪")
        ) else { return layout }
        layout.itemRows.insert(item, after: .space, atRow: layout.bottomRowIndex)
        return layout
    }
}

class KeyboardController: KeyboardInputViewController {

    override func viewWillSetupKeyboard() {
        super.viewWillSetupKeyboard()

        setupPro(withLicenseKey: "...") { license in
            setupCustomService()
        } view: { controller in
            // Return your keyboard view here
        }
    }

    func setupCustomService() {
        do {
            let service = try CustomService()
            let standard = services.layoutService as? KeyboardLayout.StandardService
            standard?.registerLocalizedService(service)
        } catch {
            print(error)
        }
    }
}
```

This is useful for when you want to make modifications to a single locale's layout, but keep all other locales the same.


[Pro]: https://github.com/KeyboardKit/KeyboardKitPro
