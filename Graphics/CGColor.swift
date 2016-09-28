//
//  CGColor.swift
//  Silverback
//
//  Created by Christian Otkjær on 14/12/15.
//  Copyright © 2015 Christian Otkjær. All rights reserved.
//


import CoreGraphics

import UIKit

//MARK: - UIColor

extension CGColor
{
    public var uiColor : UIColor { return UIColor(cgColor: self) }
}

// MARK: - CustomStringConvertible, CustomDebugStringConvertible

extension CGColor: CustomStringConvertible, CustomDebugStringConvertible
{
    public var description: String { return CFCopyDescription(self) as String }
    public var debugDescription: String { return CFCopyDescription(self) as String }
}

// MARK: - Alpha

public extension CGColor
{
    public var alpha: CGFloat { return self.alpha }
    
    public func withAlpha(_ alpha: CGFloat) -> CGColor
    {
        return self.copy(alpha: alpha)!
    }
}

public extension CGColor
{
    class func color(colorSpace: CGColorSpace, components: [CGFloat]) -> CGColor
    {
        return components.withUnsafeBufferPointer
        {
            (buffer: UnsafeBufferPointer<CGFloat>) -> CGColor! in
            return CGColor(colorSpace: colorSpace, components: buffer.baseAddress!)
        }
    }
    
    class func color(red: CGFloat, green: CGFloat, blue: CGFloat, alpha: CGFloat = 1.0) -> CGColor
    {
        return UIColor(red: red, green: green, blue: blue, alpha: alpha).cgColor
    }
    
    class func color(white: CGFloat, alpha: CGFloat = 1.0) -> CGColor
    {
        return UIColor(white: white, alpha: alpha).cgColor
    }
    
    class func color(hue: CGFloat, saturation: CGFloat, brightness: CGFloat, alpha: CGFloat) -> CGColor
    {
        return UIColor(hue: hue, saturation: saturation, brightness: brightness, alpha: alpha).cgColor
    }
}

public extension CGColor
{
    var colorSpace: CGColorSpace { return self.colorSpace }
    
    public static let Black = UIColor.black.cgColor
    
    public class func blackColor() -> CGColor { return UIColor.black.cgColor }
    public class func darkGrayColor() -> CGColor { return UIColor.darkGray.cgColor }
    public class func lightGrayColor() -> CGColor { return UIColor.lightGray.cgColor }
    public class func whiteColor() -> CGColor { return UIColor.white.cgColor }
    public class func grayColor() -> CGColor { return UIColor.gray.cgColor }
    public class func redColor() -> CGColor { return UIColor.red.cgColor }
    public class func greenColor() -> CGColor { return UIColor.green.cgColor }
    public class func blueColor() -> CGColor { return UIColor.blue.cgColor }
    public class func cyanColor() -> CGColor { return UIColor.cyan.cgColor }
    public class func yellowColor() -> CGColor { return UIColor.yellow.cgColor }
    public class func orangeColor() -> CGColor { return UIColor.orange.cgColor }
    public class func purpleColor() -> CGColor { return UIColor.purple.cgColor }
    public class func brownColor() -> CGColor { return UIColor.brown.cgColor }
    public class func clearColor() -> CGColor { return UIColor.clear.cgColor }
}
