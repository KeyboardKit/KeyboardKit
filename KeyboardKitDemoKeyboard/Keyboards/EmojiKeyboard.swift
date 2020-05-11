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
        let rowsPerPage = isLandscape ? 3 : 5
        let buttonsPerRow = isLandscape ? 10 : 8
        gridConfig = KeyboardButtonRowCollectionView.Configuration(
            rowHeight: 40,
            rowsPerPage: rowsPerPage,
            buttonsPerRow: buttonsPerRow
        )
        actions = Self.createActions(for: categories, config: gridConfig)
        actionCategories = Self.createActionCategories(for: categories, config: gridConfig)
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
     Get the first category that appears at a certain page.
     */
    func getPageIndex(for category: EmojiCategory) -> Int? {
        guard let index = actionCategories.firstIndex(where: { $0.0 == category }) else { return nil }
        return index / gridConfig.pageSize
    }
    func setFREmoji(emoji: String) {
      let frequents: EmojiCategory = .frequents
      var emojis = frequents.emojis
      guard !emojis.contains(emoji) else {return}
      emojis.insert(emoji, at: 0)
      emojis.removeLast()
      UserDefaults.standard.set(emojis, forKey: EmojiCategory.keyFR)
    }
}

private extension EmojiKeyboard {
    
    static func createActions(for categories: [EmojiCategory], config: KeyboardButtonRowCollectionView.Configuration) -> [KeyboardAction] {
        var emoji:[KeyboardAction] = []
        for cat in categories {
          for action in cat.emojiActions {
              emoji.append(action)
          }
          /**
          this function complete the remaining emojis on one page with action none
          this is only for the frequent emoji category
          The result will be for a 4 * 3 matrix:
          ```
          1   4   7   *
          2   5   8   *
          3   6   9   *
          ```
           */
          if cat == .frequents{
              for _ in 1 ... (config.rowsPerPage * config.buttonsPerRow) - emoji.count{
                  emoji.append(.none)
              }
          }
        }
       return emoji.rearrangedForCollectionView(withConfig: config)
    }
    
    static func createActionCategories(for categories: [EmojiCategory], config: KeyboardButtonRowCollectionView.Configuration) -> [(EmojiCategory, KeyboardAction)] {
        var actions:[(EmojiCategory, KeyboardAction)] = []
        for cat in categories {
            for action in cat.emojiActions {
                actions.append((cat, action))
            }
            /**
            this function complete the remaining emojis on one page with action none
            this is only for the frequent emoji category
            The result will be for a 4 * 3 matrix:
            ```
            1   4   7   *
            2   5   8   *
            3   6   9   *
            ```
             */
            if cat == .frequents{
                for _ in 1 ... (config.rowsPerPage * config.buttonsPerRow) - actions.count {
                    actions.append((cat, .none))
                }
            }
            
        }
        return actions
    }
    static func createBottomActions(for categories: [EmojiCategory]) -> KeyboardActionRow {
        var actions = categories.map { KeyboardAction.emojiCategory($0) }
        actions.insert(.keyboardType(.alphabetic(.lowercased)), at: 0)
        actions.append(.backspace)
        return actions
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

