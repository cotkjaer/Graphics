//
//  CGPoint.swift
//  SilverbackFramework
//
//  Created by Christian Otkjær on 20/04/15.
//  Copyright (c) 2015 Christian Otkjær. All rights reserved.
//

import Arithmetic

// MARK: - TwoDimensional

extension CGPoint : TwoDimensional
{
    public init<S1 : CGFloatConvertible, S2 : CGFloatConvertible>(_ x: S1, _ y: S2)
    {
        self.init(x: CGFloat(x), y: CGFloat(y))
    }
    
    public subscript(index: Int) -> CGFloat
        {
        set
        {
            switch index
            {
            case 0:
                x = newValue
                
            case 1:
                y = newValue
                
            default:
                debugPrint("index (\(index)) out of bounds for \(self.dynamicType)")
            }
        }
        get
        {
            switch index
            {
            case 0:
                return x
                
            case 1:
                return y
                
            default:
                debugPrint("index (\(index)) out of bounds for \(self.dynamicType)")
                return 0
            }
        }
    }
    
    public var norm : CGFloat { return sqrt(x*x + y*y) }
    
    public static var zero : CGPoint { return CGPointZero }
}

// MARK: - Map

public extension CGPoint
{
    // MARK: with
    
    func with<Scalar: CGFloatConvertible>(x x: Scalar) -> CGPoint
    {
        return CGPoint(x, y)
    }
    
    func with<Scalar: CGFloatConvertible>(y y: Scalar) -> CGPoint
    {
        return CGPoint(x, y)
    }
}

// MARK: - Angle

public extension CGPoint
{
    public func angleToPoint(point: CGPoint) -> CGFloat
    {
        return atan2(point.y - y, point.x - x)
    }
}

// MARK: - Rotation

public extension CGPoint
{
    /// angle is in radians
    public mutating func rotate(theta:CGFloat, around center:CGPoint)
    {
        let sinTheta = sin(theta)
        let cosTheta = cos(theta)
        
        let transposedX = x - center.x
        let transposedY = y - center.y
        
        let translatedX = (transposedX * cosTheta - transposedY * sinTheta)
        let translatedY = (transposedX * sinTheta + transposedY * cosTheta)
        
        x = center.x + translatedX
        y = center.y + translatedY
    }
    
    public func rotated(theta:CGFloat, around center:CGPoint) -> CGPoint
    {
        return (self - center).rotated(theta) + center
    }
    
    public func rotated(theta:CGFloat) -> CGPoint
    {
        let sinTheta = sin(theta)
        let cosTheta = cos(theta)
        
        return CGPoint(x: x * cosTheta - y * sinTheta, y: x * sinTheta + y * cosTheta)
    }
}

public func rotate(point p1:CGPoint, radians: CGFloat, around rhs:CGPoint) -> CGPoint
{
    var p = p1
    
    p.rotate(radians, around: rhs)
    
    return p
}

// MARK: - Translate

extension CGPoint
{
    public mutating func translate<S1: CGFloatConvertible, S2: CGFloatConvertible>(dx: S1? = nil, dy: S2? = nil)
    {
        if let delta = dx
        {
            x += delta
        }
        
        if let delta = dy
        {
            y += delta
        }
    }
    
    public func translated<S1: CGFloatConvertible, S2: CGFloatConvertible>(dx: S1? = nil, dy: S2? = nil) -> CGPoint
    {
        var p = CGPoint(x: x, y: y)
        
        p.translate(dx, dy: dy)
        
        return p
    }
}

//// MARK: Fuzzy
//
//extension CGPoint: FuzzyEquatable
//{
//    public func equalTo(other: CGPoint, within precision: CGPoint) -> Bool
//    {
//        return distance(to:other) <= precision.distance(to: CGPoint.zero)
//    }
//}
//
//public func ≈≈ (lhs: CGPoint, rhs: CGPoint) -> Bool { return lhs.x ≈≈ rhs.x && lhs.y ≈≈ rhs.y }


// MARK: - ApproximatelyEquatable

extension CGPoint : ApproximatelyEquatable
{
    public func isEqualTo(point: CGPoint, withPrecision precision:CGFloat = CGFloat.epsilon) -> Bool
    {
        return distance(to: point) < abs(precision)
    }
}

public func isEqual(lhs: CGPoint, rhs: CGPoint, withPrecision precision:CGFloat) -> Bool
{
    return distance(lhs, rhs) < abs(precision)
}

// MARK: - Transform

public func * (point: CGPoint, transform: CGAffineTransform) -> CGPoint
{
    return CGPointApplyAffineTransform(point, transform)
}

public func *= (inout point: CGPoint, transform: CGAffineTransform)
{
    point = point * transform
}

// MARK: - Distance

extension CGPoint
{
    // MARK: distance
    
    func distance(to point: CGPoint) -> CGFloat
    {
        return CoreGraphics.sqrt(distanceSquared(to: point))
    }
    
    func distanceSquared(to point: CGPoint) -> CGFloat
    {
        return pow(x - point.x, 2) + pow(y - point.y, 2)
    }
}

public func distance(lhs: CGPoint, _ rhs: CGPoint) -> CGFloat
{
    return sqrt(distanceSquared(lhs, rhs))
}

public func distanceSquared(lhs: CGPoint, _ rhs: CGPoint) -> CGFloat
{
    return pow(lhs.x - rhs.x, 2) + pow(lhs.y - rhs.y, 2)
}