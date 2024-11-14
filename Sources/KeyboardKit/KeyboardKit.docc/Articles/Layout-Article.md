# Layout

This article describes the KeyboardKit layout engine.

@Metadata {

    @PageImage(
        purpose: card,
        source: "Page",
        alt: "Page icon"
    )
}

A flexible keyboard layout is an important part of a software keyboard, and must consider many factors like the current locale, device, screen orientation, user preferences, etc.

In KeyboardKit, an ``InputSet`` defines the input keys of a keyboard, after which a ``KeyboardLayoutService`` can create a dynamic ``KeyboardLayout`` at runtime that defines the full set of keys. 

👑 [KeyboardKit Pro][Pro] unlocks localized layout services for all ``Foundation/Locale/keyboardKitSupported`` locales in your license, additional input sets like ``InputSet/qwertz`` & ``InputSet/azerty``, iPad Pro support, more layout capabilities that make modifying layouts easier, etc. Read more further down.



## Namespace

KeyboardKit has a ``KeyboardLayout`` type that is also a namespace for other layout-related types like ``KeyboardLayout/Configuration``, ``KeyboardLayout/Item``, etc.



## Input Sets & Layouts

In KeyboardKit an ``InputSet`` specifies the input keys of a keyboard, while a ``KeyboardLayout`` specifies the full set of keys. Layouts can vary greatly for different devices, screens, locales, etc.

KeyboardKit comes with pre-defined input sets, like ``InputSet/qwerty``, ``InputSet/numeric(currency:)`` & ``InputSet/symbolic(currencies:)``. KeyboardKit Pro unlocks more input sets, like ``InputSet/qwertz`` and ``InputSet/azerty``, as well as locale-specific input sets for all ``Foundation/Locale/keyboardKitSupported`` locales.

While most iOS keyboards have 3 input rows of input keys surrounded by action keys, and a bottom row with space bar and action keys, this is not true for all locales. The layout can vary greatly, so the layout engine must be flexible.



## Services

In KeyboardKit, a ``KeyboardLayoutService`` can generate dynamic layouts at runtime, It provides us with the flexibility we need, to accomodate to the varying needs for different locales, devices, etc.

KeyboardKit automatically creates an instance of ``KeyboardLayout/StandardService`` and injects it into ``KeyboardInputViewController/services``. You can replace it at any time, as described further down, or inject custom services into it with ``KeyboardLayoutService/tryRegisterLocalizedService(_:)``.


---


## 👑 KeyboardKit Pro

[KeyboardKit Pro][Pro] unlocks a localized ``KeyboardLayoutService`` for every locale in your license and injects them as localized services into the main ``Keyboard/Services/layoutService`` when a valid license is registered. You can access any localized service in your license like this:

```swift
let service = try KeyboardLayout.ProService.Swedish()
```

KeyboardKit Pro also unlocks more input sets, adds more capabilities to the ``KeyboardLayout`` and makes it easier to handle layouts.


### Localized Input Sets & Layouts

KeyboardKit Pro unlocks more input sets, like ``InputSet/qwertz`` & ``InputSet/azerty``, as well as alphabetic, numeric & symbolic sets for all ``Foundation/Locale/keyboardKitSupported`` locales that are included in your license, like `.swedishNumeric`.

KeyboardKit Pro unlocks a localized ``KeyboardLayout/ProService`` for all supported locales as well, and injects them as localized services into the main ``Keyboard/Services/layoutService`` when a valid license is registered. You can access any localized service in your license like this:

```swift
let service = try KeyboardLayout.ProService.Swedish()
```


### iPad Pro Support

KeyboardKit Pro unlocks an ``KeyboardLayout/iPadProService`` that generates iPad Pro-specific layouts for most ``Foundation/Locale/keyboardKitSupported`` locales.


### Pro Layout Capabilites

KeyboardKit Pro extends the ``KeyboardLayout`` ``KeyboardLayout/itemRows-swift.property`` property and all layout ``KeyboardLayout/Item`` collections with more capabilities, that make it easier to insert, remove, and replace items and actions.

KeyboardKit Pro also unlocks more ``KeyboardLayout`` capabilities like ``KeyboardLayout/adjusted(for:layoutConfiguration:)``, ``KeyboardLayout/copy()`` and ``KeyboardLayout/createIdealItem(for:width:alignment:)``, and a specific set of tools for the bottom row, like ``KeyboardLayout/bottomRowLayout``.

See ``KeyboardLayout`` and its ``KeyboardLayout/Item`` in the KeyboardKit Pro documentations for a full list of capabilities that KeyboardKit Pro unlocks. The open-source documentation doesn't include all these extensions, which is why they are not in the documentation. 


---


## How to...

### Create a custom layout service

You can create a custom ``KeyboardLayoutService`` to customize the layout for a certain locale, or define a fully custom layout.

You can implement the ``KeyboardLayoutService`` protocol from scratch, or inherit and customize the ``KeyboardLayout/StandardService`` class, or any of the other ``KeyboardLayout/BaseService``, ``KeyboardLayout/iPadService``, ``KeyboardLayout/iPadProService``, or ``KeyboardLayout/iPhoneService`` base classes:

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



### Customize a localized Pro service

Service that inherit ``KeyboardLayout/StandardService`` can use ``KeyboardLayoutService/tryRegisterLocalizedService(_:)`` or the ``Keyboard/Services`` convenient ``Keyboard/Services/tryRegisterLocalizedLayoutService(_:)`` function to register a custom service for a certain locale.

For instance, this is how you could make KeyboardKit Pro use a custom service for ``Foundation/Locale/german``:

```swift
class MyCustomGermanService: KeyboardLayout.ProService.German { ... } 

class KeyboardViewController: KeyboardInputViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        services.tryRegisterLocalizedLayoutService(
            try! MyCustomGermanService() 
        )
    }
}
```

This makes it easy to replace the service for a certain KeyboardKit Pro locale, where you can inherit and customize any ``KeyboardLayout/ProService``.



[Pro]: https://github.com/KeyboardKit/KeyboardKitPro
