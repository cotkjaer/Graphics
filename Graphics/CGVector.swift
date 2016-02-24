//
//  CGVector.swift
//  SilverbackFramework
//
//  Created by Christian Otkjær on 20/04/15.
//  Copyright (c) 2015 Christian Otkjær. All rights reserved.
//

import CoreGraphics


// MARK: - CGVector

public let CGVectorZero = CGVector(dx:0, dy:0)

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


// MARK: rotation

public extension CGVector
{
    public func rotated(theta:CGFloat) -> CGVector
    {
        return with(direction: direction + theta)
//        let sinTheta = sin(theta)
//        let cosTheta = cos(theta)
//        
//        return CGVector(magnitude: magnitude, direction: direction + theta)
//        dx = (dx * cosTheta - dy * sinTheta)
//        dy = (dx * sinTheta + dy * cosTheta)
    }
    
    public mutating func rotate(theta: CGFloat)
    {
        self = rotated(theta)
//        let sinTheta = sin(theta)
//        let cosTheta = cos(theta)
//        
//        dx = (dx * cosTheta - dy * sinTheta)
//        dy = (dx * sinTheta + dy * cosTheta)
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

// MARK: operators

public func + (vector1: CGVector, vector2: CGVector) -> CGVector
{
    return CGVector(dx: vector1.dx + vector2.dx, dy: vector1.dy + vector2.dy)
}

public func += (inout vector1: CGVector, vector2: CGVector)
{
    vector1 = vector1 + vector2
}

public func - (vector1: CGVector, vector2: CGVector) -> CGVector
{
    return CGVector(dx: vector1.dx - vector2.dx, dy: vector1.dy - vector2.dy)
}

public func -= (inout vector1: CGVector, vector2: CGVector)
{
    vector1 = vector1 - vector2
}

public func + (vector: CGVector, size: CGSize) -> CGVector
{
    return CGVector(dx: vector.dx + size.width, dy: vector.dy + size.height)
}

public func += (inout vector: CGVector, size: CGSize)
{
    vector = vector + size
}

public func - (vector: CGVector, size: CGSize) -> CGVector
{
    return CGVector(dx: vector.dx - size.width, dy: vector.dy - size.height)
}

public func -= (inout vector: CGVector, size: CGSize)
{
    vector = vector - size
}

public func * (factor: CGFloat, vector: CGVector) -> CGVector
{
    return CGVector(dx: vector.dx * factor, dy: vector.dy * factor)
}

public func * (vector: CGVector, factor: CGFloat) -> CGVector
{
    return CGVector(dx: vector.dx * factor, dy: vector.dy * factor)
}

public func *= (inout vector: CGVector, factor: CGFloat)
{
    vector = vector * factor
}

public func / (vector: CGVector, factor: CGFloat) -> CGVector
{
    return CGVector(dx: vector.dx / factor, dy: vector.dy / factor)
}

public func /= (inout vector: CGVector, factor: CGFloat)
{
    vector = vector / factor
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
        
        let headStartPoint = lerp(startPoint, toPoint, CGFloat(0.9))
        
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

