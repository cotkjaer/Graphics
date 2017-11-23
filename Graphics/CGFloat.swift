//
//  CGFloat.swift
//  Graphics
//
//  Created by Christian Otkjær on 02/03/16.
//  Copyright © 2016 Christian Otkjær. All rights reserved.
//

import Arithmetic
import Rounding

extension CGFloat: FloatingPointArithmeticType {}

// MARK: - Convertible

public extension CGFloat
{
    public init<C:CGFloatConvertible>(_ convertible: C)
    {
        self = convertible.cgFloat
    }
}

// MARK: - Power

//public func ** (left: CGFloat, right: CGFloat) -> CGFloat { return left.pow(right) }

extension CGFloat//: Powerable
{
    public func pow(_ rhs: CGFloat) -> CGFloat
    {
        return CoreGraphics.pow(self, rhs)
    }
}

// MARK: - Roundable

extension CGFloat: Roundable
{
    /// Largest integral value not greater than `self`
    public var floor: CGFloat { return CoreGraphics.floor(self) }
    
    /// Smallest integral value not less than `self`
    public var ceil: CGFloat { return CoreGraphics.ceil(self) }
    
    /// Nearest integral value, eaqual to, less than, or greater than `self`
    public var round: CGFloat { return CoreGraphics.round(self) }
}

//// MARK: - Epsilon
//
//extension CGFloat
//{
//    /// The smallest CGFloat where `CGFloat(1) + CGFloat.epsilon != CGFloat(1)`
//    public static var epsilon: CGFloat
//    {
//        return self.ulpOfOne
//        
//        #if arch(arm64) || arch(x86_64)
//            
//            assert(MemoryLayout<Double>.size == MemoryLayout<CGFloat>.size)
//            return CGFloat(Double.ulpOfOne)
//            
//        #elseif arch(arm) || arch(i386)
//            
//            assert(MemoryLayout<Float>.size == MemoryLayout<CGFloat>.size)
//            return CGFloat(Float.ulpOfOne)
//            
//        #endif
//    }
//}

// Constants for easy access

public let π = CGFloat.π
public let π2 = CGFloat.π2
public let π_2 = CGFloat.π_2
public let π_4 = CGFloat.π_4
public let π_8 = CGFloat.π_8

public let 𝑒 = CGFloat.𝑒
