//
//  FunctionComposition.swift
//  ExpressionsCalculator
//
//  Created by Andrey Volobuev on 07/07/2017.
//  Copyright © 2017 blob8129. All rights reserved.
//

import Foundation


infix operator >>> :AdditionPrecedence
func >>> <A, B, C>(aToB: @escaping (A) -> B, bToC: @escaping (B) -> C) -> (A) -> C {
    return { a in
        let b = aToB(a)
        return bToC(b)
    }
}

func >>> <A, B>(aToB: @escaping (A) -> B, sideEffect:  @escaping (B) -> Void ) -> (A) -> B {
    return { a in
        let b = aToB(a)
        sideEffect(b)
        return b
    }
}
