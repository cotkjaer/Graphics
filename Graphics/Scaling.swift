//
//  Scaling.swift
//  Silverback
//
//  Created by Christian Otkjær on 14/12/15.
//  Copyright © 2015 Christian Otkjær. All rights reserved.
//

import CoreGraphics

public enum Scaling
{
    case none
    case proportionally
    case toFit
}

public enum Alignment
{
    case center
    case top
    case topLeft
    case topRight
    case left
    case bottom
    case bottomLeft
    case bottomRight
    case right
}

public enum Align
{
    case middle, min, max, custom(CGFloat)
    
    var value: CGFloat
        {
            switch self
            {
            case .max:
                return 1
                
            case .middle:
                return 0.5
                
            case .min:
                return 0
                
            case .custom(let f):
                return f
            }
    }
}

//public struct Align
//{
//    var horizontal: Percent
//    var vertical: Percent
//    
//    public static let Center = Align(horizontal: Percent.Half, vertical: Percent.Half)
//}

public struct Percent
{
    var value: CGFloat
        {
        didSet
        {
            if value > 1 { value = 1 }
            if value < 0 { value = 0 }
        }
    }
    
    public static let Half = Percent(value: 0.5)
    public static let Zero = Percent(value: 0)
    public static let Full = Percent(value: 1)
    
}

//MARK: - Scaling

extension CGRect
{
    public mutating func scaleAndAlign(toRect rect: CGRect, scaling: Scaling, horizontal: Align = Align.middle, vertical: Align = Align.middle)
    {
        self = scaledAndAligned(toRect: rect, scaling: scaling, horizontal: horizontal, vertical: vertical)
    }
    
    public func scaledAndAligned(toRect rect: CGRect, scaling: Scaling, horizontal: Align = Align.middle, vertical: Align = Align.middle) -> CGRect
    {
        var result = CGRect()
        var scaledSize = size
        
        switch scaling
        {
        case .toFit:
            return rect
            
        case .proportionally:

            let theScaleFactor = min(rect.size.width / size.width, rect.size.height / size.height)

            scaledSize *= theScaleFactor
            
            result.size = scaledSize
            
        case .none:
            result.size.width = scaledSize.width
            result.size.height = scaledSize.height
        }
        
        result.origin.x = rect.origin.x + (rect.size.width - scaledSize.width) * horizontal.value
        result.origin.y = rect.origin.y + (rect.size.height - scaledSize.height) * vertical.value
        
//        
//        switch alignment
//        {
//        case .center:
//            result.origin.x = rect.origin.x + (rect.size.width - scaledSize.width) / 2
//            result.origin.y = rect.origin.y + (rect.size.height - scaledSize.height) / 2
//            
//        case .top:
//            result.origin.x = rect.origin.x + (rect.size.width - scaledSize.width) / 2
//            result.origin.y = rect.origin.y + rect.size.height - scaledSize.height
//            
//        case .topLeft:
//            result.origin.x = rect.origin.x
//            result.origin.y = rect.origin.y + rect.size.height - scaledSize.height
//            
//        case .topRight:
//            result.origin.x = rect.origin.x + rect.size.width - scaledSize.width
//            result.origin.y = rect.origin.y + rect.size.height - scaledSize.height
//            
//        case .left:
//            result.origin.x = rect.origin.x
//            result.origin.y = rect.origin.y + (rect.size.height - scaledSize.height) / 2
//            
//        case .bottom:
//            result.origin.x = rect.origin.x + (rect.size.width - scaledSize.width) / 2
//            result.origin.y = rect.origin.y
//            
//        case .bottomLeft:
//            result.origin.x = rect.origin.x
//            result.origin.y = rect.origin.y
//            
//        case .bottomRight:
//            result.origin.x = rect.origin.x + rect.size.width - scaledSize.width
//            result.origin.y = rect.origin.y
//            
//        case .right:
//            result.origin.x = rect.origin.x + rect.size.width - scaledSize.width
//            result.origin.y = rect.origin.y + (rect.size.height - scaledSize.height) / 2
//        }
        
        return result
    }
}
