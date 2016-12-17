//
//  CalculatorBrain.swift
//  Apollo
//
//  Created by Zhihui Tang on 2016-12-17.
//  Copyright © 2016 Zhihui Tang. All rights reserved.
//

import Foundation


class CalculatorBrain {
    
    private var accumulator = 0.0
    private var pending: PendingBinaryOperationInfo?

    func setOperand(operand: Double) {
        accumulator = operand
    }
    
    var operations: Dictionary<String, Operation> =  [
        "π": Operation.Constant(M_PI), //M_PI,
        "e": Operation.Constant(M_E), //M_E,
        "√": Operation.UnaryOperation(sqrt), //sqrt,
        "±": Operation.UnaryOperation({ -$0 }),
//        "+": Operation.BinaryOperation(+), //
//        "−": Operation.BinaryOperation(-), //
//        "×": Operation.BinaryOperation(*),
//        "÷": Operation.BinaryOperation(/), //
//        "+": Operation.BinaryOperation( (op1, op2) in return op1 + op2 ), //
//        "+": Operation.BinaryOperation( ($1, $1) in return $1 + op2$1), //
//        "+": Operation.BinaryOperation( {return $0 + $1} ), //
        "+": Operation.BinaryOperation( {$0 + $1} ),
        "−": Operation.BinaryOperation( {$0 - $1} ),
        "×": Operation.BinaryOperation( {$0 * $1} ),
        "÷": Operation.BinaryOperation( {$0 / $1} ),
        "=": Operation.Equals,
        "sin": Operation.UnaryOperation(sin),
        "cos": Operation.UnaryOperation(cos)
        
    ]
    
    enum Operation {
        case Constant(Double)
        case UnaryOperation((Double)->Double)
        case BinaryOperation((Double, Double)->Double)
        case Equals
    }
    
    func performOperation(symbol: String) {
        if let operation = operations[symbol] {
            switch operation {
            case .Constant(let value): accumulator = value
            case .UnaryOperation(let function): accumulator = function(accumulator)
            case .BinaryOperation(let function):
                executePendingBinaryOperation()
                pending = PendingBinaryOperationInfo(binaryFunction: function, firstOperand: accumulator)
            case .Equals:
                executePendingBinaryOperation()
            }
        }
    }
    
    private func executePendingBinaryOperation() {
        if pending != nil {
            accumulator = pending!.binaryFunction(pending!.firstOperand, accumulator)
            pending = nil
        }
    }
    
    struct PendingBinaryOperationInfo{
        var binaryFunction: (Double, Double) -> Double
        var firstOperand: Double
    }
    
    var result: Double {
        get {
            return accumulator
        }
    }
}
