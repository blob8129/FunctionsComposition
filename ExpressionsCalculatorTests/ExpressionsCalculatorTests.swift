//
//  ExpressionsCalculatorTests.swift
//  ExpressionsCalculatorTests
//
//  Created by Andrey Volobuev on 06/07/2017.
//  Copyright © 2017 blob8129. All rights reserved.
//

import XCTest
@testable import ExpressionsCalculator

class ExpressionsCalculatorTests: XCTestCase {

    func testAdd() {
        let calc = Calculator()
        XCTAssertEqual(calc.evaluate("1 + 2"), 3)
    }
    
    func testMinus() {
        let calc = Calculator()
        XCTAssertEqual(calc.evaluate("5 - 2"), 3)
    }
    
    func testMinusNegative() {
        let calc = Calculator()
        XCTAssertEqual(calc.evaluate("2 - 5"), -3)
    }
    
    func testMult() {
        let calc = Calculator()
        XCTAssertEqual(calc.evaluate("2 * 5"), 10)
    }
    
    func testDivision() {
        let calc = Calculator()
        XCTAssertEqual(calc.evaluate("10 / 2"), 5)
    }
    
    func testPrecedenceNoBracet() {
        let calc = Calculator()
        XCTAssertEqual(calc.evaluate("10 + 2 * 10"), 30)
    }
    
    func testPrecedenceWithBracet() {
        let calc = Calculator()
        XCTAssertEqual(calc.evaluate("(10 + 2) * 10"), 120)
    }
    
    func testComplex() {
        let calc = Calculator()
        XCTAssertEqual(calc.evaluate("3 + 4.5 * 2 / (1.9 - 5.5 ) * 2 * 3"), -12)
    }
}
