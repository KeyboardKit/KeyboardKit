# Emojis

This article describes the KeyboardKit emoji engine.

KeyboardKit provides you with ``Emoji`` types, an emoji localization engine, as well as various keyboard views like ``EmojiKeyboard`` and ``EmojiCategoryKeyboard``.

[KeyboardKit Pro][Pro] features are described at the end of this document.



## Emojis

KeyboardKit has an ``Emoji`` struct that lets you handle emojis in a structured way:

```swift
let emoji = Emoji("😀")
```

You can get all available emojis like this:

```swift
let emojis = Emoji.all
```

You can also get access to additional information, such as the emoji's unique unicode-based identifier and name, localized name etc.:

```swift
let emoji = Emoji("😀")
emoji.unicodeIdentifier // -> \\N{GRINNING FACE}
emoji.unicodeName // -> Grinning Face
emoji.localizedName(for: .swedish) // -> Leende Ansikte
```

Emojis can be localized with the localized files found in the `Sources/Resources` folder.



## Emoji categories

The ``EmojiCategory`` enum defines all available emoji categories, such as ``EmojiCategory/emojis``:

```swift
let category = EmojiCategory.animals
let emojis = category.emojis    // 🐶🐱🐭🐹🐰🦊🐻🐼🐻‍❄️🐨 ...
```

You can get a list of all available categories like this:

```swift
let categories = EmojiCategory.all
```

There is also a ``EmojiCategory/frequent`` category that is handled with a ``FrequentEmojiProvider``, such as the default ``MostRecentEmojiProvider``. 



## Views

The ``EmojiKeyboard`` just lists emojis in a grid, while the ``EmojiCategoryKeyboard`` mimics the iOS emoji keyboard by listing the provided categories and their emojis.



## How to localize emoji names

The `localizedName(for:)` function uses the string files in the `Sources/Resources` folder. Emojis that lack a localized name will use ``Emoji/unicodeName`` as a fallback.

To localize emojis for a certain locale, just add localized strings to the correct `Localizable.strings` file. This is a major undertaking and therefore a community effort.



## 👑 Pro features

[KeyboardKit Pro][Pro] unlocks additional emoji capabilities.


### Emoji Version

KeyboardKit Pro unlocks an `EmojiVersion` type that defines Emoji versions, platform availability and included emojis, for instance:

```swift
let version = EmojiVersion.v15
version.version  // 15.0
version.iOS      // 16.4
version.macOS    // 13.3
version.tvOS     // 16.4
version.watchOS  // 9.4
```

You can also get the Emoji version included in a certain platform version, for instance:

```swift
let version = EmojiVersion(iOS: 15.4)
version.version  // 14.0
```

An `EmojiVersion` can specify the emojis introduced in that version, as well as later and older versions and unavailable emojis that are introduced in later versions:

```swift
let version = EmojiVersion.v14
version.emojis         // 🫠🫢🫣🫡🫥🫤🥹...
version.laterVersions  // [.v15]
version.olderVersions  // []
version.unavailableEmojis  // 🫨🫸🫷🪿🫎🪼🫏🪽...
```

This information can be used to filter out unavailable emojis from the various ``EmojiCategory`` and ``EmojiCategoryKeyboard``.



### Skin tones

KeyboardKit Pro unlocks additional ``Emoji`` extensions to get skin tone information:

```swift
Emoji("👍").hasSkinToneVariants     // true
Emoji("🚀").hasSkinToneVariants     // false

Emoji("👍🏿").neutralSkinToneVariant  // 👍

Emoji("👍").skinToneVariants        // 👍👍🏻👍🏼👍🏽👍🏾👍🏿
Emoji("👍").skinToneVariantActions  // The above variants as keyboard actions
```

This makes it possible to get all skin tone variants for emojis that have any. Note that emojis with two skin tone components are currently not supported, such as two persons kissing.


### Secondary callouts

KeyboardKit Pro unlocks secondary callout actions for all emojis that have skin tone variants.



[Pro]: https://github.com/KeyboardKit/KeyboardKitPro
