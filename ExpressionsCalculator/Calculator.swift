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
        return (
            extractTokenStrings(from:)
                >>> { print("Debug: Extracted token strings: \($0) from \(expression)") }
                >>> indexTokenTypes(in:)
                >>> { print("Debug: Indexed tokens strings: \($0)") }
                >>> createTokens(from:)
                >>> { print("Debug: Created tokens: \($0)") }
                >>> convertToReversePolishNotation
                >>> { print("Debug: Reverse polish notation: \($0)") }
                >>> eval
                >>> { $0 != nil ?  print("Debug: \(expression) = \($0!)") : print("Debug: Can't evaluate \(expression)")}
        )(expression)
    }
    
    private func createTokens(from indexed: [(Int, String)]) -> [Token] {
        return indexed.flatMap(TokenFactory.createToken)
    }
    
    private func extractTokenStrings(from expression: String) -> [[String]] {
        let pattern = "(\\d+\\.?\\d?)|([\\+\\-\\*\\^\\/])|(\\()|(\\))"
        let regEx = try? NSRegularExpression(pattern: pattern, options: [])
        guard let matches = regEx?.matches(in: expression,
                                           options: [],
                                           range: NSRange(location: 0, length: expression.characters.count)) else {
                                            return [[String]]()
        }
        
        let rangesGroups = matches.map { match in
            // 0 is a full match 
            // 1 operand
            // 2 operator
            // 3 opening bracket
            // 4 closing bracket
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
    
    private func indexTokenTypes(in extractedTokens: [[String]]) -> [(Int, String)] {
        return extractedTokens.flatMap { items in
            items.enumerated().map { offset, element in
                    return (offset, element)
                }.filter{ offsetAndElement in
                    offsetAndElement.1 != ""
            }
        }
    }
    
    private func eval(res: [Token]) -> Double? {
        var stack = Stack<Double>()

        res.forEach { token in
            switch token {
            case .operat0r(let operation, _, _):
                guard let o1 = stack.pop(), let o2 = stack.pop() else { return }
                stack.push(operation(o2, o1))
            case .operand(let operand):
                stack.push(operand)
            default:
                break
            }
        }
        
        return stack.pop()
    }
    
    // This returns the result of the shunting yard algorithm
    // Took solution here https://github.com/raywenderlich/swift-algorithm-club/tree/master/Shunting%20Yard
    // And imprived it a bit )))
    private func convertToReversePolishNotation(_ expression: [Token]) -> [Token] {
        
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
                
            case .operat0r(_, _, _):
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
}
