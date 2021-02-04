//
//  String+Chars.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2021-02-03.
//  Copyright © 2021 Daniel Saidi. All rights reserved.
//

import Foundation

extension String {
    
    var chars: [String] { self.map { String($0) } }
}
