//
//  CGVector.swift
//  Math
//
//  Created by Christian Otkjær on 20/04/15.
//  Copyright (c) 2015 Christian Otkjær. All rights reserved.
//

import CoreGraphics
//import Arithmetic

// MARK: - CGFloatPair

extension CGVector: CGFloatPair
{
    public init<S1: CGFloatConvertible, S2: CGFloatConvertible>(_ x: S1, _ y: S2)
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
                debugPrint("index (\(index)) out of bounds for \(type(of: self))")
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
                debugPrint("index (\(index)) out of bounds for \(type(of: self))")
                return 0
            }
        }
    }
    
    public var norm: CGFloat { return magnitude }
}

extension CGVector
{
    public init(point: CGPoint)
    {
        self.init(dx: point.x, dy: point.y)
    }
    
    public init(from: CGPoint, to: CGPoint)
    {
        self.init(dx: to.x - from.x, dy: to.y - from.y)
    }
    
    public func with(dx: CGFloat) -> CGVector
    {
        return CGVector(dx:dx, dy:dy)
    }
    
    public func with(dy: CGFloat) -> CGVector
    {
        return CGVector(dx:dx, dy:dy)
    }
}

public extension CGVector
{
    init(magnitude: CGFloat, direction: CGFloat)
    {
        self.init(dx: cos(direction) * magnitude, dy: sin(direction) * magnitude)
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
    
    public func with(magnitude: CGFloat) -> CGVector
    {
        return CGVector(magnitude: magnitude, direction: direction)
    }
    
    public func with(direction: CGFloat) -> CGVector
    {
        return CGVector(magnitude: magnitude, direction: direction)
    }
    
    public func normalized() -> CGVector
    {
        guard abs(magnitude) > CGFloat.ulpOfOne else { return CGVector.zero }
        
        return with(magnitude: 1)
    }
    
    // MARK: - normalizing
    
    public mutating func normalize()
    {
        self = normalized()
    }
}

// MARK: rotation

public extension CGVector
{
    public func rotated(_ theta:CGFloat) -> CGVector
    {
        return with(direction: direction + theta)
    }
    
    public mutating func rotate(_ theta: CGFloat)
    {
        self = rotated(theta)
    }
    
    /// 90 degrees counterclockwise rotation
    var orthogonal: CGVector { return CGVector(dx: -dy, dy: dx) }
    
    /// 180 degrees rotation
    var transposed: CGVector { return CGVector(dx: dy, dy: dx) }
    
    /// returns: vector from rotation this by 90 degrees either clockwise or counterclockwise
    func perpendicular(clockwise: Bool = true) -> CGVector
    {
        return clockwise ? CGVector(dx: dy, dy: -dx): CGVector(dx: -dy, dy: dx)
    }
}

// MARK: - atan2

/// ]-π;π]
public func atan2(_ vector: CGVector) -> CGFloat
{
    return atan2(vector.dy, vector.dx)
}

func length(_ vector: CGVector) -> CGFloat
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
    func isEqualTo(_ vector: CGVector, withPrecision precision:CGFloat) -> Bool
    {
        return  (self - vector).magnitude < abs(precision)
    }
}

func isEqual(_ vector1: CGVector, vector2: CGVector, precision: CGFloat = CGFloat.ulpOfOne) -> Bool
{
    return (vector1 - vector2).magnitude < abs(precision)
}

//MARK: - Draw

import UIKit
import Interpolation

public extension CGVector
{
    func draw(atPoint point: CGPoint, withColor color: UIColor = UIColor.blue, inContext: CGContext? = UIGraphicsGetCurrentContext())
    {
        guard let context = inContext else { return }
        
        let l = magnitude
        
        guard l > CGFloat.ulpOfOne else { return }
        
        context.saveGState()
        
        color.setStroke()
        
        let path = UIBezierPath()
        
        var vectorToDraw = self
        
        if l < 10
        {
            vectorToDraw *= 10 / l
        }
        
        path.move(to: point)
        path.addLine(to: point + vectorToDraw)
        
        path.stroke()
        
        context.restoreGState()
    }
    
    func bezierPathWithArrowFromPoint(_ startPoint: CGPoint) -> UIBezierPath
    {
        let length = magnitude
        let toPoint = startPoint + self
        let tailWidth = max(1, length / 30)
        let headWidth = max(3, length / 10)
        
        let headStartPoint = (startPoint, toPoint) ◊ 0.9
        
        let p = perpendicular().normalized()
        
        let path = UIBezierPath()
        
        path.move(to: toPoint)
        path.addLine(to: headStartPoint + p * headWidth)
        path.addLine(to: headStartPoint + p * tailWidth)
        path.addLine(to: startPoint + p * tailWidth)
        
        path.addLine(to: startPoint - p * tailWidth)
        path.addLine(to: headStartPoint - p * tailWidth)
        path.addLine(to: headStartPoint - p * headWidth)
        
        path.close()
        
        return path
    }
}
