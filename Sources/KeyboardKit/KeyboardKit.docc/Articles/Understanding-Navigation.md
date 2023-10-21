# Understanding Navigation

This article describes the KeyboardKit navigation engine.

Keyboards sometimes have to open urls, trigger deeplinks or navigate from the keyboard to the main app. This is however hard, since keyboard extensions can't use **UIApplication.main**.

KeyboardKit therefore has a ``KeyboardUrlOpener`` that can open any URLs from a keyboard extension, without using **UIApplication**.

[KeyboardKit Pro][Pro] unlocks a **PreviousAppNavigator** that can navigate back to the previously opened app, e.g. after dictation. Information about Pro features can be found at the end of this article.



## How to open URLs from the keyboard extension

The ``KeyboardUrlOpener`` class can be used to open any URL from a keyboard without having to use **UIApplication**.

The class has a ``KeyboardUrlOpener/shared`` instance that can be used from anywhere:

```swift
let url = URL(string: "https://keyboardkit.com")
try? KeyboardUrlOpener.shared.open(url)
```

This is for instance used by the KeyboardKit Pro dictation engine, to navigate from the keyboard to the main app to start dictation.



## 👑 Pro features

[KeyboardKit Pro][Pro] unlocks a `PreviousAppNavigator` that can be used to navigate back to the previous app, e.g. after dictation.

This is a protocol, so any type can implement it:

```swift
struct ContentView: View, PreviousAppNavigator {

    var body: some View {
        Button("Go back") {
            do {
                try navigateBackToPreviousApp()
            } catch {
                print(error)
            }
        }
    }
}
```

This is used by the Pro dictation engine, to navigate from the main app back to the keyboard to finish dictation.

> Warning: As of iOS 17, the PreviousAppNavigator doesn't work anymore. Make sure to adjust your UI accordingly, until it's replaced by a working solution.


[Pro]: https://github.com/KeyboardKit/KeyboardKitPro   
