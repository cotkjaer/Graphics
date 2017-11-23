//
//  CGRect+Interpolation.swift
//  Graphics
//
//  Created by Christian Otkjær on 23/11/2017.
//  Copyright © 2017 Christian Otkjær. All rights reserved.
//

import Interpolation

/// Basic linear interpolation of two points
public func ◊ (ab: (CGRect, CGRect), t: CGFloat) -> CGRect
{
    return CGRect(origin: (ab.0.origin, ab.1.origin) ◊ t, size: (ab.0.size, ab.1.size) ◊ t)
}
