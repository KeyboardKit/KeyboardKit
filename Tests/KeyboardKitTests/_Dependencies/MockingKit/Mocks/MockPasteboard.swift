//
//  MockPasteboard.swift
//  MockingKit
//
//  Created by Daniel Saidi on 2019-05-28.
//  Copyright © 2021-2025 Daniel Saidi. All rights reserved.
//

#if os(iOS)
import UIKit

/// This class can be used to mock `UIPasteboard`.
///
/// This mock only mocks `setData(_:forPasteboardType:)` for
/// now, but you can subclass it and mock more functionality.
open class MockPasteboard: UIPasteboard, Mockable, @unchecked Sendable {
    
    public lazy var setDataRef = MockReference(setData)

    public let mock = Mock()
    
    open override func setData(_ data: Data, forPasteboardType pasteboardType: String) {
        call(setDataRef, args: (data, pasteboardType))
    }
}
#elseif os(macOS)
import AppKit

/**
 This class can be used to mock `NSPasteboard`.

 This mock only mocks `setValue(_:forKey:)` for now, but you
 can subclass this class and mock more functionality.
 */
public class MockPasteboard: NSPasteboard, Mockable {

    public lazy var setValueForKeyRef = MockReference(setValueForKey)

    public let mock = Mock()

    public override func setValue(_ value: Any?, forKey key: String) {
        setValueForKey(value, key: key)
    }

    /// This way to work around functions with the same name,
    /// especially when there are static and class functions
    /// with the same name, can also be used. Just add a new,
    /// private function and have it call the reference. The
    /// real function (as above) can then call this function.
    func setValueForKey(_ value: Any?, key: String) {
        call(setValueForKeyRef, args: (value, key))
    }
}
#else
import Foundation

/**
 This class can be used to mock a system pasteboard.

 This mock doesn't do anything, since this platform does not
 have a pasteboard. It's only here for documentation harmony.
 */
open class MockPasteboard: Mock {}
#endif
