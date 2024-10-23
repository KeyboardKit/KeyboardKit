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

In KeyboardKit, an ``InputSet`` defines the input keys of a keyboard, after which a ``KeyboardLayoutService`` can create a dynamic ``KeyboardLayout`` at runtime that defines the full set of keys. 

👑 [KeyboardKit Pro][Pro] unlocks localized input sets and layout services for all locales, as well as additional sets like ``InputSet/qwertz`` and ``InputSet/azerty``, and support for iPad Pro. Information about Pro features can be found at the end of this article.



## KeyboardLayout namespace

KeyboardKit has a ``KeyboardLayout`` type that is also a namespace for other layout-related types like ``KeyboardLayout/Configuration``, ``KeyboardLayout/Item``, etc.



## Input Sets

An ``InputSet`` specifies the input keys of a keyboard. It makes it easy to define different input keys for the same keyboard layout.

KeyboardKit comes with some pre-defined input sets, like ``InputSet/qwerty``, ``InputSet/numeric(currency:)`` and ``InputSet/symbolic(currencies:)``. KeyboardKit Pro unlocks more input sets, e.g. ``InputSet/qwertz`` and ``InputSet/azerty``, as well as specific input sets for each locale.



## Keyboard Layouts

A ``KeyboardLayout`` specifies the full set of keys on a keyboard. Layouts can vary greatly for different devices, screens, locales, etc.

*Most* iOS keyboards have 3 input rows of input keys surrounded by action keys, as well as a bottom row with a space bar and contextual action keys. This is however not true for all locales, where the keyboard layout can vary greatly.

For instance, Armenian keyboard have 4 input rows, Greek ones have way fewer action keys, many RTL ones remove the shift key, etc. With all these considerations, we must be able to easily adjust the keyboard layout based on many different factors.



## Keyboard Layout Services

In KeyboardKit, a ``KeyboardLayoutService`` can generate dynamic layouts at runtime, It provides us with the flexibility we need, to accomodate to the varying needs for different locales, devices, etc.

KeyboardKit automatically creates an instance of ``KeyboardLayout/StandardService`` and injects it into ``KeyboardInputViewController/services``. You can replace it at any time, as described further down, or inject custom services into it with ``KeyboardLayoutService/tryRegisterLocalizedService(_:)``.



## Keyboard Layout Service Shorthands

You can easily resolve various service types with these shorthands:

* ``KeyboardLayoutService/standard(baseService:localizedServices:)``
* ``KeyboardLayoutService/localized(_:)``, e.g. `.localized(.German(...))`
* ``KeyboardLayoutService/localized(for:)``, e.g. `.localized(for: .swedish)`
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

The ``KeyboardLayout/StandardService`` and ``KeyboardLayout/ProService`` base classes have different functions that you can override, and the ``KeyboardLayout`` and ``KeyboardLayout/ItemRow`` models also provide ways to modify the layout.

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

You can use ``KeyboardLayoutService/tryRegisterLocalizedService(_:)`` or the ``Keyboard/Services`` more convenient ``Keyboard/Services/tryRegisterLocalizedLayoutService(_:)`` function to register a custom service for a certain locale.

For instance, this is how you could make KeyboardKit Pro use the ``InputSet/qwerty`` input set for ``Foundation/Locale/german``:

```swift
class KeyboardViewController: KeyboardInputViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        services.tryRegisterLocalizedLayoutService(
            try! .german(alphabeticInputSet: .qwerty) 
        )
    }
}
```

This makes it easy to replace the default service for a certain locale in KeyboardKit Pro, where you can subclass ``KeyboardLayout/ProService`` or any localized Pro service, and make customizations to it.



## 👑 KeyboardKit Pro

[KeyboardKit Pro][Pro] unlocks a localized ``KeyboardLayoutService`` for every locale in your license, which are then injected into the main ``Keyboard/Services/layoutService`` when a valid license is registered.

KeyboardKit Pro also unlocks more input sets, adds more capabilities to the ``KeyboardLayout`` and makes it easier to handle layouts.


### Input sets

KeyboardKit Pro unlocks more input sets, like ``InputSet/qwertz`` and ``InputSet/azerty``. These are used by some of the localized layouts, but you can use them separately as well.

KeyboardKit Pro also unlocks additional alphabetic, numeric and symbolic input sets for all ``Foundation/Locale/keyboardKitSupported`` locales that are included in your license, like `InputSet.swedishNumeric`.


### iPad Pro Support

KeyboardKit Pro unlocks an ``KeyboardLayout/iPadProService`` that can be used to generate iPad Pro-specific layouts. It's used by most locales, and will be added to more over time. 


### Layout utilities

KeyboardKit Pro unlocks more ``KeyboardLayout`` capabilities, like ``KeyboardLayout/adjusted(for:layoutConfiguration:)``, ``KeyboardLayout/copy()``, and ``KeyboardLayout/createIdealItem(for:width:alignment:)``, which make i a lot easier to customize your layout.


### Layout Services

KeyboardKit Pro unlocks a localized ``KeyboardLayout/ProService`` for every locale in your license. They are injected into the main ``Keyboard/Services/layoutService`` when a valid license is registered.

You can access any localized service in your license like this, after successfully registering your license key:

```swift
let swedish = try KeyboardLayout.ProService.Swedish()
```

> Important: Localized pro services will throw a license error if their locales are not included in the license.


### How to customize a Pro service

You can inherit and customize any ``KeyboardLayout/ProService`` in your license, then manually register your service after setting up KeyboardKit Pro for your ``KeyboardApp``, or with a license key:

```swift
class CustomService: KeyboardLayout.ProService.Swedish {

    // Override any functions you want here...
}

class KeyboardController: KeyboardInputViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setupPro(for: .myApp) { license in
            setupCustomService()
        } 
    }

    func setupCustomService() {
        do {
            let service = try CustomService()
            try services.layoutService.tryRegisterLocalizedService(service)
        } catch {
            print(error)
        }
    }
}
```

This is useful for when you want to make modifications to a single locale's layout, but keep all other locales the same.


[Pro]: https://github.com/KeyboardKit/KeyboardKitPro
