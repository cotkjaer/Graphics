//
//  CGSize.swift
//  SilverbackFramework
//
//  Created by Christian Otkjær on 20/04/15.
//  Copyright (c) 2015 Christian Otkjær. All rights reserved.
//

import CoreGraphics
import Arithmetic
import Geometry

//extension CGSize : TwoDimensionalValue
//{
//    public typealias Scalar = CGFloat
//    
//    public subscript(index : Int) -> Scalar
//        {
//        get {
//            switch index
//            {
//            case 0: return width
//            case 1: return height
//            default: fatalError("index out of bounds: \(index)")
//            }
//        }
//        set {
//            switch index
//            {
//            case 0: width = newValue
//            case 1: height = newValue
//            default: fatalError("index out of bounds: \(index)")
//            }
//        }
//    }
//}

extension CGSize
{
    public init(widthAndHeight: CGFloat)
    {
        self.width = widthAndHeight
        self.height = widthAndHeight
    }
    
    // MARK: with
    
    public func with(width width: CGFloat) -> CGSize
    {
        return CGSize(width: width, height: height)
    }
    
    public func with(height height: CGFloat) -> CGSize
    {
        return CGSize(width: width, height: height)
    }
    
    ///Returns *true* if `size` fits inside `self`
    public func fits(size: CGSize) -> Bool
    {
        return width >= size.width && height >= size.height
    }
}

// MARK: - Zeroable

extension CGSize : Zeroable
{
    public static var zero : CGSize { return CGSizeZero }
}

//MARK: - Width and Height

extension CGSize
{
    public var minWidthHeight : CGFloat { return min(width, height) }
    public var maxWidthHeight : CGFloat { return max(width, height) }
}

// MARK: - ceil

public func ceil(size: CGSize) -> CGSize
{
    return CGSize(width: ceil(size.width), height: ceil(size.height))
}

// MARK: - floor

public func floor(size: CGSize) -> CGSize
{
    return CGSize(width: floor(size.width), height: floor(size.height))
}

// MARK: - Operators

// MARK: - Addable

extension CGSize : Addable {}

prefix public func + (size: CGSize) -> CGSize
{
    return size
}

public func + (s1: CGSize, s2: CGSize) -> CGSize
{
    return CGSize(width: s1.width + s2.width, height: s1.height + s2.height)
}

public func += (inout s1: CGSize, s2: CGSize)
{
    s1.width += s2.width
    s1.height += s2.height
}

public func - (s1: CGSize, s2: CGSize) -> CGSize
{
    return CGSize(width: s1.width - s2.width, height: s1.height - s2.height)
}

public func -= (inout s1: CGSize, s2: CGSize)
{
    s1.width -= s2.width
    s1.height -= s2.height
}

public func * (size: CGSize, factor: CGFloat) -> CGSize
{
    return CGSize(width: size.width * factor, height: size.height * factor)
}

public func * (factor: CGFloat, size: CGSize) -> CGSize
{
    return size * factor
}

public func *= (inout size: CGSize, factor: CGFloat)
{
    size.width *= factor
    size.height *= factor
}

public func / (size: CGSize, factor: CGFloat) -> CGSize
{
    return CGSize(width: size.width / factor, height: size.height / factor)
}

public func /= (inout size: CGSize, factor: CGFloat)
{
    size.width /= factor
    size.height /= factor
}

public func * (size: CGSize, transform: CGAffineTransform) -> CGSize
{
    return CGSizeApplyAffineTransform(size, transform)
}

public func *= (inout size: CGSize, transform: CGAffineTransform)
{
    size = size * transform
}

// MARK: - LERP

/// Basic linear interpolation of two CGSize
public func ◊ (ab: (CGSize, CGSize), t: CGFloat) -> CGSize
{
    return ab.0 * (1 - t) + ab.1 * t
}
