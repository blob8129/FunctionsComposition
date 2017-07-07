//
//  TokenType.swift
//  ExpressionsCalculator
//
//  Created by Andrey Volobuev on 06/07/2017.
//  Copyright © 2017 blob8129. All rights reserved.
//

import Foundation


enum TokenType: CustomStringConvertible {
    case openBracket
    case closeBracket
    case Operator(OperatorToken)
    case operand(Double)
    
    public var description: String {
        switch self {
        case .openBracket:
            return "("
        case .closeBracket:
            return ")"
        case .Operator(let operatorToken):
            return operatorToken.description
        case .operand(let value):
            return "\(value)"
        }
    }
}
