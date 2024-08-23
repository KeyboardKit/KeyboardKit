# Device Utilities

This article describes the KeyboardKit device utilities.

KeyboardKit has device-related features that can help customize your keyboard for various device types, orientations and screen sizes.

Although you should avoid targeting a specific device, orientation, or screen size, some keyboard features require these considerations.



## Device type

KeyboardKit has a platform-agnostic ``DeviceType`` enum that defines available device types. 

You can use ``DeviceType/current`` to get the current device type:

```swift
let isPad = DeviceType.current == .pad
```



## Interface orientation

KeyboardKit has a platform-agnostic ``InterfaceOrientation`` enum that defines various interface (screen) orientations. 

You can use ``InterfaceOrientation/current`` to get the current interface orientation:

```swift
let isPortrait = InterfaceOrientation.current.portrait
```



## Screen sizes

KeyboardKit has `CGSize` extensions for detecting which kind of hardware you're on, for instance to define and compare various device screen sizes.

You can use `isScreenSize(_:withTolerance:)` to check if a certain size matches a screen size in any orientation. It uses a low tolerance by default to support slight variations between model changes of the same device type.



[Pro]: https://github.com/KeyboardKit/KeyboardKitPro
