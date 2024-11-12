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


### Open a URL from a keyboard extension

The best way to open a URL from a keyboard extension, where you can't access `UIApplication.shared` is to use a SwiftUI `Link`. You can alsotrigger a ``KeyboardAction/url(_:id:)`` action and let the main ``Keyboard/Services/actionHandler`` in ``KeyboardInputViewController/services`` handle it.



### Open System Settings

KeyboardKit defines a ``Foundation/URL/systemSettings`` URL, which can be used to open your app in System Settings. If your keyboard navigates to the System Settings root instead of your app, try to add an empty settings bundle to your app. 


### Navigate back to the keyboard from the app

[KeyboardKit Pro][Pro] used to have a **PreviousAppNavigator** that could navigate back to the keyboard (in the previously open app) from the main app. As this was rejected by Apple, an **LSApplicationWorkspace** alternative was implemented, which was also rejected.

Since the lack of this navigation results in bad UX, for instance when opening the app to perform an action then return to the keyboard, KeyboardKit Pro provides a ``KeyboardHostApplication`` that lets you navigate back to the most common apps. 

You can read more in the <doc:Host-Article> article.


[Pro]: https://github.com/KeyboardKit/KeyboardKitPro   
