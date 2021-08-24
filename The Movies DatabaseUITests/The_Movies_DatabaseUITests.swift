//
//  The_Movies_DatabaseUITests.swift
//  The Movies DatabaseUITests
//
//  Created by Adi Mizrahi on 16/07/2021.
//

import XCTest

class The_Movies_DatabaseUITests: XCTestCase {

    func testMainScreen() {
        let app = XCUIApplication()
        app.launch()
        
        XCTAssertTrue(app.buttons["Movies"].exists)
        XCTAssertTrue(app.buttons["Watchlists"].exists)
    }

    func testSearchScreen() throws {
        let app = XCUIApplication()
        app.launch()
    
        XCUIApplication().children(matching: .window).element(boundBy: 0).children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element(boundBy: 0).children(matching: .other).element.tap()
        
        let noResultsStaticText = XCUIApplication().staticTexts["No results "]
        XCTAssertTrue(noResultsStaticText.exists)
    }
    
    func testWatchlist() throws {
        let app = XCUIApplication()
        app.launch()
        app.buttons["Watchlists"].tap()
        let watchlistsStaticText = XCUIApplication().scrollViews.otherElements.staticTexts["Watchlists"]
        XCTAssertTrue(watchlistsStaticText.exists)
        
    }
    
    func testAddWatchlist() throws {
        let app = XCUIApplication()
        app.launch()
        
        app.buttons["Watchlists"].tap()
        app.scrollViews.otherElements/*@START_MENU_TOKEN@*/.images["plus"]/*[[".images[\"add\"]",".images[\"plus\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        
        let elementsQuery = app.alerts["New Watchlist"].scrollViews.otherElements
        let okButton = elementsQuery.buttons["OK"]
        
        let watchlistNameTextField = elementsQuery.collectionViews/*@START_MENU_TOKEN@*/.textFields["Watchlist name"]/*[[".cells.textFields[\"Watchlist name\"]",".textFields[\"Watchlist name\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        watchlistNameTextField.tap()
        watchlistNameTextField.typeText("hello")
        okButton.tap()
                
        XCTAssertTrue(app.staticTexts["hello"].exists)
    }
    
}
