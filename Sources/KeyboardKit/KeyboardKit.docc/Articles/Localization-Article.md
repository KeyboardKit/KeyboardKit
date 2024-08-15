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

In KeyboardKit, each ``KeyboardLocale`` defines localized strings, assets, and locale-specific information. KeyboardKit also extends the native ``Foundation/Locale`` type with additional capabilities.

👑 [KeyboardKit Pro][Pro] unlocks localized keyboards and services for all the locales in your license. Information about Pro features can be found at the end of this article.

[Pro]: https://github.com/KeyboardKit/KeyboardKitPro



## Supported locales

KeyboardKit supports **68** keyboard-specific ``KeyboardLocale``s, like ``KeyboardLocale/english``, ``KeyboardLocale/swedish``, and ``KeyboardLocale/persian``:

🇦🇱 🇦🇪 🇦🇲 🇧🇾 🇧🇬 🇦🇩 🏳️ 🇭🇷 🇨🇿 🇩🇰 🇳🇱 🇧🇪 🇺🇸 🇬🇧 🇺🇸 🇪🇪 🇫🇴 🇵🇭 🇫🇮 🇫🇷 🇨🇦 🇧🇪 🇨🇭 🇬🇪 🇩🇪 🇦🇹 🇨🇭 🇬🇷 🇺🇸 🇮🇱 🇭🇺 🇮🇸 🏳️ 🇮🇩 🇮🇪 🇮🇹 🇰🇿 🇹🇯 🇹🇯 🇹🇯 🇱🇻 🇱🇹 🇲🇰 🇲🇾 🇲🇹 🇲🇳 🏳️ 🇳🇴 🇳🇴 🇮🇷 🇵🇱 🇵🇹 🇧🇷 🇷🇴 🇷🇺 🇷🇸 🇷🇸 🇸🇰 🇸🇮 🇪🇸 🇦🇷 🇲🇽 🇰🇪 🇸🇪 🇹🇷 🇺🇦 🇺🇿 🏴󠁧󠁢󠁷󠁬󠁳󠁿 <br />


## Locale capabilities

A keyboard locale refers to a native ``KeyboardLocale/locale`` and has localized assets and strings that can be translated with ``KKL10n``. KeyboardKit also extends the native ``Foundation/Locale`` type with a bunch of additional capabilities.

``KeyboardLocale`` has provides collection modifiers, behaviors, flags, search & sorting capabilities, and much more. For instance, you can get the ``KeyboardLocale/flag`` of a locale, translate the name of a locale with other locales, etc.

Many extensions are applied to `Locale` instead of ``KeyboardLocale``, whenever the base locale has enough information. ``KeyboardLocale`` will for the most cases not mirror these extensions, so use the ``KeyboardLocale/locale`` property to access them. 


## How to get and set locales 

The ``KeyboardContext`` can be used to get and set the current ``KeyboardContext/locale`` and available ``KeyboardContext/locales``. These properties are raw ``Foundation/Locale`` values, since a keyboard isn't limited to ``KeyboardLocale``, but there are enum-based alternatives as well.  

You can also use the ``KeyboardContext``'s ``KeyboardContext/addedLocales`` settings property to define which of the available ``KeyboardContext/locales`` that have been "added", which is meant to be an active choice by the user.

If the context ``KeyboardContext/locales`` or ``KeyboardContext/addedLocales`` has multiple values, you can select the next locale with ``KeyboardContext/selectNextLocale()`` or let the user do it with a ``KeyboardLocale/ContextMenu``. They will use ``KeyboardContext/addedLocales`` if it contains any locales, else use ``KeyboardContext/locales``.

You can automatically add a context menu to the keyboard by inserting a ``KeyboardAction/nextLocale`` action, or add a context menu to any view with the ``SwiftUI/View/keyboardLocaleContextMenu(for:locales:tapAction:)`` view modifier.


## How to change the primary language  

