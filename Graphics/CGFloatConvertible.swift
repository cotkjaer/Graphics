//
//  CGFloatConvertible.swift
//  Graphics
//
//  Created by Christian Otkjær on 04/03/16.
//  Copyright © 2016 Christian Otkjær. All rights reserved.
//

// MARK: - CGFloatConvertible

public protocol CGFloatConvertible
{
    init (_ : CGFloat)
    
    var cgFloat : CGFloat { get }
}

extension CGFloat : CGFloatConvertible
{
    public var cgFloat : CGFloat { return self }
}

extension Double : CGFloatConvertible
{
    public var cgFloat : CGFloat { return CGFloat(self) }
}

extension Float : CGFloatConvertible
{
    public var cgFloat : CGFloat { return CGFloat(self) }
}

extension Int : CGFloatConvertible
{
    public var cgFloat : CGFloat { return CGFloat(self) }
}

public func + <Scalar: CGFloatConvertible> (lhs : CGFloat, rhs: Scalar) -> CGFloat
{
    return lhs + CGFloat(rhs)
}

public func += <Scalar: CGFloatConvertible> (inout lhs : CGFloat, rhs: Scalar)
{
    lhs += CGFloat(rhs)
}

public func - <Scalar: CGFloatConvertible> (lhs : CGFloat, rhs: Scalar) -> CGFloat
{
    return lhs - CGFloat(rhs)
}

public func -= <Scalar: CGFloatConvertible> (inout lhs : CGFloat, rhs: Scalar)
{
    lhs -= CGFloat(rhs)
}

public func * <Scalar: CGFloatConvertible> (lhs : CGFloat, rhs: Scalar) -> CGFloat
{
    return lhs * CGFloat(rhs)
}

public func *= <Scalar: CGFloatConvertible> (inout lhs : CGFloat, rhs: Scalar)
{
    lhs *= CGFloat(rhs)
}

public func / <Scalar: CGFloatConvertible> (lhs : CGFloat, rhs: Scalar) -> CGFloat
{
    return lhs / CGFloat(rhs)
}

public func /= <Scalar: CGFloatConvertible> (inout lhs : CGFloat, rhs: Scalar)
{
    lhs /= CGFloat(rhs)
}

