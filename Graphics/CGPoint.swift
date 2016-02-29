//
//  CGPoint.swift
//  SilverbackFramework
//
//  Created by Christian Otkjær on 20/04/15.
//  Copyright (c) 2015 Christian Otkjær. All rights reserved.
//


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
