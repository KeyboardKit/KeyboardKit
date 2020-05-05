import Foundation
import KeyboardKit

/**
 This demo keyboard mimics the native iOS emoji keyboard. It
 uses the `EmojiCategory` enum to get all available category
 items and their emojis and provide them to the keyboard.
 
 
 */
struct EmojiKeyboard: DemoKeyboard {
    
    init(in viewController: KeyboardViewController) {
        let isLandscape = viewController.deviceOrientation.isLandscape
        let rowsPerPage = isLandscape ? 4 : 5
        let buttonsPerRow = isLandscape ? 10 : 8
        gridConfig = KeyboardButtonRowCollectionView.Configuration(
            rowHeight: 40,
            rowsPerPage: rowsPerPage,
            buttonsPerRow: buttonsPerRow
        )
        actions = Self.createActions(for: categories, config: gridConfig)
        actionCategories = Self.createActionCategories(for: categories)
        bottomActions = Self.createBottomActions(for: categories)
    }
    
    let actions: [KeyboardAction]
    let actionCategories: [(EmojiCategory, KeyboardAction)]
    let bottomActions: KeyboardActionRow
    let categories = EmojiCategory.all
    let gridConfig: KeyboardButtonRowCollectionView.Configuration
    
    private var emoji: [KeyboardAction] = []
    
    /**
     Get the first category that appears at a certain page.
     */
    func getCategory(at pageIndex: Int) -> EmojiCategory? {
        let index = pageIndex * gridConfig.pageSize
        guard actionCategories.count > index else { return nil }
        return actionCategories[index].0
    }
    
    
    
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
}

private extension EmojiKeyboard {
    
    static func createActions(for categories: [EmojiCategory], config: KeyboardButtonRowCollectionView.Configuration) -> [KeyboardAction] {
        let actions = categories.flatMap { $0.emojiActions }
        return actions
    }
    
    static func createActionCategories(for categories: [EmojiCategory]) -> [(EmojiCategory, KeyboardAction)] {
        categories.flatMap { cat in
            cat.emojiActions.compactMap { action in
                (cat, action)
            }
        }
    }
    
    static func createBottomActions(for categories: [EmojiCategory]) -> KeyboardActionRow {
        var actions = categories.map { KeyboardAction.emojiCategory($0, startPage: 0, endPage: 0) }
        actions.insert(.keyboardType(.alphabetic(uppercased: false)), at: 0)
        actions.append(.backspace)
        return actions
    }
}

private extension Collection where Element == KeyboardAction {
    
    func rearrangedForCollectionView() -> KeyboardAction {
        fatalError()
    }
}

