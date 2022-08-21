import KeyboardKit
import XCTest

final class AutocompleteProviderTests: XCTestCase {

    let provider = MockAutocompleteProvider()

    func test_caseAdjustingSuggestionAppliesUppercasingIfTextIsMultiCharacterUppercased() {
        let suggestion = "soccer tournament"
        let text = "SOC"
        let result = provider.caseAdjust(
            suggestion: suggestion,
            for: text)

        XCTAssertEqual(result, "SOCCER TOURNAMENT")
    }

    func test_caseAdjustingSuggestionIgnoresUppercasingIfTextIsSingleCharacterUppercased() {
        let suggestion = "soccer tournament"
        let text = "S"
        let result = provider.caseAdjust(
            suggestion: suggestion,
            for: text)

        XCTAssertEqual(result, "Soccer Tournament")
    }

    func test_caseAdjustingSuggestionAppliesCapitalization() {
        let suggestion = "soccer tournament"
        let text = "Soc"
        let result = provider.caseAdjust(
            suggestion: suggestion,
            for: text)

        XCTAssertEqual(result, "Soccer Tournament")
    }

    func test_caseAdjustingSuggestionReturnsOriginalIfNoCaseMatches() {
        let suggestion = "soccer tournament"
        let text = "soc"
        let result = provider.caseAdjust(
            suggestion: suggestion,
            for: text)

        XCTAssertEqual(result, "soccer tournament")
    }
}
