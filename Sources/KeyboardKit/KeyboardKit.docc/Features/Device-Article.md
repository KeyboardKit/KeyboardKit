# Device Utilities

This article describes the KeyboardKit device utilities.

@Metadata {

    @PageImage(
        purpose: card,
        source: "Page",
        alt: "Page icon"
    )
}

KeyboardKit has device-related features that can help customize your keyboard for various device types, orientations and screen sizes.

Although you should avoid targeting a specific device, orientation, or screen size, some keyboard features require these considerations.



## Device type

KeyboardKit has a platform-agnostic ``DeviceType`` enum that defines available, supported device types. 

You can use ``DeviceType/current`` to get the current device type, then use properties like ``DeviceType/isPhone`` to determine what kind of device it is.

```swift
let device = DeviceType.current
let isPhone = device.isPhone
let isPad = device.isPad
```



## Interface orientation

KeyboardKit has a platform-agnostic ``InterfaceOrientation`` enum that defines various interface (screen) orientations. 

You can use ``InterfaceOrientation/current`` to get the current interface orientation, then use properties like ``InterfaceOrientation/isPortrait`` to determine its orientation type:

```swift
let orientation = InterfaceOrientation.current
let isPortrait = orientation.isPortrait
let isLandscape = orientation.isLandscape
```



## Screen sizes

KeyboardKit has `CGSize` extensions for detecting which hardware you're on, for instance to define and compare various screen sizes.

You can use `isScreenSize(_:withTolerance:)` to check if a certain size matches a screen size in any orientation. It uses a low tolerance by default to support slight variations between model changes of the same device type.

> Warning: Be careful with using screen size as the foundation for certain features. You never know if your software suddenly runs in another way that makes the screen size irrelevant, e.g. in iPad split screen or floating keyboard mode. 



[Pro]: https://github.com/KeyboardKit/KeyboardKitPro
