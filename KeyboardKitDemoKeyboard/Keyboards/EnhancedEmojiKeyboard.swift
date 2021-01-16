import Foundation
import KeyboardKit

/**
 This demo keyboard mimics the native iOS emoji keyboard. It
 uses the `EmojiCategory` enum to get all available category
 items and their emojis and provide them to the keyboard.
 */
struct EnhancedEmojiKeyboard: DemoKeyboard {
    
    init(in viewController: KeyboardViewController) {
        let isLandscape = viewController.deviceOrientation.isLandscape
        let rowsPerPage = isLandscape ? 3 : 5
        let buttonsPerRow = isLandscape ? 10 : 8
        gridConfig = KeyboardButtonRowCollectionView.Configuration(
            rowHeight: 40,
            rowsPerPage: rowsPerPage,
            buttonsPerRow: buttonsPerRow
        )
        actions = Self.createActions(for: categories, config: gridConfig)
        actionCategories = Self.createActionCategories(for: categories)
        bottomActions = Self.createBottomActions(for: categories)
        categoryActions = Self.createCategoryActions(for: categories)
    }
    
    let actions: [KeyboardAction]
    let categoryActions: [(String, KeyboardActions)]
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
     Get the first category that appears at a certain page.
     */
    func getPageIndex(for category: EmojiCategory) -> Int? {
        guard let index = actionCategories.firstIndex(where: { $0.0 == category }) else { return nil }
        return index / gridConfig.pageSize
    }
}

private extension EnhancedEmojiKeyboard {
    
    static func createActions(for categories: [EmojiCategory], config: KeyboardButtonRowCollectionView.Configuration) -> [KeyboardAction] {
        categories
            .flatMap { $0.emojiActions }
            .rearrangedForCollectionView(withConfig: config)
    }
    
    static func createActionCategories(for categories: [EmojiCategory]) -> [(EmojiCategory, KeyboardAction)] {
        categories.flatMap { cat in
            cat.emojiActions.compactMap { action in
                (cat, action)
            }
        }
    }
    
    static func createBottomActions(for categories: [EmojiCategory]) -> KeyboardActionRow {
        var actions = categories.map { KeyboardAction.emojiCategory($0) }
        actions.insert(.keyboardType(.alphabetic(.lowercased)), at: 0)
        actions.append(.backspace)
        return actions
    }
    
    static func createCategoryActions(for categories: [EmojiCategory]) -> [(String, KeyboardActions)]{
        // Remove empty frequent
        categories.filter { $0.rawValue != "frequent"}.compactMap {
            ($0.title, $0.emojis.map{ KeyboardAction.emoji(String($0))})
        }
    }
}

private extension Array where Element == KeyboardAction {
    
    /**
     This function rearranges the actions from top to bottom,
     to be correctly rendered within the grid.
     
     The result will be:
     ```
     1   4   7
     2   5   8
     3   6   9
     ```
     */
    func rearrangedForCollectionView(withConfig config: KeyboardButtonRowCollectionView.Configuration) -> [KeyboardAction] {
        var result: [KeyboardAction] = []
        let pageSize = config.pageSize
        let evened = self.evened(for: pageSize)
        let groupCount = evened.count / pageSize
        for groupIndex in 0..<groupCount {
            var rows = KeyboardActionRows(repeating: [], count: config.rowsPerPage)
            let startIndex = pageSize * groupIndex
            let endIndex = startIndex + pageSize
            let actions = evened[startIndex..<endIndex]
            var currentRow = 0
            actions.forEach {
                let row = currentRow % config.rowsPerPage
                rows[row].append($0)
                currentRow += 1
            }
            result += rows.flatMap { $0 }
        }
        return result
    }
}

