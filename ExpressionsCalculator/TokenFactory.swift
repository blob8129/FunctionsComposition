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
            return Token.operand(operand)
        case 1:
            return Token(operat0r: numAndElement.element)
        case 2:
            return Token.openBracket
        case 3:
            return Token.closeBracket
        default:
            return nil
        }
    }
}
