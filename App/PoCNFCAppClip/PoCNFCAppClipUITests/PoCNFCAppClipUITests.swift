import XCTest

final class PoCNFCAppClipUITests: XCTestCase {
    @MainActor
    func testScanSheetAndRental() {
        continueAfterFailure = false
        let app = XCUIApplication()
        app.launch()

        app.buttons["Escanear"].tap()
        XCTAssertTrue(app.staticTexts["Pronto para escanear"].waitForExistence(timeout: 5))
        app.buttons["Cancelar"].tap()

        app.buttons["book-1"].tap()
        XCTAssertTrue(app.navigationBars["Detalhes do livro"].waitForExistence(timeout: 5))
        app.buttons["Alugar livro"].tap()
        XCTAssertTrue(app.alerts["Livro alugado!"].waitForExistence(timeout: 5))
        app.alerts.buttons["OK"].tap()
        XCTAssertFalse(app.buttons["Alugado por você"].isEnabled)
    }
}
