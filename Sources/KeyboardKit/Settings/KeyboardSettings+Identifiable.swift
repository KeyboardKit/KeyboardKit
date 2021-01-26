//
//  KeyboardSetting.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2020-06-10.
//  Copyright © 2020 Daniel Saidi. All rights reserved.
//

import Foundation

public extension KeyboardSetting {
    
    func key<Context: Identifiable>(for id: Context) -> String { "\(key).\(id.id)" }
}
