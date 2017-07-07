//
//  OperatorType.swift
//  ExpressionsCalculator
//
//  Created by Andrey Volobuev on 06/07/2017.
//  Copyright © 2017 blob8129. All rights reserved.
//

import Foundation


enum OperatorType: CustomStringConvertible {
    case add
    case subtract
    case divide
    case multiply
    
    init?(operat0r: String) {
        switch operat0r {
        case "+":
            self = .add
        case "-":
            self = .subtract
        case "/":
            self = .divide
        case "*":
            self = .multiply
        default:
            return nil
        }
    }
    
    var description: String {
        switch self {
        case .add:
            return "+"
        case .subtract:
            return "-"
        case .divide:
            return "/"
        case .multiply:
            return "*"
        }
    }
    
    var operation: (Double, Double) -> Double {
        switch self {
        case .add:
            return { x, y in x + y }
        case .subtract:
            return { x, y in x - y }
        case .divide:
            return { x, y in x / y }
        case .multiply:
            return { x, y in x * y }
        }
    }
}
