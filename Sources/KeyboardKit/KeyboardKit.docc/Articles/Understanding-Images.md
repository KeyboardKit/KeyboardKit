# Understanding Images

This article describes the KeyboardKit keyboard image collection.

KeyboardKit provides a bunch of keyboard-specific images, both SF Symbol-based and asset-based ones. 



### Symbols

KeyboardKit has `Image` extensions that resolve to SF Symbols, for instance:

```swift
Image.keyboard
Image.keyboardBackspace
Image.keyboardBackspaceRtl
```

These images are prefixed with `keyboard` so that typing `Image.keyboard` gives you a list of all available images.


### Assets

KeyboardKit also has a few `Image` extensions that resolve to embedded assets, for instance:

```swift
Image.keyboardEmoji
```

These images can be used just like the symbols-based ones, but don't scale as well. 
