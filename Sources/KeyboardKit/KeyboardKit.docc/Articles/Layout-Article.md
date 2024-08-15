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

In KeyboardKit, an ``InputSet`` is used to create a ``KeyboardLayout``, where the input set specifies input keys and the layout specifies the full keyboard layout.

KeyboardKit has a ``KeyboardLayoutService`` protocol that is implemented by classes that can create keyboard layouts, as well as many base classes that create standard layouts that can then be customized.

👑 [KeyboardKit Pro][Pro] unlocks localized input sets and layout services for all locales, as well as additional sets like ``InputSet/qwertz`` and ``InputSet/azerty``, and support for iPad Pro. Information about Pro features can be found at the end of this article.



## Input Sets

An ``InputSet`` set specifies the input keys of a keyboard. It makes it easy to define different input keys for the same keyboard layout.

KeyboardKit comes with some pre-defined input sets, like ``InputSet/qwerty``, ``InputSet/numeric(currency:)`` and ``InputSet/symbolic(currencies:)``.



## Keyboard Layouts

A ``KeyboardLayout`` specifies the full set of keys om a keyboard. Layouts vary greatly for different device types, screen orientations, locales, keyboard configurations, etc.

For instance, most iOS keyboards have 3 input key rows, where the input keys are surrounded by actions, as well as a bottom row with a space key and contextual action and input keys.

This is however not always true. Most layouts are different on iPhone and iPad, and many locales make changes to the entire layout, not just inputs. For instance, Armenian keyboards use 4 rows, Arabic keyboards remove some action buttons, etc.



## Keyboard Layout Services

Given all this, the layout engine has to be flexible. KeyboardKit has a ``KeyboardLayoutService`` that generates layouts at runtime, based on many different factors. Layout services can use any information to tweak any part of a layout at any time.

KeyboardKit automatically creates an instance of ``KeyboardLayout/StandardService`` and injects it into ``KeyboardInputViewController/services``. You can replace it at any time, as described further down, or inject localized services into it.



## How to create a custom layout service

You can create a custom layout service to customize the layout for certain locales or devices, or to provide a completely custom layout.

You can implement the ``KeyboardLayoutService`` protocol from scratch, or inherit and customize any of the ``KeyboardLayout/StandardService``, ``KeyboardLayout/BaseService``, ``KeyboardLayout/DeviceBasedService``, ``KeyboardLayout/iPadService``, ``KeyboardLayout/iPadProService``, or ``KeyboardLayout/iPhoneService`` base classes. 

For instance, here's a custom service that inherits ``KeyboardLayout/StandardService``, then injects a ``KeyboardAction/tab`` key into the layout:

```swift
class CustomKeyboardLayoutService: KeyboardLayout.StandardService {
    
    override func keyboardLayout(for context: KeyboardContext) -> KeyboardLayout {
        let layout = super.keyboardLayout(for: context)
        var rows = layout.itemRows
        var row = layout.itemRows[0]
        let next = row[0]
        let size = KeyboardLayout.ItemSize(width: .available, height: next.size.height)
        let tab = KeyboardLayout.Item(action: .tab, size: size, insets: next.insets)
        row.insert(tab, at: 0)
        rows[0] = row
        layout.itemRows = rows
        return layout
    }
}
```
To use your custom service instead of the standard one, just inject it into ``KeyboardInputViewController/services`` by replacing its ``Keyboard/Services/layoutService`` property:

```swift
class KeyboardViewController: KeyboardInputViewController {

    override func viewDidLoad() {
        services.layoutService = CustomKeyboardLayoutService()
        super.viewDidLoad()
    }
}
```

This will make KeyboardKit use your custom implementation instead of the standard one.



## 👑 KeyboardKit Pro

[KeyboardKit Pro][Pro] unlocks a localized ``KeyboardLayoutService`` for every locale in your license, which are injected as localized services into the main ``Keyboard/Services/calloutService`` when a valid license is registered.

KeyboardKit Pro also unlocks more standard input sets, like QWERTZ and AZERTY, adds more capabilities to the ``KeyboardLayout`` and in general makes it a lot easier to work with layouts


### More Input Sets

KeyboardKit Pro unlocks more input sets, like ``InputSet/qwertz`` and ``InputSet/azerty``. These are used by some of the localized layouts, but you can use them separately as well.


### More KeyboardLayout functionality

KeyboardKit Pro unlocks more ``KeyboardLayout`` capabilities, like ``KeyboardLayout/adjusted(for:layoutConfiguration:)``, ``KeyboardLayout/copy()``, and ``KeyboardLayout/createIdealItem(for:width:alignment:)``, which are used by some other Pro features.


### iPad Pro Layout Service

KeyboardKit Pro unlocks an ``KeyboardLayout/iPadProService`` that can be used to generate iPad Pro-specific layouts. It's used by some locales, and will be added to more locales over time. 


### Pro Layout Services

KeyboardKit Pro unlocks a localized ``KeyboardLocale/ProService`` for every locale in your license. 

You can access any service in your license like this:

```swift
let swedish = try KeyboardLayout.ProService.Swedish()
```

> Important: These services will throw a license error if their locales are not included in the license.


### How to customize a Pro service

You can inherit and customize any ``KeyboardLocale/ProService``, then manually register your service *after* registering your license key:

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
