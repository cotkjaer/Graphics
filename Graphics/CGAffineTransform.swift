//
//  CGAffineTransform.swift
//  SilverbackFramework
//
//  Created by Christian Otkjær on 20/04/15.
//  Copyright (c) 2015 Christian Otkjær. All rights reserved.
//

import CoreGraphics

// MARK: - CustomDebugStringConvertible

extension CGAffineTransform: CustomDebugStringConvertible
{
    public var debugDescription: String
        {
            return "(\(a), \(b), \(c), \(d), \(tx), \(ty))"
    }
}

// MARK: - Operators

public func * (t1: CGAffineTransform, t2: CGAffineTransform) -> CGAffineTransform
{
    return t1.concatenating(t2)
}

public func *= (t1: inout CGAffineTransform, t2: CGAffineTransform)
{
    t1 = t1 * t2
}
