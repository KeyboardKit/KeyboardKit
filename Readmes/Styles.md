# Styles

KeyboardKit defines a bunch of styles that simplify customizing the look of various keyboard components and buttons.


## Styles

KeyboardKit has a bunch of style structs that can be used to style certain views. 

Using styles gives you a very flexible way of styling your keyboard views.

Almost all styles have a `.standard` style. You can set this to a custom value to change the global style of that component.


## Appearance vs. Style

In KeyboardKit, some views are styled with an `appearance`, while some are styled with a `style`.

The difference between appearances and styles, are that appearances are dynamic, while styles are fixed.

Dynamic views use appearances, since their look can change depending on their context, while basic views use fixed styles.    


## Optional

It's woth repeating that the styling concept is just a convenience. KeyboardKit doesn't force you to stick with a specific look or layout. Your keyboard extensions can look and behave however you want.
