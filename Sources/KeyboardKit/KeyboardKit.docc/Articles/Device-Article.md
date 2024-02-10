# Device Utilities

This article describes various KeyboardKit device utilities.

KeyboardKit has various device-related features that aim to help you customize your keyboard for various devices.

Although you should avoid designing for a specific device, orientation, or screen size in general, some features need these kinds of considerations.



## Device type

KeyboardKit has a platform-agnostic ``DeviceType`` enum that defines available device types. 

You can use ``DeviceType/current`` to get the current device type.

```swift
let type = DeviceType.current
let isPad = type == .pad
```



## Interface orientation

KeyboardKit has a platform-agnostic ``InterfaceOrientation`` enum that defines various interface (screen) orientations. 

You can use ``InterfaceOrientation/current`` to get the current interface orientation.

```swift
let orientation = InterfaceOrientation.current 
let isPortrait = orientation.portrait
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

It's extra important to avoid designing for a specific screen size, if possible, since apps can run in split screen, the keyboard can be floating, etc.



[Pro]: https://github.com/KeyboardKit/KeyboardKitPro
