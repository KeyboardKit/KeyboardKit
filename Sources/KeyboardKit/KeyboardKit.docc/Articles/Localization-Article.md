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

A flexible localization engine is an important part of a keyboard, where every supported locale should be able to localize the keyboard.

In KeyboardKit, each ``KeyboardLocale`` defines localized strings, assets, and locale-specific information. KeyboardKit also extends the native ``Foundation/Locale`` type with a bunch of additional capabilities.

👑 [KeyboardKit Pro][Pro] unlocks localized keyboards and services for all the locales in your license. Information about Pro features can be found at the end of this article.

[Pro]: https://github.com/KeyboardKit/KeyboardKitPro



## Supported locales

KeyboardKit supports **68** keyboard-specific ``KeyboardLocale``s, like ``KeyboardLocale/english``, ``KeyboardLocale/swedish``, and ``KeyboardLocale/persian``:

🇦🇱 🇦🇪 🇦🇲 🇧🇾 🇧🇬 🇦🇩 🏳️ 🇭🇷 🇨🇿 🇩🇰 🇳🇱 🇧🇪 🇺🇸 🇬🇧 🇺🇸 🇪🇪 🇫🇴 🇵🇭 🇫🇮 🇫🇷 🇨🇦 🇧🇪 🇨🇭 🇬🇪 🇩🇪 🇦🇹 🇨🇭 🇬🇷 🇺🇸 🇮🇱 🇭🇺 🇮🇸 🏳️ 🇮🇩 🇮🇪 🇮🇹 🇰🇿 🇹🇯 🇹🇯 🇹🇯 🇱🇻 🇱🇹 🇲🇰 🇲🇾 🇲🇹 🇲🇳 🏳️ 🇳🇴 🇳🇴 🇮🇷 🇵🇱 🇵🇹 🇧🇷 🇷🇴 🇷🇺 🇷🇸 🇷🇸 🇸🇰 🇸🇮 🇪🇸 🇦🇷 🇲🇽 🇰🇪 🇸🇪 🇹🇷 🇺🇦 🇺🇿 🏴󠁧󠁢󠁷󠁬󠁳󠁿 <br />


## Locale capabilities

A keyboard locale refers to a native ``KeyboardLocale/locale`` and has localized assets and strings that can be translated with ``KKL10n``. KeyboardKit also extends the native ``Foundation/Locale`` type with a bunch of additional capabilities.

``KeyboardLocale`` has provides collection modifiers, behaviors, flags, search & sorting capabilities, and much more. For instance, you can get the ``KeyboardLocale/flag`` of a locale, translate the name of a locale with other locales, etc.

Many extensions are applied to `Locale` instead of ``KeyboardLocale``, whenever the base locale has enough information. ``KeyboardLocale`` will for the most cases not mirror these extensions, so use the ``KeyboardLocale/locale`` property to access them. 



## How to get and set the current keyboard locale 

The ``KeyboardContext`` can be used to get and set the current ``KeyboardContext/locale`` and available ``KeyboardContext/locales``. These properties are raw ``Foundation/Locale`` values, since a keyboard isn't limited to ``KeyboardLocale``.  The context also has ``KeyboardLocale``-specific variants.

If the context ``KeyboardContext/locales`` has multiple values, you can switch locale with ``KeyboardContext/selectNextLocale()`` or a ``KeyboardLocale/ContextMenu`` that lets the user select a locale. You can apply a locale context menu with ``SwiftUI/View/keyboardLocaleContextMenu(for:tapAction:)``.


## How to change the primary language  

Setting the ``KeyboardContext/locale`` will update the controller's **primaryLanguage**, which controls things like spell checking and text direction. This also sets the keyboard locale name in the keyboard switcher.

> Note: The `primaryLanguage` property always returns `nil`, even after being set in a way that actually works, which can be confusing.



## How to use LTR and RTL locales

KeyboardKit supports LTR (Left-To-Right) and RTL (Right-To-Left) locales.

You don't need to configure your keyboard to support RTL. Just change the keyboard locale as explained above, and KeyboardKit will automatically adjust the text direction.

If you want to use a single RTL locale, you can adjust the keyboard extension **Info.plist**:

* Set **PrefersRightToLeft** to **1**.
* Set **PrimaryLanguage** to the language code of your locale, e.g. **fa** for Perian (Farsi).

Just be aware that setting the primary language may affect external keyboard key mappings.



## How to translate localized content

Each ``KeyboardLocale`` has a `Localized.strings` file in **Resources/[id].lproj** with texts that are applied with the ``KKL10n`` enum. 

For instance, this translates the numeric button key for the current locale:

```
let translation = KKL10n.keyboardTypeNumeric.text
```

To translate the same text for a certain ``KeyboardLocale`` or `Locale`, you can use the various ``KKL10n/text`` functions, which either take ``KeyboardLocale`` or raw `Locale` values:

```
let translation = KKL10n.keyboardTypeNumeric.text(for: .spanish)
```

Besides localized strings, you can use the context ``KeyboardContext/localePresentationLocale`` to set how locales are translated for a keyboard.



## How to add a new keyboard locale

For information on how to add new keyboard locales, see **Instructions.md** in **Resources**.



## Views

The ``KeyboardLocale`` namespace has locale-specific views, that can be used to perform native locale operations, pick locales, etc.

@TabNavigator {
    
    @Tab("ContextMenu") {
        
        KeyboardKit has a ``KeyboardLocale/ContextMenu`` that can be used to change the main ``KeyboardContext`` ``KeyboardContext/locale`` from a callout context menu: 
        
        @Row {
            @Column {}
            @Column(size: 2) {
                ![Locale Context Menu](localecontextmenu)
            }
            @Column {}
        }
        
        This menu can be applied to any view. ``KeyboardView`` applies it to every key that triggers the ``KeyboardAction/nextLocale`` action, as well as to the space bar, if the ``Gestures/SpaceLongPressBehavior`` is set to ``Gestures/SpaceLongPressBehavior/openLocaleContextMenu``.
    }
}


## 👑 KeyboardKit Pro

[KeyboardKit Pro][Pro] unlocks fully localized ``InputSet``, ``KeyboardLayoutProvider`` & ``CalloutActionProvider`` implementations for every locale in your license. 

This lets KeyboardKit Pro create fully localized ``KeyboardView`` for every supported locale, with no additional code needed. You can customize any input set or provider for any locale at any time, whenever needed.

After setting up KeyboardKit Pro with your license key, as described in the <doc:Getting-Started> article, you can just change the ``KeyboardContext/locale`` to automatically update the keyboard view.

[Pro]: https://github.com/KeyboardKit/KeyboardKitPro
