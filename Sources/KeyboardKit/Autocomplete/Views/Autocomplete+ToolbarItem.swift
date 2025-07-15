//
//  Autocomplete+ToolbarItem.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2021-03-18.
//  Copyright © 2021-2025 Daniel Saidi. All rights reserved.
//

import SwiftUI

public extension Autocomplete {
    
    /// This view mimics a native autocomplete toolbar item.
    ///
    /// You can style this component with the style modifier
    /// ``autocompleteToolbarItemStyle(_:)``.
    struct ToolbarItem: View {
        
        /// Create an autocomplete toolbar item.
        ///
        /// - Parameters:
        ///   - suggestion: The suggestion to display.
        public init(
            suggestion: Autocomplete.Suggestion
        ) {
            self.suggestion = suggestion
        }

        private typealias Style = Autocomplete.ToolbarItemStyle

        private let suggestion: Suggestion

        @Environment(\.autocompleteToolbarItemStyle)
        private var style

        @Environment(\.truncationMode)
        private var truncationMode

        public var body: some View {
            contentPlaceholder
                .opacity(0)
                .overlay(contentStack) // Limit multiline height
                .padding(.horizontal, style.horizontalPadding)
                .padding(.vertical, style.verticalPadding)
                .background(style.backgroundColor)
                .background(Color.clearInteractable)
                .cornerRadius(style.backgroundCornerRadius)

        }
    }

    /// This style can be used to modify the visual style of
    /// the ``Autocomplete/ToolbarItem`` component.
    ///
    /// You can apply this view style with the view modifier
    /// ``SwiftUICore/View/autocompleteToolbarItemStyle(_:)``.
    ///
    /// You can use the ``standard`` style or your own style.
    struct ToolbarItemStyle: KeyboardModel {

        /// Create a custom autocomplete toolbar item style.
        ///
        /// - Parameters:
        ///   - titleColor: The title color to use, by default `.primary`.
        ///   - titleFont: The title font to use, by default `.body`.
        ///   - subtitleColor: The subtitle color to use, by default `.primary`.
        ///   - subtitleFont: The subtitle font to use, by default `.footnote`.
        ///   - horizontalPadding: The horizontal padding to apply, by default `4`.
        ///   - verticalPadding: The vertical padding to apply, by default `10`.
        ///   - backgroundColor: The background color to use, by default `.clear`.
        ///   - backgroundCornerRadius: The background color to use, by default `6`.
        public init(
            titleColor: Color = .primary,
            titleFont: KeyboardFont = .body,
            subtitleColor: Color = .primary,
            subtitleFont: KeyboardFont = .footnote,
            horizontalPadding: Double = 2,
            verticalPadding: Double = 10,
            backgroundColor: Color = .clear,
            backgroundCornerRadius: CGFloat = 4
        ) {
            self.titleFont = titleFont
            self.titleColor = titleColor
            self.subtitleFont = subtitleFont
            self.subtitleColor = subtitleColor
            self.horizontalPadding = horizontalPadding
            self.verticalPadding = verticalPadding
            self.backgroundColor = backgroundColor
            self.backgroundCornerRadius = backgroundCornerRadius
        }

        /// The title font to use.
        public var titleFont: KeyboardFont

        /// The title color to use.
        public var titleColor: Color

        /// The subtitle font to use.
        public var subtitleFont: KeyboardFont

        /// The subtitle color to use.
        public var subtitleColor: Color

        /// The horizontal padding to apply.
        public var horizontalPadding: Double

        /// The vertical padding to apply.
        public var verticalPadding: Double

        // The background color to use.
        public var backgroundColor: Color

        // The background color to use.
        public var backgroundCornerRadius: CGFloat
    }
}

private extension Autocomplete.ToolbarItem {

    var contentPlaceholder: some View {
        Text("X")
            .font(style.titleFont.font)
            .frame(maxWidth: .infinity)
    }

    var contentStack: some View {
        VStack(alignment: .center, spacing: 0) {
            titleText
            subtitle
        }
    }

    var title: some View {
        Text(suggestion.title)
            .lineLimit(1)
            .font(style.titleFont.font)
            .foregroundColor(style.titleColor)
    }

    @ViewBuilder
    var titleText: some View {
        if #available(iOS 16.0, macOS 13.0, tvOS 16.0, watchOS 9.0, *) {
            ViewThatFits {
                title
                ScrollView(.horizontal) {
                    title.padding(.horizontal, 5)
                }
                .scrollIndicators(.hidden)
                .mask(
                    LinearGradient(
                        gradient: Gradient(stops: [
                            .init(color: .clear, location: 0),
                            .init(color: .black, location: 0.05),
                            .init(color: .black, location: 0.95),
                            .init(color: .clear, location: 1.0)
                        ]),
                        startPoint: .leading,
                        endPoint: .trailing
                    )
                )
            }
        } else {
            title
        }
    }
    
    @ViewBuilder
    var subtitle: some View {
        if let subtitle = suggestion.subtitle {
            Text(subtitle)
                .lineLimit(1)
                .font(style.subtitleFont.font)
                .foregroundColor(style.subtitleColor)
        }
    }
}

public extension Autocomplete.ToolbarItemStyle {

    /// The standard autocomplete toolbar item style.
    static var standard: Self { .init() }

    /// The standard autocomplete toolbar autocorrect style.
    static var standardAutocorrect: Self {
        .init(backgroundColor: .white.opacity(0.5))
    }
}

public extension View {

    /// Apply a ``Autocomplete/ToolbarItemStyle``.
    func autocompleteToolbarItemStyle(
        _ style: Autocomplete.ToolbarItemStyle
    ) -> some View {
        self.environment(\.autocompleteToolbarItemStyle, style)
    }
}

public extension EnvironmentValues {

    /// Apply a ``Autocomplete/ToolbarItemStyle``.
    @Entry var autocompleteToolbarItemStyle = Autocomplete
        .ToolbarItemStyle.standard
}


#Preview {

    struct Preview: View {

        let style: Autocomplete.ToolbarItemStyle

        let suggestions: [Autocomplete.Suggestion] = [
            .init(text: "Foo"),
            .init(text: "VeryLongTextNumberTwo", type: .autocorrect),
            .init(text: "VeryLongTextNumberThree", subtitle: "Subtitle")]

        var body: some View {
            HStack {
                ForEach(suggestions, id: \.text) {
                    Autocomplete.ToolbarItem(suggestion: $0)
                        .autocompleteToolbarItemStyle($0.isAutocorrect ? .standardAutocorrect : style)
                }
            }
        }
    }

    return VStack {
        Preview(style: .standard)
            .autocompleteToolbarItemStyle(.standard)
        Preview(style: .init(
            titleColor: .yellow,
            titleFont: .init(.body, .bold),
            subtitleColor: .yellow.opacity(0.9),
            backgroundColor: .blue,
            backgroundCornerRadius: 10
        ))
    }
    .padding(5)
    .background(Color.keyboardBackground)
    .truncationMode(.middle)
}
