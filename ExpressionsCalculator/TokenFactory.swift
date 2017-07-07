//
//  TokenFactory.swift
//  ExpressionsCalculator
//
//  Created by Andrey Volobuev on 06/07/2017.
//  Copyright © 2017 blob8129. All rights reserved.
//

import Foundation


struct TokenFactory {
    static func createToken(from numAndElement: (num: Int, element: String)) -> Token? {
        switch numAndElement.num {
        case 0:
            guard let operand = Double(numAndElement.element) else {
                return nil
            }
            return Token(operand: operand)
        case 1:
            guard let operatorType = OperatorType(operat0r: numAndElement.element) else {
                return nil
            }
            return Token(operatorType: operatorType)
        case 2:
            return Token(tokenType: .openBracket)
        case 3:
            return Token(tokenType: .closeBracket)
        default:
            return nil
        }
    }
}
