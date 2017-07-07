//
//  Calculator.swift
//  ExpressionsCalculator
//
//  Created by Andrey Volobuev on 06/07/2017.
//  Copyright © 2017 blob8129. All rights reserved.
//

import Foundation


public struct Calculator {
    
    func evaluate(_ expression: String) -> Double? {
        let tokens = indexTypeGroups(of: extractTokens(from: expression)).flatMap(TokenFactory.createToken)
        
        let postfixTokens = reversePolishNotation(tokens)
        return eval(res: postfixTokens)
    }
    
    func extractTokens(from expression: String) -> [[String]] {
        let pattern = "(\\d+\\.?\\d?)|([\\+\\-\\*\\^\\/])|(\\()|(\\))"
        let regEx = try? NSRegularExpression(pattern: pattern, options: [])
        guard let matches = regEx?.matches(in: expression,
                                           options: [],
                                           range: NSRange(location: 0, length: expression.characters.count)) else {
                                            return [[String]]()
        }
        
        let rangesGroups = matches.map { match in
            (1..<match.numberOfRanges).map { index in
                return match.rangeAt(index)
            }
        }
        
        let matchedStrings = rangesGroups.map { group -> [String]  in
            group.map { range -> String in
                guard range.length > 0 else { return "" }
                let start = expression.index(expression.startIndex, offsetBy: range.location)
                let endIndex = range.length + range.location
                let end = expression.index(expression.startIndex, offsetBy: endIndex)
                return expression[start..<end]
            }
        }
        
        return matchedStrings
    }
    
    func indexTypeGroups(of extractedTokens: [[String]]) -> [(Int, String)] {
        return extractedTokens.flatMap { items in
            items.enumerated().map { offset, element in
                    return (offset, element)
                }.filter{ offsetAndElement in
                    offsetAndElement.1 != ""
            }
        }
    }
    
    func eval(res: [Token]) -> Double? {
        var stack = Stack<Double>()

        res.forEach { token in
            switch token.tokenType {
            case .Operator(let opToken):
                guard let o1 = stack.pop(), let o2 = stack.pop() else { return }
                let operation = opToken.operatorType.operation
                stack.push(operation(o2, o1))
            case .operand(let operand):
                stack.push(operand)
            default:
                break
            }
        }

        return stack.pop()
    }
}
