//
//  CGRect+Corners.swift
//  Graphics
//
//  Created by Christian Otkjær on 23/11/2017.
//  Copyright © 2017 Christian Otkjær. All rights reserved.
//

extension CGRect
{
    // MARK: - Corners
    
    /// The corners of the rectangle - from the origin and clockwise
    public var corners: [CGPoint]
    { return [ CGPoint(x: minX, y: minY),
               CGPoint(x: maxX, y: minY),
               CGPoint(x: maxX, y: maxY),
               CGPoint(x: minX, y: maxY)] }
}
