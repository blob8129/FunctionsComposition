//
//  Token.swift
//  ExpressionsCalculator
//
//  Created by Andrey Volobuev on 06/07/2017.
//  Copyright © 2017 blob8129. All rights reserved.
//

import Foundation

enum Token: CustomStringConvertible {
    case openBracket
    case closeBracket
    case operat0r(operation: (Double, Double) -> Double, precedence: Int, description: String)
    case operand(Double)
    
    var isOperator: Bool {
        switch self {
        case .operat0r(_, _, _):
            return true
        default:
            return false
        }
    }
    
    init?(operat0r: String) {
        switch operat0r {
        case "+":
            self = .operat0r(operation: { x, y in x + y }, precedence: 0, description: operat0r)
        case "-":
            self = .operat0r(operation: { x, y in x - y }, precedence: 0, description: operat0r)
        case "/":
            self = .operat0r(operation: { x, y in x / y }, precedence: 5, description: operat0r)
        case "*":
            self = .operat0r(operation: { x, y in x * y }, precedence: 5, description: operat0r)
        default:
            return nil
        }
    }
    
    var description: String {
        get {
            switch self {
            case .closeBracket:
                return ")"
            case .openBracket:
                return "("
            case .operand(let op):
                return "\(op)"
            case .operat0r(_, _, let opDescription):
                return opDescription
            }
        }
    }
}


func <= (left: Token, right: Token) -> Bool {
    if case .operat0r(_, let leftPrecedence, _) = left,
        case .operat0r(_, let rightPrecedence, _) = right {
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
