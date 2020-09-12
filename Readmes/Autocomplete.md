# Autocomplete

KeyboardKit comes with built-in components for implementing audiocomplete support.

To add audiocomplete support to your keyboard extension, you must implement a custom `AutocompleteSuggestionProvider` and use it to provide the keyboard with suggestions.

You can then use the built-in views to display autocomplete suggestions.


## UIKit

If you use `UIKit` to create your keyboard extension, you can use the following views:

* `AutocompleteToolbarView`
* `AutocompleteToolbarSeparator`

Have a look at the demo app for examples.


## SwiftUI

If you use `SwiftUI` to create your keyboard extension, you currently have to implement autocomplete support yourself.

[KeyboardKitSwiftUI][KeyboardKitSwiftUI] currently has no autocomplete support.


[KeyboardKitSwiftUI]: https://github.com/danielsaidi/KeyboardKitSwiftUI
