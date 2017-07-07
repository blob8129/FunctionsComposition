//
//  Token.swift
//  ExpressionsCalculator
//
//  Created by Andrey Volobuev on 06/07/2017.
//  Copyright © 2017 blob8129. All rights reserved.
//

import Foundation

enum Token {
    case openBracket
    case closeBracket
    case operat0r(operation: (Double, Double) -> Double, precedence: Int)
    case operand(Double)
    
    var isOperator: Bool {
        switch self {
        case .operat0r(_, _):
            return true
        default:
            return false
        }
    }
    
    init?(operat0r: String) {
        switch operat0r {
        case "+":
            self = .operat0r(operation: { x, y in x + y }, precedence: 0)
        case "-":
            self = .operat0r(operation: { x, y in x - y }, precedence: 0)
        case "/":
            self = .operat0r(operation: { x, y in x / y }, precedence: 5)
        case "*":
            self = .operat0r(operation: { x, y in x * y }, precedence: 5)
        default:
            return nil
        }
    }
}


func <= (left: Token, right: Token) -> Bool {
    if case .operat0r(_, let leftPrecedence) = left,
        case .operat0r(_, let rightPrecedence) = right {
        return leftPrecedence <= rightPrecedence
    }
    return false
}

extension Token: Equatable {
    static func == (left: Token, right: Token) -> Bool {
        switch (left, right) {
        case (.openBracket, .openBracket):
            return true
        default:
            return false
        }
    }
}
