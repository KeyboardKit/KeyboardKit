# Localization

This article describes the KeyboardKit localization engine.

@Metadata {

    @PageImage(
        purpose: card,
        source: "Page",
        alt: "Page icon"
    )
}

A flexible localization engine is an important part of a keyboard, where every supported locale should be able to localize the keyboard and its texts, layouts, secondary callout actions, etc.

In KeyboardKit, all ``Foundation/Locale/keyboardKitSupported`` locales define localized strings, assets, and additional information. The native ``Foundation/Locale`` is also extendewd with additional capabilities.

👑 [KeyboardKit Pro][Pro] unlocks localized services for all locales in your license. Information about Pro features can be found further down.

[Pro]: https://github.com/KeyboardKit/KeyboardKitPro



## Namespace

KeyboardKit extends ``Foundation/Locale`` and uses it as a namespace for locale-related types and views, like the locale-specific ``Foundation/Locale/ContextMenu``.



## Supported locales

KeyboardKit supports **72** keyboard ``Foundation/Locale``s, like ``Foundation/Locale/english``, ``Foundation/Locale/swedish``, and ``Foundation/Locale/persian``, as defined by ``Foundation/Locale/keyboardKitSupported``:

🇺🇸 🇦🇱 🇦🇪 🇦🇲 🇧🇾 🇧🇬 🇦🇩 🏳️ 🏳️ 🇭🇷
🇨🇿 🇩🇰 🇳🇱 🇧🇪 🇦🇺 🇨🇦 🇬🇧 🇺🇸 🇪🇪 🇫🇴
🇵🇭 🇫🇮 🇫🇷 🇨🇦 🇧🇪 🇨🇭 🇬🇪 🇩🇪 🇦🇹 🇨🇭 
🇬🇷 🇺🇸 🇮🇱 🇭🇺 🇮🇸 🏳️ 🇮🇩 🇮🇪 🇮🇹 🇰🇿
🇹🇯 🇹🇯 🇹🇯 🇱🇻 🇱🇹 🇲🇰 🇲🇾 🇲🇹 🇲🇳 🏳️
🇳🇴 🇳🇴 🇮🇷 🇵🇱 🇵🇹 🇧🇷 🇷🇴 🇷🇺 🇷🇸 🇷🇸
🇸🇰 🇸🇮 🇪🇸 🇦🇷 🇲🇽 🇸🇪 🇰🇪 🇹🇷 🇺🇦 🇺🇿
🇻🇳 🏴󠁧󠁢󠁷󠁬󠁳󠁿


## Locale capabilities

KeyboardKit extends ``Foundation/Locale`` with localized strings that can be translated with ``KKL10n``, as well as collection modifiers, locale-specific properties like ``Foundation/Locale/localizedName``, ``Foundation/Locale/flag`` information, search & sorting capabilities, and much more.

```swift
let swedish = Locale.swedish
swedish.flag                         // 🇸🇪
swedish.localizedName                // svenska
swedish.localizedName(in: .english)  // Swedish
```

See the native ``Foundation/Locale`` type's documentation for a complete list of extensions that are applied to the type by KeyboardKit. 


## Views

KeyboardKit extends ``Foundation/Locale`` with keyboard-specific views, that can be used to perform locale-specific operations, pick locales, etc.

@TabNavigator {
    
    @Tab("ContextMenu") {
        
        @Row {
            @Column {
                ![Locale Context Menu](localecontextmenu-space)
            }
            @Column {
                The ``Foundation/Locale``.``Foundation/Locale/ContextMenu`` can be used to change the ``KeyboardContext/locale`` by tapping or long pressing any view that it's applied to.
                
                You can apply the menu to any view with the ``SwiftUICore/View/localeContextMenu(for:locales:tapAction:)`` view modifier.
                
                ``KeyboardView`` will automatically apply this context menu to all keys that triggers the ``KeyboardAction/nextLocale`` action.
            }
        }
    }
    
    @Tab("Spacebar") {
        @Row {
            @Column {
                ![Locale Context Menu](localecontextmenu-space)
            }
            @Column {
                The ``KeyboardView`` spacebar can be configured to open the locale context menu, based on ``KeyboardSettings/spaceLongPressBehavior``.
                
                Set the behavior to ``Keyboard/SpaceLongPressBehavior/openLocaleContextMenu`` to make it open a context menu instead of moving the input cursor.
                
                You can also a ``KeyboardSettings/spaceTrailingAction`` to add a locale context menu to the spacebar and keep its cursor move capabilities.
            }
        }
    }
}


