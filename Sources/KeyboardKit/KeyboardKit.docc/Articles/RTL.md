# RTL

KeyboardKit supports RTL (right-to-left) locales, which means that it supports locales like ``KeyboardLocale/arabic``,  ``KeyboardLocale/persian`` etc.


## How to see if a locale is LTR or RTL

``KeyboardLocale`` has ``KeyboardLocale/isLeftToRight`` and ``KeyboardLocale/isRightToLeft`` properties to help you determine which locales are left-to-right and which are right-to-left.

``KeyboardLocale`` also has ``KeyboardLocale/allLtr`` and ``KeyboardLocale/allRtl`` properties to help you get all LTR and RTL locales:

```swift
let ltr = KeyboardLocale.allLtr
let rtl = KeyboardLocale.allRtl
```

This also works on any locale collections, which means that you can use `.allLtr` and `.allRtl` when providing a locale collection.



## How to configure a keyboard extension to use RTL

To enable RTL for a keyboard extension, just adjust the keyboard extension `Info.plist` as such:

* Set `PrefersRightToLeft` to `1`.
* Set `PrimaryLanguage` to the language code of your primary RTL language, e.g. `fa` for Perian (Farsi).

This will make the interface flow from right to left instead of from left to right.



## How to mix LTR and RTL in a keyboard extension

KeyboardKit currently doesn't support mixing LTR and RTL in the same keyboard extension. To support both LTR and RTL, you must create two different keyboard extensions.

You can however support multiple locales in the same extension, as long as they have the same text direction. 
