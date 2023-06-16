//
//  ToggleToolbar.swift
//  KeyboardKitPro
//
//  Created by Daniel Saidi on 2021-11-09.
//  Copyright © 2021-2023 Daniel Saidi. All rights reserved.
//

import SwiftUI

/**
 This toolbar can be used to toggle between two toolbars.

 The toolbar has a configurable leading toggle, that toggles
 between the provided `toolbar` and `toggledToolbar` using a
 custom animation.
 */
public struct ToggleToolbar<Toggle: View, Toolbar: View, ToggledToolbar: View>: View {

    /**
     Create a toggle toolbar.

     - Parameters:
       - animation: The animation to use, by default `.slideUp`.
       - toolbar: The standard toolbar to display.
       - toggledToolbar: The toolbar to display when the toggle state is active.
       - toggleView: A custom view to use to toggle the toolbar's toggle state.
     */
    public init(
        animation: ToggleToolbarAnimation = .slideUp,
        toolbar: Toolbar,
        toggledToolbar: ToggledToolbar,
        toggleView: @escaping (_ isToggled: Bool) -> Toggle
    ) {
        self.animation = animation
        self.toolbar = toolbar
        self.toggledToolbar = toggledToolbar
        self.toggle = toggleView
    }

    private let animation: ToggleToolbarAnimation
    private let toggle: (Bool) -> Toggle
    private let toolbar: Toolbar
    private let toggledToolbar: ToggledToolbar

    @State
    private var isToggled = false

    public var body: some View {
        GeometryReader { geo in
            HStack {
                Button(action: toggleToolbar) {
                    toggle(isToggled)
                }
                ZStack {
                    toolbar
                        .toolbarOffset(for: geo, isToggled: isToggled, animation: animation)
                        .toolbarOpacity(for: geo, isToggled: isToggled, animation: animation)
                    toggledToolbar
                        .toggledToolbarOffset(for: geo, isToggled: isToggled, animation: animation)
                        .toggledToolbarOpacity(for: geo, isToggled: isToggled, animation: animation)
                }.clipped()
            }
        }
    }
}

/**
 This enum specifies the various ways the toggle toolbar can
 animate its wrapped toolbars.
 */
public enum ToggleToolbarAnimation: String, CaseIterable, Codable, Equatable, Identifiable {

    /// The toolbars fade in and out when toggled.
    case opacity

    /// The toolbar slides up and the toggled toolbar down.
    case flipUp

    /// The toolbar slides down and the toggled toolbar up.
    case flipDown

    /// The toolbars slides up when toggled.
    case slideUp

    /// The toolbars slides down when toggled.
    case slideDown

    /// The unique animation id.
    public var id: String { rawValue }
}

private extension ToggleToolbar {

    func toggleToolbar() {
        withAnimation {
            isToggled.toggle()
        }
    }
}

private extension View {

    @ViewBuilder
    func toolbarOffset(for geo: GeometryProxy, isToggled: Bool, animation: ToggleToolbarAnimation) -> some View {
        if animation == .slideUp || animation == .slideDown {
            self.offset(y: isToggled ? animation == .slideUp ? -geo.size.height : geo.size.height : 0)
        } else if animation == .flipUp || animation == .flipDown {
            self.offset(y: isToggled ? animation == .flipUp ? -geo.size.height : geo.size.height : 0)
        } else {
            self
        }
    }

    @ViewBuilder
    func toolbarOpacity(for geo: GeometryProxy, isToggled: Bool, animation: ToggleToolbarAnimation) -> some View {
        if animation == .opacity {
            self.opacity(isToggled ? 0 : 1)
        } else {
            self
        }
    }

    @ViewBuilder
    func toggledToolbarOffset(for geo: GeometryProxy, isToggled: Bool, animation: ToggleToolbarAnimation) -> some View {
        if animation == .slideUp || animation == .slideDown {
            self.offset(y: isToggled ? 0 : animation == .slideUp ? geo.size.height : -geo.size.height)
        } else if animation == .flipUp || animation == .flipDown {
            self.offset(y: isToggled ? 0 : animation == .flipDown ? geo.size.height : -geo.size.height)
        } else {
            self
        }
    }

    @ViewBuilder
    func toggledToolbarOpacity(for geo: GeometryProxy, isToggled: Bool, animation: ToggleToolbarAnimation) -> some View {
        if animation == .opacity {
            self.opacity(isToggled ? 1 : 0)
        } else {
            self
        }
    }
}

struct ToggleToolbar_Previews: PreviewProvider {

    static var previews: some View {
        ToggleToolbar(
            animation: .flipDown,
            toolbar: Color.red,
            toggledToolbar: Color.yellow,
            toggleView: { isToggled in
                Image(systemName: "plus")
                    .rotationEffect(.degrees(isToggled ? 45 : 0))
            }
        ).frame(height: 50)
    }
}
