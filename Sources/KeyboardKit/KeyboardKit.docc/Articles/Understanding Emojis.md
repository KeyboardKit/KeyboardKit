# Understanding Actions

This article describes the KeyboardKit emoji model and how to use it. 


## Emojis

KeyboardKit has an ``Emoji`` type that lets you handle emojis in a more structured way.

You can create an emoji like this:

```swift
let emoji = Emoji("😀")
```

and get all available emojis like this:

```swift
let emojis = Emoji.all
```

Using this way to handle emojis makes it easy to iterate over emojis in SwiftUI, since ``Emoji`` is `Identifiable`.

You also get access to additional information, such as the emoji's unique unicode identifier and unicode-based name:

```swift
let emoji = Emoji("😀")
let id = emoji.unicodeIdentifier // -> \\N{GRINNING FACE}
let name = emoji.unicodeName // -> Grinning Face
```

KeyboardKit Pro also adds support for skin tone variants, which brings even more power to the emoji model.



## Emoji Categories

KeyboardKit has an ``EmojiCategory`` enum that defines all available emoji categories, such as `.smileys`, `.animals`, `.foods` etc. 

You can get all emoji in the category like this:

```swift
let category = EmojiCategory.animals
let emojis = category.emojis
```

and get all available categories like this:

```swift
let categories = EmojiCategory.all
```


## Emoji Views

KeyboardKit has an ``EmojiKeyboard`` view that can be used to list emojis in a grid, as well as an ``EmojiCategoryKeyboard`` view that replicates the iOS stock emoji keyboard by listing the provided categories and their emojis.



## Frequent Emojis

You can use the ``FrequentEmojiProvider`` protocol to resolve frequently used emojis. The ``MostRecentEmojiProvider`` implements this protocol by just keeping track of the most recently selected emojis, but you can implement your own provider as well.
