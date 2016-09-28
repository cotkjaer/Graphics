//
//  Line.swift
//  Graphics
//
//  Created by Christian Otkjær on 04/03/16.
//  Copyright © 2016 Christian Otkjær. All rights reserved.
//

import Arithmetic

// MARK: - Line Segment

public extension CGPoint
{
    func distanceToLineSegment(v: CGPoint, w: CGPoint) -> CGFloat
    {
        if v == w { return distance(to: v) }
        
        // |w-v|^2 - avoid a squareroot
        let l2 = v.distanceSquared(to: w)
        
        // Consider the line extending the segment, parameterized as v + t (w - v).
        // The projection of point p onto that line falls where t = [(p-v) . (w-v)] / |w-v|^2
        let t = dot(self - v, w - v) / l2
        
        if t < 0 // Beyond the 'v' end of the segment
        {
            return distance(to: v)
        }
        else if t > 1 // Beyond the 'w' end of the segment
        {
            return distance(to: w)
        }
        else // Projection falls on the segment
        {
            let projection = (v, w) ◊ t
            return distance(to: projection)
        }
    }
    
    /**
     Minimum distance between line segment and `self`
     - parameter ls: line-segment tuple
     */
    func distanceToLineSegment(_ ls: (CGPoint, CGPoint)) -> CGFloat
    {
        return distanceToLineSegment(v:ls.0, w:ls.1)
    }
}
