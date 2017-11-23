//
//  CGRect+Square.swift
//  Graphics
//
//  Created by Christian Otkjær on 23/11/2017.
//  Copyright © 2017 Christian Otkjær. All rights reserved.
//

extension CGRect
{
    /// A square that has the same center as this rectangle and side-length = min(width, height)
    public var innerSquare: CGRect
    {
        return CGRect(center: center, size: CGSize(side: min(width, height)))
    }
    
    /// A square that has the same center as this rectangle and side-length = max(width, height)
    public var outerSquare: CGRect
    {
        return CGRect(center: center, size: CGSize(side: max(width, height)))
    }
    
    /// `true` iff `width == height`
    var isSquare: Bool { return width == height }
    
    /// Returns a square that either fits inside this rectangle (if `inner` is *true*) or that this rectagle fits into (if `inner` is *false*)
    /// - parameter horizontal: Horizontal Alignment (default is `middle`)
    /// - parameter vertical: Vertical Alignment (default is `middle`)
    /// - parameter inner: flag to determine if it should be inner or outer
    public func squared(horizontal: Align = .middle, vertical: Align = .middle, inner: Bool = true) -> CGRect
    {
        let side = inner ? min(width, height) : max(width, height)
        
        let x = minX + (width - side) * horizontal.value
        let y = minX + (height - side) * vertical.value
        
        let rect = CGRect(origin: CGPoint(x: x, y: y), size: CGSize(side: side))
        
        return rect
    }
}
