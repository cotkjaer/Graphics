//
//  CGSize.swift
//  SilverbackFramework
//
//  Created by Christian Otkjær on 20/04/15.
//  Copyright (c) 2015 Christian Otkjær. All rights reserved.
//

import CoreGraphics
import Arithmetic

// MARK: - TwoDimensional

extension CGSize : TwoDimensional
{
    public init<S1 : CGFloatConvertible, S2 : CGFloatConvertible>(_ width: S1, _ height: S2)
    {
        self.init(width: CGFloat(width), height: CGFloat(height))
    }
    
    public subscript(index: Int) -> CGFloat
        {
        set
        {
            switch index
            {
            case 0:
                width = newValue
                
            case 1:
                height = newValue
                
            default:
                debugPrint("index (\(index)) out of bounds for \(self.dynamicType)")
            }
        }
        get
        {
            switch index
            {
            case 0:
                return width
                
            case 1:
                return height
                
            default:
                debugPrint("index (\(index)) out of bounds for \(self.dynamicType)")
                return 0
            }
        }
    }

}

extension CGSize
{
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

// MARK: - Operators

public func * (size: CGSize, transform: CGAffineTransform) -> CGSize
{
    return CGSizeApplyAffineTransform(size, transform)
}

public func *= (inout size: CGSize, transform: CGAffineTransform)
{
    size = size * transform
}


