# Localization

This has instructions on how to implement new keyboard locales.


## How to add a new keyboard locale

Each `KeyboardLocale` is hard-coded and must be added to the library like this:

* Fork the KeyboardKit project and create a feature branch.
* Create a new ``KeyboardLocale`` case.
* Make sure that the project builds, by adding locale support where needed.
* Make sure that the unit tests pass, by adding locale-based tests where needed.
* Create a new `Resources/<id>.lproj` folder for the new locale.
* Copy an existing `Localizable.strings` file from another folder.
* Translate all `Localizable.strings` as described below.
* Commit and push your changes.
* Create a pull request.

In the PR, please provide any additional information that is needed to correctly support the locale.


## How to translate localized keys

The `Localizable` file is divided into 4 sections:

* The locale code
* Primary buttons
* Keyboard switchers
* Emojis (optional)

The various primary buttons can be found like this:

* `continue` - ?
* `done` - Apple Calendar, when adding new activity and tapping place or video call.
* `emergencyCall`- ?
* `go` - Mobile Safari, when typing a url.  
* `join` - System Settings, when joining a wi-fi network with password.
* `next` - System Settings, when joining an enterprise wi-fi network with uid/pwd.
* `ok` - A standard OK button.
* `return` - Apple Notes, when typing.
* `route` - Apple Notes, when typing.
* `search` - Mobile Safari, when typing in the google.com search bar.
* `send` - Some chat apps (WeChat, QQ), when typing in a chat text field.
* `space` - The text that is displayed on the space bar.   


### Emojis

Emojis can be localized as well, but that is a massive undertaking. Have a look at the English localization file for an example.