---

## 👑 KeyboardKit Pro

[KeyboardKit Pro][Pro] unlocks more ``InputSet``s, a ``KeyboardLayoutService`` and a ``KeyboardCalloutService`` for every locale in your license. This lets KeyboardKit create a fully localized ``KeyboardView`` for every locale, with no additional code needed.

You can customize any localized service, as described in the <doc:Callouts-Article> and <doc:Layout-Article> articles. You can also read more in the How to:s below.


---

## How to...


### ...get, set and pick locales 

The ``KeyboardContext`` can be used to get and set the current ``KeyboardContext/locale`` and all available ``KeyboardContext/locales``. You can use ``KeyboardSettings/addedLocales`` to override the default ``KeyboardContext/locale`` and use ``KeyboardContext/enabledLocales`` to use either the added or the available locales.

If the ``KeyboardContext/enabledLocales`` have multiple values, you can use ``KeyboardContext/selectNextLocale()`` to loop through the proper collection. Since the ``KeyboardSettings/addedLocales`` can also define ``Keyboard/LayoutType``, the ``KeyboardContext/keyboardLayoutType`` will be updated automatically.

The ``Foundation/Locale/ContextMenu`` described above, and the spacebar, will use the ``KeyboardContext/enabledLocales`` by default, and will also set a keyboard layout type when the user selects an ``Keyboard/AddedLocale`` that defines a layout type.

You can also use the other ``KeyboardContext`` functions to select locales and layout types in various ways. Just make sure to only set a layout type that is supported by the selected locale.


### ...change the primary language

Setting the ``KeyboardContext`` ``KeyboardContext/locale`` will update the controller's **primaryLanguage**, which controls things like spell checking and text direction. This also sets the keyboard's language subtitle in the keyboard switcher.

> Note: The `primaryLanguage` property seems to always return `nil`, even after it has been set properly (and works). This can be a bit confusing, but just check that the proper language is displayed in the system keyboard switcher.


### ...translate localized content

Each ``Foundation/Locale/keyboardKitSupported`` locale has a localized file in **Resources/[id].lproj** with texts that are applied with the ``KKL10n`` enum:

```
let translation = KKL10n.keyboardTypeNumeric.text
```

To translate the same text for a certain ``Foundation/Locale``, you can use the various ``KKL10n/text`` functions, which take a ``Foundation/Locale`` parameter value:

```
let translation = KKL10n.keyboardTypeNumeric.text(for: .spanish)
```

### ...translate locale display names

You can change the ``KeyboardContext/localePresentationLocale`` to set which locale to use when displaying locales. It's set to the current locale by default, but you can change it to any locale, or set it to nil to use each locale's own language.


### ...use LTR & RTL locales

KeyboardKit supports LTR (Left-To-Right) & RTL (Right-To-Left) locales. Just change the locale as shown above, and KeyboardKit will automatically adjust the text direction, spell checking, etc.

If you want to use a single, fixed RTL locale, you can adjust the keyboard extension's **Info.plist** file like this:

* Set **PrefersRightToLeft** to **1**.
* Set **PrimaryLanguage** to the language code of your locale, e.g. **fa** for Perian (Farsi).

Just be aware that setting the primary language like this may affect external keyboard mappings if you don't set the primary language.


### ...add support for more locales

If you need a locale that KeyboardKit doesn't support yet, like Japanese or Simplified Chinese, you can implement a custom ``KeyboardView`` configuration to support it, or reach out to add support for a new ``Foundation/Locale``.

To fully support a certain ``Foundation/Locale``, you must add locale-specific ``KeyboardCalloutService``, ``InputSet`` and ``KeyboardLayoutService`` implementations, and create a `Resources` localization folder. You may also have to implement custom autocomplete logic.

> Tip: If you have expertise on a certain locale that you want KeyboardKit to support, you can reach out to help adding it to KeyboardKit Pro. If a locale gets added as a result of your contribution, you will get a free Basic license or a discount on the higher plans.   


[Pro]: https://github.com/KeyboardKit/KeyboardKitPro
