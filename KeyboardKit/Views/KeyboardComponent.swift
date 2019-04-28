//
//  KeyboardComponent.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2019-04-28.
//  Copyright © 2019 Daniel Saidi. All rights reserved.
//

import UIKit

public protocol KeyboardComponent: UIView {

    var heightConstraint: NSLayoutConstraint { get }
}
