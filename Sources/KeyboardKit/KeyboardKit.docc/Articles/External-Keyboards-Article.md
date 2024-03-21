# External Keyboards

@Metadata {
    
    @PageImage(
        purpose: card,
        source: "Page",
        alt: "Page icon"
    )
    
    @PageColor(blue)
}

This article describes the KeyboardKit external keyboard engine.

A keyboard extension should be able to detect if an external keyboard is connected, since it will causes it to stop working as expected. 
For instance, the text document proxy will not update while you type on an external keyboard.

Keyboard extensions have little native support for this. It's pretty tricky to detect external keyboards and involves other frameworks.

👑 [KeyboardKit Pro][Pro] therefore unlocks tools that help you easily detect if an external keyboard is connected to the device, for instance if a magic keyboard is connected to an iPad.


## More Information

Keyboard extensions start to behave strangely when you type on an external keyboard. For instance, the keyboard extension will stop receiving information about when text changes. This makes it hard to provide features like autocomplete. 

Using a scheduled timer to continuously check the text doesn't help, since the text document proxy will not update until you interact with the keyboard extension or move the text input cursor.

One way to force the proxy to update is to move the text cursor with a fixed interval, to make the keyboard read the current text. This may interfere however with the typing, so it's not encouraged.

Due to this limitation, it may be better to collapse the keyboard to a compact toolbar when an external keyboard is connected. You can always add a button that expands the keyboard again.


## 👑 Pro features

KeyboardKit has an ``ExternalKeyboardContext`` that can detect if an external keyboard is connected, such as the Smart Keyboard Folio, Magic Keyboard, Bluetooth keyboards, etc.

Unlike other contexts, this context is not automatically setup when the keyboard launches. To use it, just set it up as an observed object:

```swift
struct CustomKeyboardView: View {

   @StateObject
   var context = ExternalKeyboardContext()

   var body: some View {
       VStack {
           Text("Is an external keyboard connected?")
           Text(stateDescription)
       }
       .environmentObject(context)
   }

   var stateDescription: String {
       context.isExternalKeyboardConnected.description
   }
}
```

In the code above, we also inject the context into the view hierarchy as an environment object, to make its state available to other views.

> Warning: This context will consider an Apple Smart Keyboard Folio to be connected, even when it's just snapped on to the device and not actively being used.



[Pro]: https://github.com/KeyboardKit/KeyboardKitPro
