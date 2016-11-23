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
    
    func translate(by point: CGPoint)
    {
        translateBy(x: point.x, y: point.y)
    }
    
    func translate(by vector: CGVector)
    {
        translateBy(x: vector.dx, y: vector.dy)
    }

    // MARK: - Scale
    
    // MARK: - Rotate
    
    func rotate(by angle: CGFloat, aroundPoint point: CGPoint)
    {
        translate(by: point)
        rotate(by: angle)
        translate(by: -point)
    }
}

