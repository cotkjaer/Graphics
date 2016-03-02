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
    
    // MARK: - Translate
    
    func translate(tx tx: CGFloat, ty: CGFloat)
    {
        CGContextTranslateCTM(self, tx , ty)
    }

    func translate(point: CGPoint)
    {
        translate(tx: point.x, ty: point.y)
    }
    
    func translate(vector: CGVector)
    {
        translate(tx: vector.dx, ty: vector.dy)
    }

    // MARK: - Scale
    
    func scale(sx sx: CGFloat, sy: CGFloat)
    {
        CGContextScaleCTM(self, sx, sy)
    }
    
    // MARK: - Rotate
    
    func rotate(angle: CGFloat)
    {
        CGContextRotateCTM(self, angle)
    }

    func rotate(angle: CGFloat, aroundPoint point: CGPoint)
    {
        translate(point)
        rotate(angle)
        translate(-point)
    }
}

