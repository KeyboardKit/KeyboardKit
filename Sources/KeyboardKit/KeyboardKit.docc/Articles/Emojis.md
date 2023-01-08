# Emojis

This article describes the KeyboardKit emoji model and how to use it.

KeyboardKit provides you with emojis, emoji categories, an emoji localization engine etc., as well as various emoji keyboards.

[KeyboardKit Pro][Pro] specific features are described at the end of this document.


## Emojis

KeyboardKit has an ``Emoji`` type that lets you handle emojis in a structured way.:

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

[KeyboardKit Pro][Pro] also adds support for skin tone variants. See more about this further down.



## Emoji categories

KeyboardKit has an ``EmojiCategory`` enum that defines all available emoji categories, such as `.smileys`, `.animals`, `.foods` etc.:

```swift
let category = EmojiCategory.animals
let emojis = category.emojis    // 🐶🐱🐭🐹🐰🦊🐻🐼🐻‍❄️🐨 ...
```

You can get all available categories like this:

```swift
let categories = EmojiCategory.all
```

There is also a `.frequent` category that is handled with a ``FrequentEmojiProvider``. The ``MostRecentEmojiProvider`` implements this protocol by keeping track of the most recently tapped emojis. You can also implement a custom provider. 



## Views

KeyboardKit has an ``EmojiKeyboard`` that can lists emojis in a grid, as well as an ``EmojiCategoryKeyboard`` that replicates the iOS emoji keyboard by listing the provided categories and their emojis. They can both be styled with an ``EmojiKeyboardStyle``.



## How to localize emoji names

The ``Emoji`` ``Emoji/localizedName(for:)-7ro82`` functions use `Localizable.strings` files in `Sources/Resources`. Emojis that lack a localized name will use the ``Emoji/unicodeName`` property as default name.

To localize emojis for a certain locale, simply add localized strings for the various emojis in the correct `Localizable.strings` file, then create a PR and ask for your changes to be merged.

Localizing emojis is a major undertaking and therefore a community effort. If you find emojis with poor or invalid translations, please create a PR to fix this or create an issue to let us know.



## 👑 Pro features

[KeyboardKit Pro][Pro] unlocks additional emoji capabilities.


### Additional information

KeyboardKit Pro unlocks a ``ProEmojiInfo`` protocol that is implemented by ``Emoji`` and provides additional emoji information, such as skin tone variant information:

```swift
Emoji("👍").hasSkinToneVariants     // true
Emoji("🚀").hasSkinToneVariants     // false

Emoji("👍🏿").neutralSkinToneVariant  // 👍

Emoji("👍").skinToneVariants        // 👍👍🏻👍🏼👍🏽👍🏾👍🏿
Emoji("👍").skinToneVariantActions  // The above variants as keyboard actions
```

These properties make it possible to resolve all skin tone variants for an emoji that has it.


### Additional emoji callouts

Since KeyboardKit Pro unlocks skin tone variants, it will also unlock skin tone variant callout actions for all emojis that has skin tone variants. This means long pressing an emoji that has skin tone variants, will show those variants in a callout.



[Pro]: https://github.com/KeyboardKit/KeyboardKitPro
