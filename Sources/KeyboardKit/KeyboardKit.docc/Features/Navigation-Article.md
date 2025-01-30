# Navigation

This article describes the KeyboardKit navigation engine.

@Metadata {

    @PageImage(
        purpose: card,
        source: "Page",
        alt: "Page icon"
    )
}

A custom keyboard extension may sometimes have to open URLs or trigger deep links, for instance to open the app or System Settings.

Keyboard extensions can however not access **UIApplication.shared**, which means that you have to jump through hoops to open URLs.

KeyboardKit therefore provides ways to open URLs from a keyboard extension, without using **UIApplication.shared**.


---


## How to...


### ...open a URL from a keyboard extension

The best way to open a URL from a keyboard extension, where you can't access `UIApplication.shared` is to use a SwiftUI `Link`. You can also trigger a ``KeyboardAction/url(_:id:)`` action and let the main ``Keyboard/Services/actionHandler`` in ``KeyboardInputViewController/services`` handle it.



### ...open System Settings

KeyboardKit defines a ``Foundation/URL/systemSettings`` URL, which can be used to open your app in System Settings. If your keyboard navigates to the System Settings root instead of your app, try to add an empty settings bundle to your app. 


### ...navigate back to the keyboard from the app

If a keyboard opens the main app to perform a quick operation, it may want to automatically return to the keyboard once the operation is done. One such example is when performing dictation.

This is however not easy, since Apple continues to restrict the ways in which apps can open other apps. Previous ways to implement this have either stopped working, or will be rejected by Apple when you push them to the App Store.

Since being able to return to the keyboard from the main app is an important part of some operations, KeyboardKit Pro has therefore added a ``KeyboardHostApplication`` that lets you navigate back to the most common apps. 

You can read more in the <doc:Host-Article> article.


[Pro]: https://github.com/KeyboardKit/KeyboardKitPro   
