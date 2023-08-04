import SwiftUI

/**
 [DEPRECATED]
 
 This enum defines various keyboard backgrounds.

 This type isn't properly deprecated since it is still being
 used internally, for backwards compatibility.
 */
public enum KeyboardBackgroundType: Codable, Equatable {

    case none
    case clear
    case color(Color)
    case image(Data)
    case verticalGradient([Color])
}

public extension KeyboardBackgroundType {

    @available(*, deprecated, message: "Use a KeyboardBackgroundStyle instead.")
    var view: some View {
        internalView
    }
}

extension KeyboardBackgroundType {

    @ViewBuilder
    var internalView: some View {
        switch self {
        case .clear, .none: Color.clear
        case .color(let color): color
        case .image(let data): image(from: data)
        case .verticalGradient(let colors): LinearGradient(colors: colors, startPoint: .top, endPoint: .bottom)
        }
    }
}

private extension KeyboardBackgroundType {

    func image(from data: Data) -> Image {
    #if canImport(UIKit)
        let image: UIImage = UIImage(data: data) ?? UIImage()
        return Image(uiImage: image)
    #elseif canImport(AppKit)
        let image: NSImage = NSImage(data: data) ?? NSImage()
        return Image(nsImage: image)
    #else
        return Image(systemImage: "exclamationmark.triangle")
    #endif
    }
}
