#  Extensions

KeyboardKit provides a bunch of extensions to native types, such as `UITextDocumentProxy`, and `String`. For instance:

```swift
let proxy = controller.textDocumentProxy
let isAtNewSentence = proxy.isCursorAtNewSentence

let word = proxy.wordBeforeInput
let hasEmoji = word.containsEmoji 
```

These extensions extend the capabilities of the native types and make it a lot easier to create powerful custom keyboards.

The [documentation][Documentation] currently omits native type extensions. Instead, have a look in the source code for a complete list.


[Documentation]: https://github.com/danielsaidi/Documentation/blob/main/Docs/KeyboardKit.doccarchive.zip?raw=true
