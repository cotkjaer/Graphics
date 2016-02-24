//
//  CGPoint.swift
//  SilverbackFramework
//
//  Created by Christian Otkjær on 20/04/15.
//  Copyright (c) 2015 Christian Otkjær. All rights reserved.
//

import CoreGraphics
import UIKit

// MARK: - CGPoint

extension CGPoint
{
    // MARK: init
    
    public init(x: CGFloat)
    {
        self.init(x:x, y:0)
    }
    
    public init(y: CGFloat)
    {
        self.init(x:0, y:y)
    }

    public init(size: CGSize)
    {
        self.init(x:size.width, y:size.height)
    }

    // MARK: clamp
    
    func clampedTo(rect: CGRect) -> CGPoint
    {
        return CGPoint(
            x: x.clamped(rect.minX, rect.maxX),
            y: y.clamped(rect.minY, rect.maxY)
        )
    }
    
    // MARK: map
    
    func map(transform: CGFloat -> CGFloat) -> CGPoint
    {
        return CGPoint(x: transform(x), y: transform(y))
    }
    
    // MARK: with
    
    public func with(x  x: CGFloat) -> CGPoint
    {
        return CGPoint(x: x, y: y)
    }
    
    public func with(y  y: CGFloat) -> CGPoint
    {
        return CGPoint(x: x, y: y)
    }
    
    // MARK: distance
    
    public func distanceTo(point: CGPoint) -> CGFloat
    {
        return sqrt(distanceSquaredTo(point))
    }
    
    public func distanceSquaredTo(point: CGPoint) -> CGFloat
    {
        return pow(x - point.x, 2) + pow(y - point.y, 2)
    }
}

//MARK: - Convert
import UIKit
extension CGPoint
{
    public func convert(fromView fromView: UIView? = nil, toView: UIView) -> CGPoint
    {
        return toView.convertPoint(self, fromView: fromView)
    }
}

// MARK: - Comparable

extension CGPoint: Comparable { }

/// CAVEAT: first y then x comparison
public func > (p1: CGPoint, p2: CGPoint) -> Bool
{
    return (p1.y < p2.y) || ((p1.y == p2.y) && (p1.x < p2.x))
}

public func < (p1: CGPoint, p2: CGPoint) -> Bool
{
    return (p1.y > p2.y) || ((p1.y == p2.y) && (p1.x > p2.x))
}

// MARK: - Operators

public func + (p1: CGPoint, p2: CGPoint) -> CGPoint
{
    return CGPoint(x: p1.x + p2.x, y: p1.y + p2.y)
}

public func += (inout p1: CGPoint, p2: CGPoint)
{
    p1.x += p2.x
    p1.y += p2.y
}

public prefix func - (p: CGPoint) -> CGPoint
{
    return CGPoint(x: -p.x, y: -p.y)
}

public func - (p1: CGPoint, p2: CGPoint) -> CGPoint
{
    return CGPoint(x: p1.x - p2.x, y: p1.y - p2.y)
}

public func - (p1: CGPoint, p2: CGPoint?) -> CGPoint
{
    return p1 - (p2 ?? CGPointZero)
}

public func -= (inout p1: CGPoint, p2: CGPoint)
{
    p1.x -= p2.x
    p1.y -= p2.y
}

public func + (point: CGPoint, size: CGSize) -> CGPoint
{
    return CGPoint(x: point.x + size.width, y: point.y + size.height)
}

public func += (inout point: CGPoint, size: CGSize)
{
    point.x += size.width
    point.y += size.height
}


public func + (point: CGPoint, vector: CGVector) -> CGPoint
{
    return CGPoint(x: point.x + vector.dx, y: point.y + vector.dy)
}

public func += (inout point: CGPoint, vector: CGVector)
{
    point.x += vector.dx
    point.y += vector.dy
}

public func - (point: CGPoint, vector: CGVector) -> CGPoint
{
    return CGPoint(x: point.x - vector.dx, y: point.y - vector.dy)
}

public func -= (inout point: CGPoint, vector: CGVector)
{
    point.x -= vector.dx
    point.y -= vector.dy
}



public func - (point: CGPoint, size: CGSize) -> CGPoint
{
    return CGPoint(x: point.x - size.width, y: point.y - size.height)
}

public func -= (inout point: CGPoint, size: CGSize)
{
    point.x -= size.width
    point.y -= size.height
}

public func * (factor: CGFloat, point: CGPoint) -> CGPoint
{
    return CGPoint(x: point.x * factor, y: point.y * factor)
}

public func * (point: CGPoint, factor: CGFloat) -> CGPoint
{
    return CGPoint(x: point.x * factor, y: point.y * factor)
}

public func *= (inout point: CGPoint, factor: CGFloat)
{
    point.x *= factor
    point.y *= factor
}

public func / (point: CGPoint, factor: CGFloat) -> CGPoint
{
    return CGPoint(x: point.x / factor, y: point.y / factor)
}

public func /= (inout point: CGPoint, factor: CGFloat)
{
    point.x /= factor
    point.y /= factor
}

public func * (point: CGPoint, transform: CGAffineTransform) -> CGPoint
{
    return CGPointApplyAffineTransform(point, transform)
}

public func *= (inout point: CGPoint, transform: CGAffineTransform)
{
    point = point * transform//CGPointApplyAffineTransform(point, transform)
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

// MARK: - Tuples

public extension CGPoint
{
    init(_ tuple: (CGFloat, CGFloat))
    {
        (x, y) = tuple
    }
    
    var tuple: (CGFloat, CGFloat) { return (x, y) }
}

//MARK: - Zero

extension CGPoint
{
    static let zero = CGPointZero
    
    func isZero() -> Bool { return x == 0 && y == 0 }
}

// MARK: - Trigonometry

public func dotProduct(a: CGPoint, _ b: CGPoint) -> CGFloat
{
    return a.x * b.x + a.y * b.y
}

public func dot(a: CGPoint, _ b: CGPoint) -> CGFloat
{
    return a.x * b.x + a.y * b.y
}

public func · (a: CGPoint, _ b: CGPoint) -> CGFloat
{
    return a.x * b.x + a.y * b.y
}

public func distance(a: CGPoint, _ b: CGPoint) -> CGFloat
{
    return a.distanceTo(b)
}

public func distanceSquared(a: CGPoint, _ b: CGPoint) -> CGFloat
{
    return pow(a.x - b.x, 2) + pow(a.y - b.y, 2)
}


public func x(lhs: CGPoint, _ rhs: CGPoint) -> CGFloat
{
    return lhs.x * rhs.y - lhs.y * rhs.x
}

public func cross(lhs: CGPoint, _ rhs: CGPoint) -> CGFloat
{
    return lhs.x * rhs.y - lhs.y * rhs.x
}

public func crossProduct(lhs: CGPoint, _ rhs: CGPoint) -> CGFloat
{
    return lhs.x * rhs.y - lhs.y * rhs.x
}

// MARK: - atan2

/// ]-π;π]
public func atan2(point: CGPoint) -> CGFloat
{
    return atan2(point.y, point.x)
}

// MARK: - Translate

extension CGPoint
{
    public mutating func translate(dx: CGFloat? = nil, dy: CGFloat? = nil)
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
    
    public func translated(dx: CGFloat? = nil, dy: CGFloat? = nil) -> CGPoint
    {
        var p = CGPoint(x: x, y: y)
        
        if let delta = dx
        {
            p.x += delta
        }
        
        if let delta = dy
        {
            p.y += delta
        }
        
        return p
    }
}

