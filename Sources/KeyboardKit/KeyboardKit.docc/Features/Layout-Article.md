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



## Namespace

KeyboardKit has a ``KeyboardLayout`` type that is also a namespace for other layout-related types like ``KeyboardLayout/Configuration``, ``KeyboardLayout/Item``, etc.



## Input Sets & Layouts

While most iOS keyboards have 3 input rows of input keys surrounded by action keys, and a bottom row with space bar and action keys, this is not true for all locales. The layout can vary greatly, so the layout engine must be flexible.

In KeyboardKit an ``InputSet`` specifies the input keys of a keyboard, while a ``KeyboardLayout`` specifies the full set of keys. Layouts can vary greatly for different devices, screens, locales, etc.

KeyboardKit comes with pre-defined input sets, like ``InputSet/qwerty``, ``InputSet/numeric(currency:)`` & ``InputSet/symbolic(currencies:)``. KeyboardKit Pro unlocks more input sets, like ``InputSet/qwertz`` and ``InputSet/azerty``, as well as locale-specific input sets for all ``Foundation/Locale/keyboardKitSupported`` locales.

KeyboardKit also defines a ``Keyboard/LayoutType`` enum that defines various keyboard layout types, like ``Keyboard/LayoutType/qwerty``, ``Keyboard/LayoutType/azerty`` and other types with the same as the input sets above. This enum is used by [KeyboardKit Pro][Pro], to make a ``KeyboardLayout/ProLayoutService`` adjust its alphabetic layout. 



## Services

In KeyboardKit, a ``KeyboardLayoutService`` can generate dynamic layouts at runtime, It provides us with the flexibility we need, to accomodate to the varying needs for different locales, devices, etc.

KeyboardKit injects ``KeyboardLayout/StandardLayoutService`` into ``KeyboardInputViewController/services``. You can replace it at any time, as described further down, or add custom services to it with ``KeyboardLayoutService/tryRegisterLocalizedService(_:)``.


---


## 👑 KeyboardKit Pro

[KeyboardKit Pro][Pro] unlocks more input sets, like ``InputSet/qwertz``, ``InputSet/azerty``, and  ``InputSet/colemak``, as well as alphabetic, numeric & symbolic sets for all ``Foundation/Locale/keyboardKitSupported`` locales that are included in your license, like `.french`, `.swedishNumeric`, etc.

KeyboardKit Pro also unlocks a localized ``KeyboardLayout/ProLayoutService`` for every locale and injects them as localized services into the ``Keyboard/Services/layoutService``. You can access any localized service in your license like this:

```swift
let swedishInputSet = try InputSet.swedish
let swedishService = try KeyboardLayout.ProLayoutService.Swedish()
```

These input sets and layout services will all throw an error if you try to access them without a valid KeyboardKit Pro license. If you are on the Basic or Silver plan, you must specify which locales to use in your ``KeyboardApp``. See <doc:Getting-Started-Article> for more info.


### iPad Pro Support

KeyboardKit Pro unlocks an ``KeyboardLayout/iPadProLayoutService`` that can generate iPad Pro-specific layouts for most supported locales.

![iPad Pro Layout](keyboardview-ipadpro)


### More Layout Capabilites

KeyboardKit Pro extends ``KeyboardLayout`` and its various related types and collections with more capabilities, that make it easier to add, remove, and replace items in a layout.

See ``KeyboardLayout`` and the nested layout ``KeyboardLayout/Item`` type in the KeyboardKit Pro documentation for a full list of additional capabilities.


### ✨ NEW - Multiple Supported Layouts Per Locale

KeyboardKit extends ``Foundation/Locale`` with a list of supported ``Keyboard/LayoutType``s, and makes the ``KeyboardApp/LocaleScreen`` add a layout type picker to all ``KeyboardSettings/addedLocales`` that support multiple layouts. For instance, English keyboards support ``InputSet/qwerty``, ``InputSet/azerty``, ``InputSet/qwertz``, and ``InputSet/colemak``.

