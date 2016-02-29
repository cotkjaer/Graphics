//
//  CGContext.swift
//  SilverbackFramework
//
//  Created by Christian Otkjær on 12/08/15.
//  Copyright (c) 2015 Christian Otkjær. All rights reserved.
//

import CoreGraphics
import Geometry

// MARK: - Transformation

public extension CGContext
{
    func translate(tx tx: CGFloat, ty: CGFloat)
    {
        CGContextTranslateCTM(self, tx , ty)
    }

    func scale(sx sx: CGFloat, sy: CGFloat)
    {
        CGContextScaleCTM(self, sx, sy)
    }
    
    func rotate(angle: CGFloat)
    {
        CGContextRotateCTM(self, angle)
    }

    
    func translate(point: CGPoint)
    {
        translate(tx: point.x, ty: point.y)
    }

    func translate(vector: CGVector)
    {
        translate(tx: vector.dx, ty: vector.dy)
    }

    func rotate(angle: CGFloat, aroundPoint point: CGPoint)
    {
        translate(point)
        rotate(angle)
        translate(-point)
    }
}

public func CGContextRotateAroundPoint(context: CGContextRef,  point: CGPoint,  angle: CGFloat)
{
    CGContextTranslateCTM(context,  point.x , point.y)
    CGContextRotateCTM(context, angle)
    CGContextTranslateCTM(context, -point.x, -point.y)
}

public func CGContext(context: CGContextRef, rotate angle: CGFloat, aroundPoint point: CGPoint)
{
    CGContextRotateAroundPoint(context, point: point, angle: angle)
}