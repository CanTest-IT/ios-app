//
//  BaseTest.swift
//  CanTestItUITests
//
//  Created by Dawid Bastek on 22/04/2023.
//

import XCTest

class BaseTest: XCTestCase {
    
    let app = XCUIApplication()
    
    override func setUp() {
        app.launch()
        continueAfterFailure = false
    }
    
}



