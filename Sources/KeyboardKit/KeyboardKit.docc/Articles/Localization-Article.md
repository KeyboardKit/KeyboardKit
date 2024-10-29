# Localization

This article describes the KeyboardKit localization engine.

@Metadata {

    @PageImage(
        purpose: card,
        source: "Page",
        alt: "Page icon"
    )

    @PageColor(blue)
}

A flexible localization engine is an important part of a keyboard, where every supported locale should be able to localize the keyboard and its texts, keys and secondary callout actions.

In KeyboardKit, all ``Foundation/Locale/keyboardKitSupported`` locales define localized strings, assets, and locale-specific information. KeyboardKit also extends the native ``Foundation/Locale`` type with additional capabilities.

👑 [KeyboardKit Pro][Pro] unlocks localized keyboards and services for all the locales in your license. Information about Pro features can be found at the end of this article.

[Pro]: https://github.com/KeyboardKit/KeyboardKitPro



## Locale namespace

KeyboardKit extends ``Foundation/Locale`` and uses it as a namespace for locale-related types and views, like the locale-specific ``Foundation/Locale/ContextMenu``.



## Supported locales

KeyboardKit supports **70** keyboard-specific ``Foundation/Locale``s, like ``Foundation/Locale/english``, ``Foundation/Locale/swedish``, and ``Foundation/Locale/persian``:

🇺🇸 🇦🇱 🇦🇪 🇦🇲 🇧🇾 🇧🇬 🇦🇩 🏳️ 🇭🇷 🇨🇿 🇩🇰 🇳🇱 🇧🇪 🇦🇺 🇨🇦 🇬🇧 🇺🇸 🇪🇪 🇫🇴 🇵🇭 🇫🇮 🇫🇷 🇨🇦 🇧🇪 🇨🇭 🇬🇪 🇩🇪 🇦🇹 🇨🇭 🇬🇷 🇺🇸 🇮🇱 🇭🇺 🇮🇸 🏳️ 🇮🇩 🇮🇪 🇮🇹 🇰🇿 🇹🇯 🇹🇯 🇹🇯 🇱🇻 🇱🇹 🇲🇰 🇲🇾 🇲🇹 🇲🇳 🏳️ 🇳🇴 🇳🇴 🇮🇷 🇵🇱 🇵🇹 🇧🇷 🇷🇴 🇷🇺 🇷🇸 🇷🇸 🇸🇰 🇸🇮 🇪🇸 🇦🇷 🇲🇽 🇸🇪 🇰🇪 🇹🇷 🇺🇦 🇺🇿 🏴󠁧󠁢󠁷󠁬󠁳󠁿 


## Locale capabilities

KeyboardKit extends ``Foundation/Locale`` with localized strings that can be translated with ``KKL10n``, as well as collection modifiers, locale-specific properties like ``Foundation/Locale/localizedName``, ``Foundation/Locale/flag`` inforamation, search & sorting capabilities, and much more.

See the native ``Foundation/Locale`` type's documentation for a complete list of KeyboardKit extensions. 



## How to get and set locales 

The ``KeyboardContext`` can be used to get and set the current ``KeyboardContext/locale`` and the available ``KeyboardContext/locales``. You can also use the context's ``KeyboardContext/settings-swift.property`` to set which of the available locales to explicitly add to the keyboard.

If ``KeyboardContext/locales`` or the ``KeyboardContext/settings-swift.property``'s added locales has multiple values, you can select the next locale with ``KeyboardContext/selectNextLocale()`` or let the user select locales with a ``Foundation/Locale/ContextMenu``.

You can automatically add a context menu to the keyboard by inserting a ``KeyboardAction/nextLocale`` button, or add a context menu to any view with the ``SwiftUICore/View/localeContextMenu(for:locales:tapAction:)`` view modifier.



## How to change the primary language  

Setting the ``KeyboardContext`` ``KeyboardContext/locale`` will update the controller's **primaryLanguage**, which controls things like spell checking and text direction. This also sets the keyboard's language subtitle in the keyboard switcher.

