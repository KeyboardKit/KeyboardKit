# Device Utilities

This article describes the KeyboardKit device utilities.

KeyboardKit has device-related features that can help customize your keyboard for various devices.

Although you should avoid designing for a specific device, orientation, or screen size, some features do need these considerations.



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

KeyboardKit has `CGSize` extensions to help detecting which kind of hardware you're on, e.g.:

```swift
CGSize.iPadProLargeScreenPortrait/Landscape
CGSize.iPadProSmallScreenPortrait/Landscape
CGSize.iPadProSmallScreenPortrait/Landscape
CGSize.iPadScreenPortrait/Landscape
CGSize.iPhoneProMaxScreenPortrait/Landscape
```

There's also an **.isScreenSize(_:)** function that compares rotation-agnostic screen sizes. 

```swift

let size = CGSize.iPadProLargeScreenPortrait
size.isScreenSize(.iPadProLargeScreenLandscape) // True
```

It's important to avoid designing for a specific screen size, since apps can run in split screen, a keyboard can be floating, etc. However, the screen size may provide you with information about the device.



[Pro]: https://github.com/KeyboardKit/KeyboardKitPro
