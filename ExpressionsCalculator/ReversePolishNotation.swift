//
//  ReversePolishNotation.swift
//  ExpressionsCalculator
//
//  Created by Andrey Volobuev on 06/07/2017.
//  Copyright © 2017 blob8129. All rights reserved.
//

import Foundation


// This returns the result of the shunting yard algorithm
func reversePolishNotation(_ expression: [Token]) -> [Token] {
    
    var tokenStack = Stack<Token>()
    var reversePolishNotation = [Token]()
    
    for token in expression {
        switch token {
        case .operand(_):
            reversePolishNotation.append(token)
            
        case .openBracket:
            tokenStack.push(token)
            
        case .closeBracket:
            while tokenStack.count > 0, let tempToken = tokenStack.pop(),  tempToken != .openBracket {
                reversePolishNotation.append(tempToken)
            }
            
        case .operat0r(_, _):
            for tempToken in tokenStack.makeIterator() {
                if tempToken.isOperator == false {
                    break
                }
                
                if token <= tempToken {
                    reversePolishNotation.append(tokenStack.pop()!)
                } else {
                    break
                }
            }
            tokenStack.push(token)
        }
    }
    
    while tokenStack.count > 0 {
        reversePolishNotation.append(tokenStack.pop()!)
    }
    
    return reversePolishNotation
}
