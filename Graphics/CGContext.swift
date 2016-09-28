//
//  CGContext.swift
//  SilverbackFramework
//
//  Created by Christian Otkjær on 12/08/15.
//  Copyright (c) 2015 Christian Otkjær. All rights reserved.
//

import CoreGraphics

// MARK: - Transformation

public extension CGContext
{
    // MARK: - Translate
    
    func translate(tx: CGFloat, ty: CGFloat)
    {
        self.translateBy(x: tx , y: ty)
    }

    func translate(_ point: CGPoint)
    {
        translate(tx: point.x, ty: point.y)
    }
    
    func translate(_ vector: CGVector)
    {
        translate(tx: vector.dx, ty: vector.dy)
    }

    // MARK: - Scale
    
    func scale(sx: CGFloat, sy: CGFloat)
    {
        self.scaleBy(x: sx, y: sy)
    }
    
    // MARK: - Rotate
    
    func rotate(_ angle: CGFloat)
    {
        self.rotate(by: angle)
    }

    func rotate(_ angle: CGFloat, aroundPoint point: CGPoint)
    {
        translate(point)
        rotate(angle)
        translate(-point)
    }
}

