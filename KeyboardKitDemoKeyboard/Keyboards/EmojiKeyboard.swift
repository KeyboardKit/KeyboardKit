import Foundation
import KeyboardKit

/**
 This demo keyboard mimics the native iOS emoji keyboard. It
 uses the `EmojiCategory` enum to get all available category
 items and their emojis and provide them to the keyboard.
 
 
 */
struct EmojiKeyboard: DemoKeyboard {
    
    init(in viewController: KeyboardViewController) {}
    
    private let categories = EmojiCategory.all
    private var emoji: [KeyboardAction] = []
    
    /**
     This function re-arranges sorts the list of emojis from
     top to bottom, to be correctly rendered within the grid.
     
     ```
     1   4   7
     2   5   8
     3   6   9
     ```
     */
    public mutating func orderEmojis(rowsPerPage: Int, pageSize: Int) -> [KeyboardAction] {
        var orderEmoji: [KeyboardAction] = []
        emoji = emoji.evened(for: pageSize/rowsPerPage)
        var groups = emoji.count / pageSize
        groups += emoji.count % pageSize == 0 ? 0 : 1
        for indexGroup in 0..<groups {
            let start = pageSize * indexGroup
            var end = start + pageSize
            end = end > emoji.count ? emoji.count : end
            let emojisGroup = emoji[start..<end]
            var tempArray = [KeyboardAction](repeating: .none, count: pageSize)
            var currentColumn = 0
            var currentRow = 0
            for indexEmoji in 0..<emojisGroup.count {
                if currentRow >= rowsPerPage {
                    currentColumn += 1
                    currentRow = 0
                }
                let row = currentRow == 0 ? "" : currentRow.description
                let stringValue = row + currentColumn.description
                tempArray[Int(stringValue)!] = emojisGroup[indexEmoji + start]
                currentRow += 1

            }
            orderEmoji += tempArray
        }
        return orderEmoji
    }
    
    func getNameCategoryEmoji(currentPage: Int, bottomActions: KeyboardActionRow) -> String {
        for bottomAction in bottomActions {
            if case let KeyboardAction.emojiCategory(category, startPage, endPage) = bottomAction {
                if currentPage >= startPage && currentPage < endPage {
                    return category.title
                }
            }
        }
        return ""
    }
    
    public mutating func bottomActionsEmojiCategories(pageSize: Int) -> KeyboardActionRow {
        var bottomActions: KeyboardActionRow = []
        bottomActions.append(.keyboardType(.alphabetic(uppercased: false)))
        for (index, category) in categories.enumerated() {
            let startPage = emoji.count / pageSize
            emoji += category.emojiActions
            var endPage = (emoji.count / pageSize)
            endPage += index == (categories.count - 1) ? 1: 0
            bottomActions.append(.emojiCategory(category, startPage: startPage, endPage: endPage))
        }
        bottomActions.append(.backspace)
        return bottomActions
    }
}
