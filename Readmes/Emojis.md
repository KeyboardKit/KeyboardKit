#  Emojis

KeyboardKit defines emojis and emoji categories that you can use in your own keyboards.


## Emoji

Although you can use plain text to handle emojis, KeyboardKit has an `Emoji` type to let you handle emojis in a more structured way, as well as string extensions that let you detect and handle emojis.

KeyboardKit also has a `EmojiCategory` enum that defines the various available emoji categories and their emojis.


## Views

KeyboardKit has an `EmojiKeyboard` view that lists any provided emojis in a grid and an `EmojiCategoryKeyboard` view that replicates the system emoji keyboard and lists the provided categories and their emojis.


## Frequent Emojis

You can use the `FrequentEmojiProvider` protocol to resolve frequently used emojis. The `MostRecentEmojiProvider` implements this protocol by just keeping track of the most recently selected emojis, but you can implement your own provider as well.