* Catalan: QWERY - Catalan, QWERTY, AZERTY, QWERTZ, Colemak
* Croatian: QWERTZ, QWERTY, AZERTY, Colemak
* Dutch: QWERTY, AZERTY, QWERTZ, Colemak
* Dutch_belgium: AZERTY, QWERTY, QWERTZ, Colemak
* English: QWERTY, AZERTY, QWERTZ, Colemak
* English_australia: QWERTY, AZERTY, QWERTZ, Colemak
* English_canada: QWERTY, AZERTY, QWERTZ, Colemak
* English_gb: QWERTY, AZERTY, QWERTZ, Colemak
* English_us: QWERTY, AZERTY, QWERTZ, Colemak
* Estonian: QWERTY, QWERTZ, AZERTY, .colemak
* Hungarian: QWERTZ, QWERTY, AZERTY, Colemak
* Indonesian: QWERTY, QWERTZ, AZERTY, Colemak
* Irish: QWERTY, QWERTZ, AZERTY, Colemak
* Italian: QWERTY, AZERTY, QWERTZ, Colemak
* Latvian: QWERTY, QWERTZ, AZERTY, Colemak
* Malay: QWERTY, QWERTZ, AZERTY, Colemak
* Polish: QWERTY, QWERTZ, AZERTY, Colemak
* Portuguese: QWERTY, AZERTY, QWERTZ, Colemak
* Portuguese_brazil: QWERTY, AZERTY, QWERTZ, Colemak
* Romanian: QWERTY, QWERTZ, AZERTY, Colemak
* Serbian_latin: QWERTY, QWERTZ, AZERTY, Colemak
* Slovenian: QWERTZ, QWERTY, AZERTY, Colemak
* Swahili: QWERTY, AZERTY, QWERTZ, Colemak
* Uzbek: QWERTY, AZERTY, QWERTZ, Colemak
* Vietnamese TELEX/VIQR/VNI: QWERTY, AZERTY, QWERTZ
* Welsh: QWERTY, AZERTY, QWERTZ, Colemak

All ``KeyboardLayout/ProLayoutService`` implementations use the ``KeyboardContext/keyboardLayoutType`` to adjust their alphabetic input set for the current type.


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
        setup(for: ...) { result in
            // Check result to see that setup was successful
            self.services.tryRegisterLocalizedLayoutService(
                try! MyCustomGermanService() 
            )
        }
    }
}
```

This makes it easy to replace the service for a certain locale, since you can inherit and customize the related ``KeyboardLayout/ProLayoutService``.


### ...customize the layout for a certain locale

Most ``KeyboardLayout/ProLayoutService`` implementations in KeyboardKit Pro lets you specify custom input sets when you initialize them. This can for instance be used to use another alphabetic layout for locales that support it: 

```swift
class KeyboardViewController: KeyboardInputViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setup(for: ...) { _ in
            // Check result to see that setup was successful
            try? self?.services.tryRegisterLocalizedLayoutService(
                KeyboardLayout.ProLayoutService.English(
                    alphabeticInputSet: try? .qwertz
                )
            )
        }
    }
}
```

You can use the ``Foundation/Locale/supportedLayoutTypes`` information that KeyboardKit Pro unlocks to check if a locale supports a certain layout. A layout service that is provided with an unsupported layout type may render it incorrectly.


### ...override the layout type for a certain locale

KeyboardKit has a ``KeyboardContext/selectLocale(_:layoutType:)`` that can be used to set both the ``KeyboardContext/locale`` and ``KeyboardContext/keyboardLayoutType``. The layout type will be used to override the default layout type of certain layout services.

This function is automatically used when you use the ``KeyboardSettings/addedLocales`` collection to manually set a keyboard layout type for a certain locale. Both the ``KeyboardContext/selectNextLocale()`` and the ``Foundation/Locale/ContextMenu`` will use this function to set both properties properly.



[Pro]: https://github.com/KeyboardKit/KeyboardKitPro