Setting the ``KeyboardContext/locale`` will update the controller's **primaryLanguage**, which controls things like spell checking and text direction. This also sets the keyboard's language subtitle in the keyboard switcher.

> Note: The `primaryLanguage` property seems to always return `nil`, even after it has been set properly (and works). This can be a bit confusing, but just check that the proper language is displayed in the system keyboard switcher.



## How to use LTR and RTL locales

KeyboardKit supports LTR (Left-To-Right) and RTL (Right-To-Left) locales if you use the ``KeyboardContext``. Just change the locale as explained above, and KeyboardKit will automatically adjust the text direction, spell checking, etc.

If you want to use a single RTL ``Foundation/Locale`` without using KeyboardKit, you can adjust the **Info.plist** file in your keyboard extension like this:

* Set **PrefersRightToLeft** to **1**.
* Set **PrimaryLanguage** to the language code of your locale, e.g. **fa** for Perian (Farsi).

Just be aware that setting the primary language like this may affect external keyboard mappings if you don't set the primary language.



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



## How to support more locales

If you need to use a locale (language) that KeyboardKit doesn't support yet, like Japanese or Simplified Chinese, you can either create a custom ``KeyboardView`` configuration to support it, or reach out to implement a new ``KeyboardLocale``.

To change the keys of the keyboard to fit an unsupported locale, you must implement a custom ``InputSet`` and ``KeyboardLayout``, where an input set defines the input keys and a layout defines the full layout. See the <doc:KeyboardLayout>  article for more information.

To change the texts of the system keys, you must create a custom ``KeyboardStyleProvider`` (although this will change to be easier in KeyboardKit 9). See the <doc:Styling-Article> article for more information.

To change the secondary callout actions that show when long pressing certain keys, you must create a custom ``CalloutService``. See the <doc:Callouts-Article> article for more information.

Finally, you must also implement your own ``AutocompleteService``, which most probably will involve integrating with a lightweight model that doesn't take up too much memory, since keyboard extensions are limited to ~70MB.


## How to help KeyboardKit Pro support more locales

If you have expertise on a certain locale that you want KeyboardKit to support, you can reach out to help adding it to KeyboardKit Pro.

If a locale gets added as a result of your contribution, you will get a free Basic license or a discount on higher plans. See the website for more infromation on how to get in touch.   



## Views

The ``KeyboardLocale`` namespace has locale-specific views, that can be used to perform native locale operations, pick locales, etc.

@TabNavigator {
    
    @Tab("KeyboardLocale.ContextMenu") {
        
        ``KeyboardLocale`` has a ``KeyboardLocale/ContextMenu`` that can be used to change the ``KeyboardContext`` ``KeyboardContext/locale`` from a callout context menu: 
        
        @Row {
            @Column {}
            @Column(size: 3) {
                ![Locale Context Menu](localecontextmenu)
            }
            @Column {}
        }
        
        ``KeyboardView`` applies this menu to every key that triggers the ``KeyboardAction/nextLocale`` action, as well as to the space bar, if the ``Gestures/SpaceLongPressBehavior`` is set to ``Gestures/SpaceLongPressBehavior/openLocaleContextMenu``.
        
        You can also add this menu to any view with the ``SwiftUI/View/keyboardLocaleContextMenu(for:locales:tapAction:)`` view modifier.
    }
}


## 👑 KeyboardKit Pro

[KeyboardKit Pro][Pro] unlocks more ``InputSet``s, a ``KeyboardLayoutService`` and a ``CalloutService`` for every locale in your license. 

This lets KeyboardKit create a fully localized ``KeyboardView`` for every locale, with no additional code needed. You can customize any part for any locale at any time, whenever needed.

After setting up KeyboardKit Pro with your license key, as described in the <doc:Getting-Started> article, you can just change the ``KeyboardContext/locale`` to automatically update the keyboard view for any locale in your license.

[Pro]: https://github.com/KeyboardKit/KeyboardKitPro
