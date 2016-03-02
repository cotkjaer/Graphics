//
//  CGPoint.swift
//  SilverbackFramework
//
//  Created by Christian Otkjær on 20/04/15.
//  Copyright (c) 2015 Christian Otkjær. All rights reserved.
//

import Geometry
import Arithmetic

extension CGPoint : Point2D
{
    public typealias Scalar = CGFloat
}

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

// MARK: - Operators

public func * (point: CGPoint, transform: CGAffineTransform) -> CGPoint
{
    return CGPointApplyAffineTransform(point, transform)
}

public func *= (inout point: CGPoint, transform: CGAffineTransform)
{
    point = point * transform
}

//MARK: - Vector

public func + (point: CGPoint, vector: CGVector) -> CGPoint
{
    return CGPoint(x: vector.dx + point.x, y: vector.dy + point.y)
}

public func - (point: CGPoint, vector: CGVector) -> CGPoint
{
    return CGPoint(x: vector.dx - point.x, y: vector.dy - point.y)
}

//MARK: - Round

public func round(point: CGPoint, toDecimals: Int = 0) -> CGPoint
{
    let decimals = max(0, toDecimals)
    
    if decimals == 0
    {
        return CGPoint(x: round(point.x), y: round(point.y))
    }
    else
    {
        let factor = pow(10, CGFloat(max(decimals, 0)))
        
        return CGPoint(x: round(point.x * factor) / factor, y: round(point.y * factor) / factor)
    }
}
