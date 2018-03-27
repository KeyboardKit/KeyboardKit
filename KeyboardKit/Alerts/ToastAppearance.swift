//
//  ToastAppearance.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2018-03-03.
//  Copyright © 2018 Daniel Saidi. All rights reserved.
//

/*
 
 This class provides every visual style you can modify for a
 standard keyboard alert.
 
 */

import UIKit

open class ToastAppearance {
    
    public init() {}
    
    public var backgroundColor: UIColor = .white
    public var cornerRadius: CGFloat = 10
    public var font: UIFont = .systemFont(ofSize: 10)
    public var horizontalPadding: CGFloat = 20
    public var textColor: UIColor = .black
    public var verticalOffset: CGFloat = 0
    public var verticalPadding: CGFloat = 10
}
