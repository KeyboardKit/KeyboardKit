#  Emojis

KeyboardKit defines emojis and emoji categories that you can use in your own keyboards.


## Emoji Category

KeyboardKit has a `EmojiCategory` enum that defines the various available emoji categories and their emojis.

Note that keeping this list up to date is a massive job, that you are more than welcome to help out with.


## Keyboards

KeyboardKit has an `EmojiKeyboard` that just lists provided emojis in a grid.

It also has a `EmojiCategoryKeyboard` that replicates the system keyboard, and lists the provided categories and their emojis.

Note that these views are only supported in iOS 14+, which is why the `SystemKeyboard` doesn't automatically add them at the moment. 


## Frequent Emojis

You can use the `FrequentEmojiProvider` protocol to resolve frequently used emojis.

The `MostRecentEmojiProvider` implements this protocol by just keeping track of the most recently selected emojis.

You can implement your own frequent provider as well.
