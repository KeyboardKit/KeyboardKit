//
//  LocalizedInputSetProvider.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2021-02-16.
//  Copyright © 2021-2023 Daniel Saidi. All rights reserved.
//

import Foundation

/**
 This typealias represents an ``InputSetProvider`` that also
 implements the ``LocalizedService`` protocol.
 */
@available(*, deprecated, message: "Use input sets directly instead.")
public typealias LocalizedInputSetProvider = InputSetProvider & LocalizedService