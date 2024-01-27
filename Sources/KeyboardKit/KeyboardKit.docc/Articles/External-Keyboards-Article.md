# External Keyboards

This article describes the KeyboardKit external keyboard engine.

Connecting an external keyboard to your iPhone or iPad will cause your keyboard extension to stop working as expected.

For instance, the text document proxy will not update while you type on the external keyboard, which makes it impossible to provide features like autocomplete.

[KeyboardKit Pro][Pro] unlocks ways to detect if an external keyboard is connected to the device, to let you adjust your keyboard accordingly.


## Important about external keyboards

Your keyboard extension will start to behave strangely when you type on an external keyboard.

For instance, the keyboard extension will stop receiving information about when text changes. This makes it hard to provide features like autocomplete. 

Using a scheduled timer to continuously check the text doesn't help, since the text document proxy will not update until you interact with the keyboard extension.

One way to force the proxy to update is to move the text cursor, but this may interfere with the typing. Imagine typing with a cursor that suddenly moves back then forward again.

Due to this limitation, it may be better to collapse the keyboard to a compact toolbar when an external keyboard is connected. You can always add a button that expands the keyboard again.


## 👑 Pro features

KeyboardKit has an **ExternalKeyboardContext** that can detect if an external keyboard is connected, including the Smart Keyboard Folio, Magic Keyboard, Bluetooth keyboards, etc.

To use this context, just set it up as an observed object:

```swift
struct CustomKeyboardView: View {

   @StateObject
   var context = ExternalKeyboardContext()

   var body: some View {
       VStack {
           Text("Is an external keyboard connected?")
           Text(stateDescription)
       }.environmentObject(context)
   }

   var stateDescription: String {
       context.isExternalKeyboardConnected.description
   }
}
```

In the code above, we also inject the context into the view hierarchy as an environment object.

> Warning: The context considers a Apple Smart Keyboard Folio to be connected, even when it's just snapped on to the device and not actively being used.



[Pro]: https://github.com/KeyboardKit/KeyboardKitPro
