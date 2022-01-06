# Getting started

After adding KeyboardKit to your project, you can start using it in your application.

## Overview

You can use KeyboardKit in both your main application and your keyboard extension:

* The main app can use KeyboardKit to check if a keyboard is enabled, if full access is granted etc.
* The main app can use KeyboardKit-based input controllers to setup specific keyboards for its text fields.
* The keyboard extension can use KeyboardKit to get access to a lot more functionality, which helps you build more powerful keyboard extensions.

Future versions of KeyboardKit will be platform agnostic, which means that you can use KeyboardKit utils in e.g. macOS without using an actual keyboard. 


## Setting up a keyboard extension 

In your keyboard extension, let your `KeyboardViewController` inherit KeyboardKit's `KeyboardInputViewController` instead of `UIInputViewController`. 

This will give your extensoin access to a lot of additional functionality, like new lifecycle functions, observable properties like `keyboardContext` and services like `keyboardActionHandler`, `keyboardAppearance`, autocomplete logic etc.

`KeyboardInputViewController` will call `viewWillSetupKeyboard` when the keyboard should be created or re-created. You can use `setup(with:)` to setup your extension with any `SwiftUI` view, which will make it the main view, inject environment objects into it, resize the keyboard extension to fit the view etc.

Once your keyboard is created, KeyboardKit will observe context changes to automatically update the keyboard, e.g. when the keyboard type changes.  


## Configuration

You can configure your `KeyboardViewController` services to great extent and replace any service with your custom implementation.

Have a look at the demo app for more information.
