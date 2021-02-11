//
//  DemoAppearance.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2021-02-11.
//  Copyright © 2021 Daniel Saidi. All rights reserved.
//

import Foundation
#if os(iOS)
import UIKit
#endif

final class DemoAppearance {
    
    private init() {}
    
    static func apply() {
        #if os(iOS)
        if #available(iOS 13.0, *) {
            let navbar = UINavigationBar.appearance()
            let navbarAppearance = UINavigationBarAppearance()
            navbarAppearance.configureWithOpaqueBackground()
            //navbarAppearance.backgroundColor = .accent
            navbarAppearance.titleTextAttributes = titleAttributes
            navbarAppearance.largeTitleTextAttributes = largeTitleAttributes
            //navbar.tintColor = UIColor.darkGray
            navbar.standardAppearance = navbarAppearance
            navbar.scrollEdgeAppearance = navbarAppearance
        }
        #endif
    }
}

#if os(iOS)
private extension DemoAppearance {
    
    static func font(sized size: CGFloat) -> UIFont {
        FontFamily.SourceSansPro.bold.font(size: size) ?? .systemFont(ofSize: size)
    }
    
    static var titleAttributes: [NSAttributedString.Key: Any] {
        [.font: font(sized: 20), .foregroundColor: UIColor.label, .shadow: shadow]
    }

    static var largeTitleAttributes: [NSAttributedString.Key: Any] {
        [.font: font(sized: 30), .foregroundColor: UIColor.label, .shadow: shadow]
    }

    static var shadow: NSShadow {
        let shadow = NSShadow()
        shadow.shadowBlurRadius = 5
        shadow.shadowColor = UIColor.clear
        return shadow
    }
}
#endif
