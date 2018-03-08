//
//  SwiftRadioUITests.swift
//  SwiftRadioUITests
//
//  Created by Jonah Stiennon on 12/3/15.
//  Copyright © 2015 matthewfecher.com. All rights reserved.
//

import XCTest

class SwiftRadioUITests: XCTestCase {
    
    let app = XCUIApplication()
    let stations = XCUIApplication().cells
    let hamburgerMenu = XCUIApplication().navigationBars["Swift Radio"].buttons["icon hamburger"]
    let pauseButton = XCUIApplication().buttons["btn pause"]
    let playButton = XCUIApplication().buttons["btn play"]
    let volume = XCUIApplication().sliders.element(boundBy: 0)
    
    let labelLogin = XCUIApplication().textFields["Login"]
    let lablePassword = XCUIApplication().textFields["Password"]
    let btnConnextion = XCUIApplication().buttons["Connection"]
    
    override func setUp() {
        super.setUp()
        
        continueAfterFailure = false
        XCUIApplication().launch()
        
        self.expectation(
            for: NSPredicate(format: "self.count > 0"),
            evaluatedWith: stations,
            handler: nil)
        
        labelLogin.tap()
        labelLogin.typeText("fabrice")
        lablePassword.tap()
        lablePassword.typeText("fabrice")
        btnConnextion.tap()
        
        self.waitForExpectations(timeout: 10.0, handler: nil)
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func assertStationsPresent() {
        let numStations:UInt = 5
        XCTAssertEqual(stations.count, Int(numStations))
        
        let texts = stations.staticTexts.count
        XCTAssertEqual(texts, Int(numStations * 2))
    }
    
    func assertHamburgerContent() {
        XCTAssertTrue(app.staticTexts["Matt Fecher & Fethi El Hassasna"].exists)
    }
    
    func assertAboutContent() {
        XCTAssertTrue(app.buttons["email me"].exists)
        XCTAssertTrue(app.buttons["matthewfecher.com"].exists)
    }
    
    func assertPaused() {
        XCTAssertTrue(app.staticTexts["Station Paused..."].exists);
    }
    
    func assertPlaying() {
        XCTAssertFalse(app.staticTexts["Station Paused..."].exists);
    }
    
    func assertStationInfo() {
        let textView = app.textViews.element(boundBy: 0)
        if let value = textView.value {
            XCTAssertGreaterThan((value as AnyObject).length, 10)
        } else {
            XCTAssertTrue(false)
        }
    }
    
    func waitForStationToLoad() {
        self.expectation(
            for: NSPredicate(format: "exists == 0"),
            evaluatedWith: app.staticTexts["Loading Station..."],
            handler: nil)
        self.waitForExpectations(timeout: 25.0, handler: nil)

    }
    
    func testMainStationsView() {
        assertStationsPresent()
        
        hamburgerMenu.tap()
        assertHamburgerContent()
        app.buttons["About"].tap()
        assertAboutContent()
        app.buttons["Okay"].tap()
        app.buttons["btn close"].tap()
        assertStationsPresent()
        
        let firstStation = stations.element(boundBy: 0)
        let stationName:String = firstStation.children(matching: .staticText).element(boundBy: 1).label
        
        firstStation.tap()
        waitForStationToLoad();
        
        volume.adjust(toNormalizedSliderPosition: 0.2)
        volume.adjust(toNormalizedSliderPosition: 0.8)
        volume.adjust(toNormalizedSliderPosition: 0.5)
        
        app.buttons["More Info"].tap()
        assertStationInfo()
        app.buttons["Okay"].tap()
        app.buttons["logo"].tap()
        assertAboutContent()
        app.buttons["Okay"].tap()
        
        pauseButton.tap()
        assertPaused()
        playButton.tap()
        assertPlaying()
        app.navigationBars[stationName].buttons["Back"].tap()
        app.navigationBars["Swift Radio"].buttons["btn nowPlaying"].tap()
    }
    
}
