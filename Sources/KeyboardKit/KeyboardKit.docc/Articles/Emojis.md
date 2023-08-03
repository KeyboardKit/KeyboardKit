# Emojis

This article describes the KeyboardKit emoji model and how to use it.

KeyboardKit provides you with an ``Emoji`` struct, an ``EmojiCategory`` enum, an emoji localization engine etc., as well as various emoji keyboard views like ``EmojiKeyboard`` and ``EmojiCategoryKeyboard``.

[KeyboardKit Pro][Pro] specific features are described at the end of this document.


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

Each emoji can also be localized with the localized files found in the `Sources/Resources` folder. Take a look at `en.lproj/Localizable.strings` for examples.



## Emoji categories

KeyboardKit has an ``EmojiCategory`` enum that defines all available emoji categories, such as `.smileys`, `.animals`, `.foods` etc.:

```swift
let category = EmojiCategory.animals
let emojis = category.emojis    // 🐶🐱🐭🐹🐰🦊🐻🐼🐻‍❄️🐨 ...
```

You can get a list of all available categories like this:

```swift
let categories = EmojiCategory.all
```

There is also a `.frequent` category that is handled with a ``FrequentEmojiProvider``. The ``MostRecentEmojiProvider`` implements this protocol by keeping track of the most recently tapped emojis. You can also implement a custom provider. 



## Views

KeyboardKit has an ``EmojiKeyboard`` that lists emojis in a grid, as well as an ``EmojiCategoryKeyboard`` that replicates the iOS emoji keyboard by listing the provided categories and their emojis. They can both be styled with an ``EmojiKeyboardStyle``.



## How to localize emoji names

The ``Emoji`` `localizedName(for:)` functions use `Localizable.strings` files in `Sources/Resources`. Emojis that lack a localized name will use the ``Emoji/unicodeName`` property as a fallback.

To localize emojis for a certain locale, simply add localized strings for the various emojis in the correct `Localizable.strings` file. This is a major undertaking and therefore a community effort. Feel free to create PRs to help out.



## 👑 Pro features

[KeyboardKit Pro][Pro] unlocks additional emoji capabilities.


### Emoji Version

KeyboardKit Pro unlocks an `EmojiVersion` type that defines Emoji versions, platform availability and included emojis.

For instance, you can get explicit versions, for instance:

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

These extensions make it possible to resolve all skin tone variants for emojis that have variations.


### Secondary callouts

Since KeyboardKit Pro unlocks skin tone variants, it will also unlock secondary action callouts for all emojis that have skin tone variants. 

This means that long pressing any emoji that has skin tone variants will show the variants in a callout.



[Pro]: https://github.com/KeyboardKit/KeyboardKitPro
