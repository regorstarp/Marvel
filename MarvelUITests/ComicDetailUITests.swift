//
//  ComicDetailUITests.swift
//  ComicDetailUITests
//
//  Created by Roger Prats Llivina on 11/09/2020.
//  Copyright © 2020 roger. All rights reserved.
//

import XCTest

class ComicDetailUITests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    /// Tests the navigation to the comic detail screen and it's dismissal
    func testComicDetail() throws {
        // UI tests must launch the application that they test.
        let app = XCUIApplication()
        app.launch()
        
        // Make sure we're displaying the initial ViewController
        XCTAssert(app.navigationBars["Comics"].exists)
        XCTAssert(app.otherElements["ComicsView"].exists)
        
        //Tap the first cell in the collectionView
        let comicsCollectionView = app.collectionViews["ComicsCollectionView"]
        XCTAssert(comicsCollectionView.exists)
        let cell = comicsCollectionView
            .children(matching: .cell)
            .matching(identifier: "ComicCollectionViewCell")
            .element(boundBy: 0)
            .children(matching: .other)
            .element
        if cell.waitForExistence(timeout: 3) {
            cell.tap()
        } else {
            XCTFail("ComicCollectionViewCell doesn't exist")
        }
        
        // Make sure we have presented the detail screen
        XCTAssert(app.otherElements["ComicDetailView"].waitForExistence(timeout: 1))
        
        // Tap the "Close" button
        let closeButton = app.buttons["ComicDetailCloseButton"]
        XCTAssert(closeButton.exists)
        closeButton.tap()
        
        XCTAssert(app.otherElements["ComicsView"].waitForExistence(timeout: 1))
        XCTAssertFalse(app.otherElements["ComicDetailView"].waitForExistence(timeout: 1))
    }
}
