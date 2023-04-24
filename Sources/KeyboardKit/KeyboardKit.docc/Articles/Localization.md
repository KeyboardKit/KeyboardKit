# Localization

This article describes the KeyboardKit localization model and how to use it.

In KeyboardKit, the ``KeyboardLocale`` enum defines keyboard-specific locales. Each keyboard locale has localized content and assets and specifies a native `Locale` that provides locale-specific information.

[KeyboardKit Pro][Pro] specific features are described at the end of this document.



## Supported locales

KeyboardKit supports 61 keyboard-specific locales:

🇦🇱 🇦🇪 🇦🇲 🇧🇾 🇧🇬 🇦🇩 🏳️ 🇭🇷 🇨🇿 🇩🇰 <br />

🇳🇱 🇧🇪 🇺🇸 🇬🇧 🇺🇸 🇪🇪 🇫🇴 🇵🇭 🇫🇮 🇫🇷 <br />

🇧🇪 🇨🇭 🇬🇪 🇩🇪 🇦🇹 🇨🇭 🇬🇷 🇺🇸 🇮🇱 🇭🇺 <br />

🇮🇸 🇮🇩 🇮🇪 🇮🇹 🇰🇿 🇹🇯 🇹🇯 🇹🇯 🇱🇻 🇱🇹 <br />

🇲🇰 🇲🇾 🇲🇹 🇲🇳 🇳🇴 🇮🇷 🇵🇱 🇵🇹 🇧🇷 🇷🇴 <br />

🇷🇺 🇷🇸 🇷🇸 🇸🇰 🇸🇮 🇪🇸 🇰🇪 🇸🇪 🇹🇷 🇺🇦 <br />

🇺🇿 <br />

Each keyboard locale refers to a native `Locale`s and have additional flag information as well as localized strings that can be translated using the ``KKL10n`` enum. All other locale-specific information can be retrieved from the native ``KeyboardLocale/locale``, such as the localized name, text and line direction etc.



## How to change the current keyboard locale 

You can change the current keyboard locale by setting the ``KeyboardInputViewController/keyboardContext`` ``KeyboardContext/locale`` or use the more convenient setter functions that support using both `Locale` and ``KeyboardLocale``. 

Setting the locale will also by default update the controller's `primaryLanguage`, which controls things like spellchecking and text direction. However, do note that `primaryLanguage` will always return `nil` even after you've set it to a custom value.

You can set the available locales for a keyboard extension by setting the ``KeyboardInputViewController/keyboardContext`` ``KeyboardContext/locales`` to the locales you want to use. This makes it possible to switch locale using ``KeyboardContext/selectNextLocale()`` or a ``LocaleContextMenu``.

The reason why ``KeyboardContext`` uses a regular `Locale` and not a ``KeyboardLocale`` is that it should be able to use any locales without having to create a new ``KeyboardLocale``.



## How to translate localized content

Every ``KeyboardLocale`` has localized strings in `Resources/<id>.lproj/Localizable.strings`. 

Localized strings can be translated using the ``KKL10n`` enum. 

For instance, this translates the numeric button key for the current locale:

```
let translation = KKL10n.keyboardTypeNumeric.text
```

To translate the same text for a certain ``KeyboardLocale`` or `Locale`, you can use any of the various `text(for:)` functions:

```
let translation = KKL10n.keyboardTypeNumeric.text(for: .spanish)
```

Besides localized strings, KeyboardKit lets you get a flag for a locale or keyboard locale, using the ``KeyboardLocale/flag`` property.



## How to build keyboard language settings

A common scenario for a multi-locale keyboard app is to let users control which locales to use. This can often be done in both the app and the keyboard extension, which means that the two targets must be able to share data.

You can use an app group-based `UserDefaults` instance to easily share data between multiple targets:

```swift
extension UserDefaults {

   static let shared = UserDefaults(suiteName: "group.myapp.com")
}
```

For this to work, make sure to register your app group to be used by both the app and its keyboard extension.

If you want to use ``KeyboardLocale`` with the convenient `@AppStorage`, you must first add this `Array` extension to make it possible for `@AppStorage` to handle `Codable` collections:

```swift
extension Array: RawRepresentable where Element: Codable {

    public init?(rawValue: String) {
        guard
            let data = rawValue.data(using: .utf8),
            let result = try? JSONDecoder().decode([Element].self, from: data)
        else { return nil }
        self = result
    }

    public var rawValue: String {
        guard let data = try? JSONEncoder().encode(self),
            let result = String(data: data, encoding: .utf8)
        else { return "" }
        return result
    }
}
```

With this in place, you can now create convenient keyboard language settings like this:

```swift
public class LanguageSettings: ObservableObject {

    /// The prefix to apply to all store keys.
    public static var keyPrefix: String = "com.keyboardkit."

    /// The store to use, by default `.shared`.
    public static var store: UserDefaults? = .shared

    /**
     Get all enabled locales.
     */
    @AppStorage("\(keyPrefix)enabledLocales", store: store)
    public var enabledLocales: [KeyboardLocale] = [.english]

    /**
     Get all selected locales.
     */
    @AppStorage("\(keyPrefix)selectedLocale", store: store)
    public var selectedLocale: KeyboardLocale = .english
}
```

The reason to why this is not (yet) in the library is that the `Array` extension may collide with other extensions in your apps, and that the settings are very easy to implement once you can use `@AppStorage`.



## How to add a new keyboard locale

Since each ``KeyboardLocale`` is hard-coded into the library, new keyboard locales must be hard-coded in the same way.

You can add new keyboard locales by following these steps:

* Fork the KeyboardKit project and create a feature branch.
* Create a new ``KeyboardLocale`` case and define all required properties.
* Provide a `Resources/<id>.lproj` folder with localized strings for the new locale.
* Make sure that linting works and that all tests pass, then push your changes to your fork. 
* Create a pull request in the main KeyboardKit repository, from your specific fork and feature branch.

In the PR, please provide any additional information that is needed to correctly support the locale.

Usage of the various keys can be found in the following places:

* `done` - Apple Calendar, when adding new activity and tapping place or video call.
* `go` - Mobile Safari, when typing a url.  
* `join` - System Settings, when joining a wi-fi network with password.
* `next` - System Settings, when joining an enterprise wi-fi network with username and password.
* `ok` - A standard OK button.
* `return` - Apple Notes, when typing.
* `search` - Mobile Safari, when typing in the google.com search bar.
* `send` - Some chat apps (WeChat, QQ), when typing in a chat text field.
* `space` - The text that is displayed on the space bar.

Once the locale is merged into the main repo, [KeyboardKit Pro][Pro] will add a ``CalloutActionProvider``, ``InputSetProvider`` and ``KeyboardLayoutProvider`` for the locale.   



## 👑 Pro features

[KeyboardKit Pro][Pro] unlocks additional localization capabilities.

KeyboardKit Pro unlocks an ``InputSetProvider``, ``KeyboardLayoutProvider`` and ``CalloutActionProvider`` for each ``KeyboardLocale``, which means that you can create a fully localized ``SystemKeyboard`` with a single line of code.



[Pro]: https://github.com/KeyboardKit/KeyboardKitPro
