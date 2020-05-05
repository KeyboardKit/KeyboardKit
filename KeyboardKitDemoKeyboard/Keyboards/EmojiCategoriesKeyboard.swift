
import KeyboardKit

struct EmojiCategoriesKeyboard: DemoKeyboard {
    
    init(in viewController: KeyboardViewController) {
    }
    
    var actions: [Emojis.EmojiTypes] = Emojis().getEmoji()
    private var emoji:[KeyboardAction] = []
    
    public func orderEmojis(rowsPerPage: Int, pageSize: Int) -> [KeyboardAction] {
        
        /** This function sorts the array of emojis from top to bottom
           1   4   7
           2   5   8
           3   6   9
        */
        var orderEmoji:[KeyboardAction] = []
        var groups = self.emoji.count / pageSize
        groups += self.emoji.count % pageSize == 0 ? 0 : 1
        for indexGroup in 0..<groups {
           let start = pageSize * indexGroup
           var end = start + pageSize
            end = end > self.emoji.count ? self.emoji.count : end
           let emojisGroup = self.emoji[start..<end]
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
    func getNameCategoryEmoji(currentPage: Int,bottomActions:KeyboardActionRow) -> String{
        
        var label = ""
        for  pagination in bottomActions {
            if case let KeyboardAction.switchEmoji(category, startPage, endPage, _) = pagination {
                if currentPage >= startPage && currentPage < endPage{
                    label = category
                    break
                }
            }
        }
        return label
        
    }
    public mutating func bottomActionsEmojiCategories(pageSize: Int) -> KeyboardActionRow  {
        
        var bottomActions:KeyboardActionRow = []
        bottomActions.append(.switchToKeyboard(.alphabetic(uppercased: false)))
        for  (index,typeCategory) in self.actions.enumerated() {
            
            let startPage = self.emoji.count / pageSize
            self.emoji += typeCategory.actions
            var endPage = (self.emoji.count / pageSize)
            endPage += index == (self.actions.count - 1) ? 1: 0
            bottomActions.append(.switchEmoji(category: typeCategory.category, startPage: startPage, endPage: endPage, type: typeCategory.type))
        }
        bottomActions.append(.backspace)
        
        return bottomActions
        
    }
}
