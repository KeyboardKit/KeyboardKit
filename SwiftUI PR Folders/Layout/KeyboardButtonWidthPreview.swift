import SwiftUI

/**
 This struct is just used to experiment with varios keyboard
 layouts, button cominations, widths etc.
 
 You have to use `live preview` for this preview to properly
 apply sizes.
 */
struct KeyboardButtonWidthPreview: View {
    
    @State var referenceSize: CGSize = .zero
    @State var totalSize: CGSize = .zero
    
    var totalWidth: CGFloat { totalSize.width }
    
    func systemButton() -> some View {
        Color.gray.opacity(0.7).cornerRadius(6).padding(3)
    }
    
    func button() -> some View {
        Color.white.cornerRadius(6).padding(3)
    }
    
    func spacer() -> some View {
        Color.clear.padding(1).width(.available)
    }
    
    func bars(count: Int) -> some View {
        HStack(spacing: 0) {
            ForEach(0...(count/2-1), id: \.self) { _ in
                Color.white
                Color.black
            }
        }
    }
    
    func repeatingView<ViewType: View>(count: Int, view: @escaping () -> ViewType) -> some View {
        HStack(spacing: 0) {
            ForEach(0...count-1, id: \.self) { _ in
                view()
            }
        }
    }
    
    var body: some View {
        VStack(spacing: 0) {
            bars(count: 100)
            VStack(spacing: 0) {
                repeatingView(count: 10, view: { button().width(.reference(.available), referenceSize: $referenceSize) })
                repeatingView(count: 9, view: { button().width(.fromReference, referenceSize: $referenceSize) })
                HStack(spacing: 0) {
                    systemButton().width(.percentage(0.125), totalWidth: totalWidth)
                    spacer()
                    repeatingView(count: 7, view: { button().width(.fromReference, referenceSize: $referenceSize) })
                    spacer()
                    systemButton().width(.percentage(0.125), totalWidth: totalWidth)
                }
                HStack(spacing: 0) {
                    systemButton().width(.percentage(0.125), totalWidth: totalWidth)
                    systemButton().width(.percentage(0.125), totalWidth: totalWidth)
                    button().width(.fromReference, referenceSize: $referenceSize)
                    button()
                    systemButton().width(.percentage( 0.25), totalWidth: totalWidth)
                }
            }.frame(height: 200)
            bars(count: 100)
        }
        .background(Color.gray.opacity(0.4))
        .bindSize(to: $totalSize)
    }
}

struct KeyboardButtonWidthPreview_Previews: PreviewProvider {
    
    static var previews: some View {
        KeyboardButtonWidthPreview()
    }
}
