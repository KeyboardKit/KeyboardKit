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

👑 [KeyboardKit Pro][Pro] unlocks extensions that make it easier to modify layouts, adds more input sets like ``InputSet/qwertz``, ``InputSet/azerty`` & ``InputSet/colemak``, unlocks localized input sets & layout services for all locales in your license, iPad Pro layout, etc. 

KeyboardKit Pro also adds a ``Keyboard/LayoutType`` type that can be used to easily register ``KeyboardSettings/localeSpecificLayoutTypeIdentifiers``.  



## Namespace

KeyboardKit has a ``KeyboardLayout`` type that is also a namespace for other layout-related types like ``KeyboardLayout/Configuration``, ``KeyboardLayout/Item``, etc.



## Input Sets & Layouts

While most iOS keyboards have 3 input rows of input keys surrounded by action keys, and a bottom row with space bar and action keys, this is not true for all locales. The layout can vary greatly, so the layout engine must be flexible.

In KeyboardKit an ``InputSet`` specifies the input keys of a keyboard, while a ``KeyboardLayout`` specifies the full set of keys. Layouts can vary greatly for different devices, screens, locales, etc.

KeyboardKit comes with pre-defined input sets, like ``InputSet/qwerty``, ``InputSet/numeric(currency:)`` & ``InputSet/symbolic(currencies:)``. KeyboardKit Pro unlocks more input sets, like ``InputSet/qwertz`` and ``InputSet/azerty``, as well as locale-specific input sets for all ``Foundation/Locale/keyboardKitSupported`` locales.



## Services

In KeyboardKit, a ``KeyboardLayoutService`` can generate dynamic layouts at runtime, It provides us with the flexibility we need, to accomodate to the varying needs for different locales, devices, etc.

KeyboardKit injects ``KeyboardLayout/StandardLayoutService`` into ``KeyboardInputViewController/services``. You can replace it at any time, as described further down, or add custom services to it with ``KeyboardLayoutService/tryRegisterLocalizedService(_:)``.


---


## 👑 KeyboardKit Pro

[KeyboardKit Pro][Pro] unlocks more input sets, like ``InputSet/qwertz``, ``InputSet/azerty``, and  ``InputSet/colemak``, as well as alphabetic, numeric & symbolic sets for all ``Foundation/Locale/keyboardKitSupported`` locales that are included in your license, like `.french`, `.swedishNumeric`, etc.

KeyboardKit Pro also unlocks a localized ``KeyboardLayout/ProLayoutService`` for every locale and injects them as localized services into the ``Keyboard/Services/layoutService`` when a valid license is registered. You can access any localized service in your license like this:

```swift
let service = try KeyboardLayout.ProLayoutService.Swedish()
```

These input sets and layout services will all throw an error if you try to access them without a valid KeyboardKit Pro license. If you are on the Basic or Silver plan, you must specify which locales to use in your ``KeyboardApp``. See <doc:Getting-Started> for more info.


### Additional Layout Capabilites

KeyboardKit Pro extends ``KeyboardLayout`` and its various related types and collections with more capabilities, that make it easier to add, remove, and replace items in a layout.

See ``KeyboardLayout`` and the nested layout ``KeyboardLayout/Item`` type in the KeyboardKit Pro documentation for a full list of additional capabilities.


### Multiple Supported Layouts Per Locale

KeyboardKit Pro unlocks a ``Keyboard/LayoutType``, extends ``Foundation/Locale`` with a list of supported layout types, and extends ``KeyboardSettings`` with ways to get and set the preferred layout type for any locale. 

This is used by ``KeyboardApp/LocaleScreen`` to add a layout type picker to all ``KeyboardSettings/addedLocales`` that support multiple layouts. For instance, English keyboards support ``InputSet/qwerty``, ``InputSet/azerty``, ``InputSet/qwertz``, and ``InputSet/colemak``, and will therefore add a picker to the added locale item.  


### iPad Pro Support

KeyboardKit Pro unlocks an ``KeyboardLayout/iPadProLayoutService`` that can generate iPad Pro-specific layouts for most supported locales.

![iPad Pro Layout](keyboardview-ipadpro)


---


## How to...

### ...create a custom layout service

You can create a custom ``KeyboardLayoutService`` to customize the layout for a certain locale, device type, or complete layout.

You can implement the ``KeyboardLayoutService`` protocol from scratch, or inherit and customize ``KeyboardLayout/StandardLayoutService`` or any of the available ``KeyboardLayout/iPadLayoutService``, ``KeyboardLayout/iPadProLayoutService``, or ``KeyboardLayout/iPhoneLayoutService`` base classes:

```swift
class CustomKeyboardLayoutService: KeyboardLayout.StandardLayoutService {
    
    override func keyboardLayout(for context: KeyboardContext) -> KeyboardLayout {
        var layout = super.keyboardLayout(for: context)
        // Perform any modifications here
        // 💡 KeyboardKit Pro unlocks many layout extensions
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


### ...customize a localized layout service

Service that inherit ``KeyboardLayout/StandardLayoutService`` can use ``KeyboardLayoutService/tryRegisterLocalizedService(_:)`` or the ``Keyboard/Services`` convenient ``Keyboard/Services/tryRegisterLocalizedLayoutService(_:)`` function to register a custom service for a certain locale, for instance:

```swift
class MyCustomGermanService: KeyboardLayout.ProLayoutService.German { ... } 

class KeyboardViewController: KeyboardInputViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setupPro(for: ...) { _ in
            self.services.tryRegisterLocalizedLayoutService(
                try! MyCustomGermanService() 
            )
        }
    }
}
```

This makes it easy to replace the service for a certain locale, since you can inherit and customize the related ``KeyboardLayout/ProLayoutService``.


### ...change the layout type for a specific locale

You can use ``KeyboardSettings`` to change the preferred layout type for a specific locale. KeyboardKit Pro unlocks a ``Keyboard/LayoutType`` that makes this a lot easier, where you can use any of the available settings extensions like this:

```swift
class KeyboardViewController: KeyboardInputViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setupPro(for: ...) { _ in
            let settings = self.state.keyboardContext.settings 
            settings.setLayoutType(.azerty, for: .english)
        }
    }
}
```

You can still use the underlying ``KeyboardSettings/localeSpecificLayoutTypeIdentifiers`` to store alternate layout information, but you need KeyboardKit Pro if you want to use its extended locale and layout support.



[Pro]: https://github.com/KeyboardKit/KeyboardKitPro
