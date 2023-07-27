//
//  InputSetProviderBased.swift
//  KeyboardKit
//  
//
//  Created by Daniel Saidi on 2022-12-29.
//  Copyright © 2022-2023 Daniel Saidi. All rights reserved.
//

import Foundation

@available(*, deprecated, message: "Use input sets directly instead.")
public protocol InputSetProviderBased {

    func register(inputSetProvider: InputSetProvider)
}
