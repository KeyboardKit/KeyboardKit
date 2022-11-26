# Understanding Emojis

This article describes the KeyboardKit emoji model and how to use it.

[KeyboardKit Pro][Pro] specific features are described at the end of this document.


## Emojis

KeyboardKit has an ``Emoji`` type that lets you handle emojis in a structured way.

You can create an emoji like this:

```swift
let emoji = Emoji("😀")
```

and get all available emojis like this:

```swift
let emojis = Emoji.all
```

You can also get access to additional information, such as the emoji's unique unicode identifier and unicode-based name:

```swift
let emoji = Emoji("😀")
let emojiId = emoji.unicodeIdentifier // -> \\N{GRINNING FACE}
let emojiName = emoji.unicodeName // -> Grinning Face
```

KeyboardKit Pro also adds support for skin tone variants. See more about this further down.



## Emoji Categories

KeyboardKit has an ``EmojiCategory`` enum that defines all available emoji categories, such as `.smileys`, `.animals`, `.foods` etc. 

You can get an emoji category like this:

```swift
let category = EmojiCategory.animals
let emojis = category.emojis    // 🐶🐱🐭🐹🐰🦊🐻🐼🐻‍❄️🐨 ...
```

and get all available categories like this:

```swift
let categories = EmojiCategory.all
```

There is also a `.frequent` category that is handled with a ``FrequentEmojiProvider``. The ``MostRecentEmojiProvider`` implements this protocol by keeping track of the most recently tapped emojis, but you can implement a custom provider as well. 



## Emoji Views

KeyboardKit has an ``EmojiKeyboard`` that can lists emojis in a grid, as well as an ``EmojiCategoryKeyboard`` that replicates the iOS stock emoji keyboard by listing the provided categories and their emojis. They can both be styled with an ``EmojiKeyboardStyle``.

There are also an ``EmojiKeyboardItem`` and other views that are used by these views, but that can also be used as standalone views.



## 👑 Pro Features

KeyboardKit Pro unlocks additional emoji capabilities.


### Additional information

[KeyboardKit Pro][Pro] unlocks a ``ProEmojiInfo`` protocol that is implemented by ``Emoji`` and provides additional emoji information.

For instance, the protocol provides skin tone variant information, such as ``hasSkinToneVariants``, ``neutralSkinToneVariant`` and ``skinToneVariants``:

```swift
Emoji("👍").hasSkinToneVariants     // true
Emoji("🚀").hasSkinToneVariants     // false

Emoji("👍🏿").neutralSkinToneVariant  // 👍

Emoji("👍").skinToneVariants        // 👍👍🏻👍🏼👍🏽👍🏾👍🏿
Emoji("👍").skinToneVariantActions  // The above variants as keyboard actions
```

These properties make it possible to resolve all skin tone variants for an emoji that has it.


### Additional action callout items

Since KeyboardKit Pro unlocks skin tone variants, it will also unlock skin tone variant callout actions for all emojis that has skin tone variants.

This means long pressing an emoji that has skin tone variants, will show those variants in a callout.



[Pro]: https://github.com/KeyboardKit/KeyboardKitPro