> Note: The `primaryLanguage` property seems to always return `nil`, even after it has been set properly (and works). This can be a bit confusing, but just check that the proper language is displayed in the system keyboard switcher.



## How to use LTR and RTL locales

KeyboardKit supports LTR (Left-To-Right) and RTL (Right-To-Left) locales if you use the ``KeyboardContext``. Just change the locale as explained above, and KeyboardKit will automatically adjust the text direction, spell checking, etc.

If you want to use a single RTL ``Foundation/Locale`` without using KeyboardKit, you can adjust the **Info.plist** file in your keyboard extension like this:

* Set **PrefersRightToLeft** to **1**.
* Set **PrimaryLanguage** to the language code of your locale, e.g. **fa** for Perian (Farsi).

Just be aware that setting the primary language like this may affect external keyboard mappings if you don't set the primary language.



## How to translate localized content

Each ``Foundation/Locale/keyboardKitSupported`` locale has a localized file in **Resources/[id].lproj** with texts that are applied with the ``KKL10n`` enum. 

For instance, this translates the numeric button key for the current locale:

```
let translation = KKL10n.keyboardTypeNumeric.text
```

To translate the same text for a certain ``Foundation/Locale``, you can use the various ``KKL10n/text`` functions, which take a ``Foundation/Locale`` parameter value:

```
let translation = KKL10n.keyboardTypeNumeric.text(for: .spanish)
```

Besides localized strings, you can use the context ``KeyboardContext/localePresentationLocale`` to set how locales are translated for a keyboard.



## How to support more locales

If you need to use a locale that KeyboardKit doesn't support yet, like Japanese or Simplified Chinese, you can either create a custom ``KeyboardView`` configuration to support it, or reach out to add support for a new ``Foundation/Locale``.

To fully support a certain ``Foundation/Locale``, you must add locale-specific ``CalloutService``, ``InputSet`` and ``KeyboardLayoutService`` implementations, and create a localization folder in `Resources`.

You should also implement a custom ``AutocompleteService`` if you don't use KeyboardKit Pro, or if you do and ``Autocomplete/LocalService`` doesn't support the locale you want to add.

> Tip: If you have expertise on a certain locale that you want KeyboardKit to support, you can reach out to help adding it to KeyboardKit Pro. If a locale gets added as a result of your contribution, you will get a free Basic license or a discount on the higher plans.   



## Views

KeyboardKit extends ``Foundation/Locale`` with locale-specific views, that can be used to perform native locale operations, pick locales, etc.

@TabNavigator {
    
    @Tab("Locale.ContextMenu") {
        
        The ``Foundation/Locale``-specific ``Foundation/Locale/ContextMenu`` can be used to change the current  ``KeyboardContext/locale``.
        
        @Row {
            @Column {}
            @Column(size: 3) {
                ![Locale Context Menu](localecontextmenu)
            }
            @Column {}
        }
        
        You can add this context menu to any view with the ``SwiftUICore/View/localeContextMenu(for:locales:tapAction:)`` view modifier.
        
        ``KeyboardView`` automatically applies it to every key that triggers the ``KeyboardAction/nextLocale`` action, as well as to the space bar if the ``Gestures/SpaceLongPressBehavior`` is set to ``Gestures/SpaceLongPressBehavior/openLocaleContextMenu``.
    }
}


## 👑 KeyboardKit Pro

[KeyboardKit Pro][Pro] unlocks more ``InputSet``s, a ``KeyboardLayoutService`` and a ``CalloutService`` for every locale in your license. 

This lets KeyboardKit create a fully localized ``KeyboardView`` for every locale, with no additional code needed. You can customize any part for any locale at any time, whenever needed.

After setting up KeyboardKit Pro with your license key, as described in the <doc:Getting-Started-Article> article, you can just change the ``KeyboardContext/locale`` to automatically update the keyboard view for any locale in your license.

[Pro]: https://github.com/KeyboardKit/KeyboardKitPro
