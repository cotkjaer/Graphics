//
//  CGFloat.swift
//  Geometry
//
//  Created by Christian Otkjær on 18/02/16.
//  Copyright © 2016 Christian Otkjær. All rights reserved.
//

import Arithmetic

extension CGFloat : FloatingPointArithmeticType {}

// MARK: - Power

public func ** (left: CGFloat, right: CGFloat) -> CGFloat { return left.pow(right) }

extension CGFloat : Powerable
{
    @warn_unused_result
    public func pow(rhs: CGFloat) -> CGFloat
    {
        return CoreGraphics.pow(self, rhs)
    }
}

// MARK: - Roundable

extension CGFloat
{
    /// Largest integral value not greater than `self`
    public var floor : CGFloat { return CoreGraphics.floor(self) }
    
    /// Smallest integral value not less than `self`
    public var ceil : CGFloat { return CoreGraphics.ceil(self) }
    
    /// Nearest integral value, eaqual to, less than, or greater than `self`
    public var round : CGFloat { return CoreGraphics.round(self) }
}

// MARK: - Epsilon

extension CGFloat
{
    /// The smallest CGFloat where `CGFloat(1) + CGFloat.epsilon != CGFloat(1)`
    public static var epsilon : CGFloat
    {
        #if arch(arm64) || arch(x86_64)
            
            assert(sizeof(Double) == sizeof(CGFloat))
            return CGFloat(DBL_EPSILON)
            
        #elseif arch(arm) || arch(i386)
            
            assert(sizeof(Float) == sizeof(CGFloat))
            return CGFloat(FLT_EPSILON)
            
        #endif
    }
}

//Rect
//MARK: - Zero

extension CGRect : Zeroable
{
    public static var zero : CGRect { return CGRectZero }
}

// MARK: - Size

extension CGSize : Zeroable
{
    public static var zero : CGSize { return CGSizeZero }
}

//MARK: - Point

extension CGPoint : Zeroable
{
    public static var zero : CGPoint { return CGPointZero }
}

extension CGPoint : Roundable
{
    /**
     Round `self` to arbitrary whole multiplica of `point`
     
     - parameter number: the number to use in rounding
     */
    public func rounded(toNearest point: CGPoint) -> CGPoint
    {
        return CGPoint(x: x.rounded(toNearest: point.x), y: y.rounded(toNearest: point.y))
    }
    
    /// Largest integral value not greater than `self`
    public var floor : CGPoint { return CGPoint(x: x.floor, y: y.floor) }
    
    /// Smallest integral value not less than `self`
    public var ceil : CGPoint { return CGPoint(x: x.ceil, y: y.ceil) }
    
    /// Nearest integral value, eaqual to, less than, or greater than `self`
    public var round : CGPoint { return CGPoint(x: x.round, y: y.round) }
}

// MARK: Fuzzy

extension CGPoint: FuzzyEquatable
{
    public func equalTo(other: CGPoint, within precision: CGPoint) -> Bool
    {
        return distance(other) <= precision.distance(CGPointZero)
    }
}

public func ≈≈ (lhs: CGPoint, rhs: CGPoint) -> Bool { return lhs.x ≈≈ rhs.x && lhs.y ≈≈ rhs.y }

// MARK: - Equatable

extension CGPoint : ApproximatelyEquatable
{
    public func isEqualTo(point: CGPoint, withPrecision precision:CGFloat = CGFloat.epsilon) -> Bool
    {
        return  distance(point) < abs(precision)
    }
}

