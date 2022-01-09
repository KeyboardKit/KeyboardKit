//
//  LocalizedInputSetProvider.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2021-02-16.
//  Copyright © 2021 Daniel Saidi. All rights reserved.
//

import Foundation

/**
 This typealias represents an `InputSetProvider` that's also
 implementing the `LocalizedService` protocol.
 */
public typealias LocalizedInputSetProvider = InputSetProvider & LocalizedService
