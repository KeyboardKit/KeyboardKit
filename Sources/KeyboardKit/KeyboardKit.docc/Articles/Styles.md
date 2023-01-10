# Styles

This article describes the KeyboardKit styling engine and how to use it.

KeyboardKit defines a bunch of styles that simplify customizing the look of various keyboard components.


## Appearances vs styles

Keyboard appearances are dynamic, while styles are simple structs that carry styling information for specific views. Some views, such as the ``SystemKeyboard``, need the dynamic capabilities of an appearance, while other views only need a style.



## How to modify a style

Styles are structs, so any `var` values can be modified to modify the style. 

For instance, here we adjust a ``CalloutStyle`` to use a red background:

```swift
var style = CalloutStyle.standard
style.backgroundColor = .red
CalloutStyle.standard = style
```

Almost all styles have a `.standard` style that you can replace with a custom style to change the global style of that component. 
