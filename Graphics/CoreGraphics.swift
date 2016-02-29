//
//  Size2D.swift
//  Geometry
//
//  Created by Christian Otkjær on 19/02/16.
//  Copyright © 2016 Christian Otkjær. All rights reserved.
//

import Geometry
/*import Arithmetic

public protocol Size2D : MultiDimensionalValue
{
    var width : Scalar { get set }
    var height : Scalar { get set }
    
    init()
    
    init(width: Scalar, height: Scalar)
}

// MARK: - Default

public extension Size2D
{
    init(width: Scalar, height: Scalar)
    {
        self.init()
        
        self.width = width
        self.height = height
    }
    
    func scaled(factor: Scalar) -> Self
    {
        return Self(width: width * factor, height: height * factor)
    }
}
*/

// MARK: - CGPoint

extension CGPoint : Point2D
{
    public typealias Scalar = CGFloat
}

// MARK: - CGVector
/*
extension CGVector : TwoDimensionalValue
{
    public typealias Scalar = CGFloat
    
    public subscript(index: Int) -> Scalar
        {
        get {
            switch index
            {
            case 0: return dx
            case 1: return dy
            default:
                debugPrint("index \(index) out of bounds for \(self.dynamicType)")
                return Scalar()
            }
        }
        set
        {
            switch index
            {
            case 0: dx = newValue
            case 1: dy = newValue
            default:
                debugPrint("index \(index) out of bounds for \(self.dynamicType)")
                
            }
        }
    }
}

// MARK: - CGSize

extension CGSize : TwoDimensionalValue
{
    public typealias Scalar = CGFloat
    
    public subscript(index: Int) -> Scalar
        {
        get {
            switch index
            {
            case 0: return width
            case 1: return height
            default:
                debugPrint("index \(index) out of bounds for \(self.dynamicType)")
                return Scalar()
            }
        }
        set
        {
            switch index
            {
            case 0: width = newValue
            case 1: height = newValue
            default:
                debugPrint("index \(index) out of bounds for \(self.dynamicType)")

            }
        }
    }
}

// MARK: - CGRect

extension CGRect : MultiDimensionalValue
{
    public var dimensions : Int { return 4 }
    
    public typealias Scalar = CGFloat
    
    public subscript(index: Int) -> Scalar
        {
        get {
            switch index
            {
            case 0: return origin.x
            case 1: return origin.y
            case 2: return width
            case 3: return height
            default:
                debugPrint("index \(index) out of bounds for \(self.dynamicType)")
                return Scalar()
            }
        }
        set
        {
            switch index
            {
            case 0: origin.x = newValue
            case 1: origin.y = newValue
            case 2: size.width = newValue
            case 3: size.height = newValue
            default:
                debugPrint("index \(index) out of bounds for \(self.dynamicType)")
            }
        }
    }
}
*/