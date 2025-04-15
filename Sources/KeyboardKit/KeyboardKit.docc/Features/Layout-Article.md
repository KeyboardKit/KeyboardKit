# Layout

This article describes the KeyboardKit layout engine.

@Metadata {

    @PageImage(
        purpose: card,
        source: "Page",
        alt: "Page icon"
    )
}

While most keyboards have 3 input rows surrounded by action keys, and a bottom row with space bar and action keys, this is not true for all locales. The layout can vary greatly, which means that the layout engine must be flexible.

In KeyboardKit, an ``InputSet`` defines the input keys of a keyboard, after which a ``KeyboardLayoutService`` can create a dynamic ``KeyboardLayout`` at runtime that defines the full set of keys to render for the keyboard.

👑 [KeyboardKit Pro][Pro] unlocks extensions that make it easier to modify layouts, adds more input sets like ``InputSet/qwertz``, ``InputSet/azerty``, ``InputSet/colemak`` and ``InputSet/dvorak``, and unlocks iPad Pro support and localized input sets & layouts for all locales in your license.



## Namespace

KeyboardKit has a ``KeyboardLayout`` type that is also a namespace for other layout-related types like ``KeyboardLayout/DeviceConfiguration``.



## Input Sets & Layouts


In KeyboardKit an ``InputSet`` specifies the input keys of a keyboard, while a ``KeyboardLayout`` specifies the full set of keys. Layouts can vary greatly for different devices, screens, locales, etc.

KeyboardKit comes with pre-defined input sets, like ``InputSet/qwerty``, ``InputSet/numeric(currency:)`` & ``InputSet/symbolic(currencies:)``. KeyboardKit Pro unlocks more input sets, like ``InputSet/qwertz``, ``InputSet/azerty``, ``InputSet/colemak`` & ``InputSet/dvorak``, as well as locale-specific input sets for all supported locales.

KeyboardKit Pro makes certain layouts support multiple ``Keyboard/LayoutType``s, which means that you can use various layouts for e.g. English.  



## Services

In KeyboardKit, a ``KeyboardLayoutService`` can generate dynamic layouts at runtime, It provides us with the flexibility we need, to accomodate to the varying needs for different locales, devices, etc.

KeyboardKit injects ``KeyboardLayout/StandardLayoutService`` into ``KeyboardInputViewController/services``. You can replace it at any time, as described further down, or add custom services to it with ``KeyboardLayoutService/tryRegisterLocalizedService(_:)``.


---


## 👑 KeyboardKit Pro

[KeyboardKit Pro][Pro] unlocks more input sets, like ``InputSet/qwertz``, ``InputSet/azerty``, ``InputSet/colemak`` and ``InputSet/dvorak``, plus alphabetic, numeric & symbolic sets and locale-specific layout services for all ``Foundation/Locale/keyboardKitSupported`` locales that are included in your license.

KeyboardKit Pro will automatically set up all input sets and layout services in your license, and use them when you change ``KeyboardContext/locale`` and ``KeyboardContext/keyboardLayoutType``, but you can also use them individually, as standalone features: 

```swift
let swedishInputSet = try InputSet.swedish
let swedishService = try KeyboardLayout.ProLayoutService.Swedish()
```

These input sets and services will throw a license error if you try to access them without first registering a valid KeyboardKit Pro license. If you are on the Basic or Silver plan, you must specify which locales to use in your ``KeyboardApp``. See <doc:Getting-Started-Article> for instructions.


### iPad Pro Support

KeyboardKit Pro unlocks an ``KeyboardLayout/iPadProLayoutService`` that can generate iPad Pro-specific layouts for most supported locales.

![iPad Pro Layout](keyboardview-ipadpro)


### Keyboard Layout Extensions

KeyboardKit Pro extends ``KeyboardLayout`` and its related types and collections to make it easier to add, remove, and replace items. 

See ``KeyboardLayout`` and the nested layout ``KeyboardLayout/Item`` type in the KeyboardKit Pro documentation for a full list of additional capabilities.


### Locales With Multiple Layouts

KeyboardKit Pro extends ``Foundation/Locale`` with a list of ``Foundation/Locale/supportedLayoutTypes`` and makes the ``KeyboardApp/LocaleScreen`` add a layout picker to all added locales that support multiple layouts. 

* **Catalan**: QWERY - Catalan, QWERTY, AZERTY, QWERTZ, Colemak, Dvorak
* **Croatian**: QWERTZ, QWERTY, AZERTY, Colemak, Dvorak
* **Dutch**: QWERTY, AZERTY, QWERTZ, Colemak, Dvorak
* **Dutch_belgium**: AZERTY, QWERTY, QWERTZ, Colemak, Dvorak
* **English**: QWERTY, AZERTY, QWERTZ, Colemak, Dvorak
* **English_australia**: QWERTY, AZERTY, QWERTZ, Colemak, Dvorak
* **English_canada**: QWERTY, AZERTY, QWERTZ, Colemak, Dvorak
* **English_gb**: QWERTY, AZERTY, QWERTZ, Colemak, Dvorak
* **English_us**: QWERTY, AZERTY, QWERTZ, Colemak, Dvorak
* **Estonian**: QWERTY, QWERTZ, AZERTY, .colemak
* **Hungarian**: QWERTZ, QWERTY, AZERTY, Colemak, Dvorak
* **Indonesian**: QWERTY, QWERTZ, AZERTY, Colemak, Dvorak
* **Irish**: QWERTY, QWERTZ, AZERTY, Colemak, Dvorak
* **Italian**: QWERTY, AZERTY, QWERTZ, Colemak, Dvorak
* **Latvian**: QWERTY, QWERTZ, AZERTY, Colemak, Dvorak
* **Malay**: QWERTY, QWERTZ, AZERTY, Colemak, Dvorak
* **Polish**: QWERTY, QWERTZ, AZERTY, Colemak, Dvorak
* **Portuguese**: QWERTY, AZERTY, QWERTZ, Colemak, Dvorak
* **Portuguese_brazil**: QWERTY, AZERTY, QWERTZ, Colemak, Dvorak
* **Romanian**: QWERTY, QWERTZ, AZERTY, Colemak, Dvorak
* **Serbian_latin**: QWERTY, QWERTZ, AZERTY, Colemak, Dvorak
* **Slovenian**: QWERTZ, QWERTY, AZERTY, Colemak, Dvorak
* **Swahili**: QWERTY, AZERTY, QWERTZ, Colemak, Dvorak
* **Uzbek**: QWERTY, AZERTY, QWERTZ, Colemak, Dvorak
* **Vietnamese** TELEX, VIQR, VNI (QWERTY, AZERTY, QWERTZ for all)
* **Welsh**: QWERTY, AZERTY, QWERTZ, Colemak, Dvorak

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
