//
//  CGVector.swift
//  Math
//
//  Created by Christian Otkjær on 20/04/15.
//  Copyright (c) 2015 Christian Otkjær. All rights reserved.
//

import CoreGraphics
import Arithmetic

// MARK: - Zero

//public let CGVectorZero = CGVector(dx:0, dy:0)

// MARK: - CGFloatPair

extension CGVector : CGFloatPair
{
    public init<S1 : CGFloatConvertible, S2 : CGFloatConvertible>(_ x: S1, _ y: S2)
    {
        self.init(dx: CGFloat(x), dy: CGFloat(y))
    }

    public subscript(index: Int) -> CGFloat
        {
        set
        {
            switch index
            {
            case 0:
                dx = newValue
                
            case 1:
                dy = newValue
                
            default:
                debugPrint("index (\(index)) out of bounds for \(self.dynamicType)")
            }
        }
        get
        {
            switch index
            {
            case 0:
                return dx
                
            case 1:
                return dy
                
            default:
                debugPrint("index (\(index)) out of bounds for \(self.dynamicType)")
                return 0
            }
        }
    }
    
    public var norm : CGFloat { return magnitude }
}

extension CGVector
{
    public init(point: CGPoint)
    {
        dx = point.x
        dy = point.y
    }
    
    public init(from:CGPoint, to: CGPoint)
    {
        dx = to.x - from.x
        dy = to.y - from.y
    }
    
    public func with(dx dx: CGFloat) -> CGVector
    {
        return CGVector(dx:dx, dy:dy)
    }
    
    public func with(dy dy: CGFloat) -> CGVector
    {
        return CGVector(dx:dx, dy:dy)
    }
}

public extension CGVector
{
    init(magnitude: CGFloat, direction: CGFloat)
    {
        dx = cos(direction) * magnitude
        dy = sin(direction) * magnitude
    }
    
    var magnitude: CGFloat
        {
        get
        {
            return sqrt(magnitudeSquared)
        }
        set
        {
            self = CGVector(magnitude: newValue, direction: direction)
        }
    }
    
    var magnitudeSquared: CGFloat { return dx * dx + dy * dy }
    
    var direction: CGFloat
        {
        get
        {
            return atan2(self)
        }
        set
        {
            self = CGVector(magnitude: magnitude, direction: newValue)
        }
    }
    
    public func with(magnitude magnitude: CGFloat) -> CGVector
    {
        return CGVector(magnitude: magnitude, direction: direction)
    }
    
    public func with(direction direction: CGFloat) -> CGVector
    {
        return CGVector(magnitude: magnitude, direction: direction)
    }
    
    var normalized: CGVector
        {
            let magnitude = self.magnitude
            
            if magnitude < CGFloat.epsilon
            {
                return self
            }
            else
            {
                return self / magnitude
            }
    }
    
    // MARK: - normalizing
    
    public mutating func normalize()
    {
        self = normalized
    }
}

// MARK: rotation

public extension CGVector
{
    public func rotated(theta:CGFloat) -> CGVector
    {
        return with(direction: direction + theta)
    }
    
    public mutating func rotate(theta: CGFloat)
    {
        self = rotated(theta)
    }
    
    /// 90 degrees counterclockwise rotation
    var orthogonal: CGVector { return CGVector(dx: -dy, dy: dx) }
    
    /// 180 degrees rotation
    var transposed: CGVector { return CGVector(dx: dy, dy: dx) }
    
    /// returns: vector from rotation this by 90 degrees either clockwise or counterclockwise
    func perpendicular(clockwise clockwise : Bool = true) -> CGVector
    {
        return clockwise ? CGVector(dx: dy, dy: -dx) : CGVector(dx: -dy, dy: dx)
    }
}

// MARK: - atan2

/// ]-π;π]
public func atan2(vector: CGVector) -> CGFloat
{
    return atan2(vector.dy, vector.dx)
}

func length(vector: CGVector) -> CGFloat
{
    return vector.magnitude
}

func midPoint(between vector1:CGVector, and vector2:CGVector) -> CGVector
{
    return CGVector(dx: (vector1.dx + vector2.dx) / 2.0, dy: (vector1.dy + vector2.dy) / 2.0)
}

// MARK: Equatable

extension CGVector//: Equatable
{
    func isEqualTo(vector: CGVector, withPrecision precision:CGFloat) -> Bool
    {
        return  (self - vector).magnitude < abs(precision)
    }
}

func isEqual(vector1: CGVector, vector2: CGVector, precision: CGFloat = CGFloat.epsilon) -> Bool
{
    return (vector1 - vector2).magnitude < abs(precision)
}

//MARK: - Draw

import UIKit


public extension CGVector
{
    func draw(atPoint point: CGPoint, withColor color: UIColor = UIColor.blueColor(), inContext: CGContextRef? = UIGraphicsGetCurrentContext())
    {
        guard let context = inContext else { return }
        
        let l = magnitude
        
        guard l > CGFloat.epsilon else { return }
        
        CGContextSaveGState(context)
        
        color.setStroke()
        
        let path = UIBezierPath()
        
        var vectorToDraw = self
        
        if l < 10
        {
            vectorToDraw *= 10 / l
        }
        
        path.moveToPoint(point)
        path.addLineToPoint(point + vectorToDraw)
        
        path.stroke()
        
        CGContextRestoreGState(context)
    }
    
    func bezierPathWithArrowFromPoint(startPoint: CGPoint) -> UIBezierPath
    {
        let length = magnitude
        let toPoint = startPoint + self
        let tailWidth = max(1, length / 30)
        let headWidth = max(3, length / 10)
        
        let headStartPoint = (startPoint, toPoint) ◊ 0.9
        
        let p = perpendicular().normalized
        
        let path = UIBezierPath()
        
        path.moveToPoint(toPoint)
        path.addLineToPoint(headStartPoint + p * headWidth)
        path.addLineToPoint(headStartPoint + p * tailWidth)
        path.addLineToPoint(startPoint + p * tailWidth)
        
        path.addLineToPoint(startPoint - p * tailWidth)
        path.addLineToPoint(headStartPoint - p * tailWidth)
        path.addLineToPoint(headStartPoint - p * headWidth)
        
        path.closePath()
        
        return path
    }
}
