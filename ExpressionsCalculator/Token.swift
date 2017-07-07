//
//  Token.swift
//  ExpressionsCalculator
//
//  Created by Andrey Volobuev on 06/07/2017.
//  Copyright © 2017 blob8129. All rights reserved.
//

import Foundation

//enum Token {
//    case openBracket
//    case closeBracket
//    case operat0r(operation: (Double, Double) -> Double, precedence: Int)
//    case operand(Double)
//}
//
//func <= (left: Token, right: Token) -> Bool {
//    if case Token.opera
//    return left.precedence <= right.precedence
//}

//func < (left: OperatorToken, right: OperatorToken) -> Bool {
//    return left.precedence < right.precedence
//}
public struct Token: CustomStringConvertible {
    let tokenType: TokenType
    
    init(tokenType: TokenType) {
        self.tokenType = tokenType
    }
    
    init(operand: Double) {
        tokenType = .operand(operand)
    }
    
    init(operatorType: OperatorType) {
        tokenType = .Operator(OperatorToken(operatorType: operatorType))
    }
    
    var isOpenBracket: Bool {
        switch tokenType {
        case .openBracket:
            return true
        default:
            return false
        }
    }
    
    var isOperator: Bool {
        switch tokenType {
        case .Operator(_):
            return true
        default:
            return false
        }
    }
    
    var operatorToken: OperatorToken? {
        switch tokenType {
        case .Operator(let operatorToken):
            return operatorToken
        default:
            return nil
        }
    }
    
    public var description: String {
        return tokenType.description
    }
}
