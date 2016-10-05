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
    public func with(alpha: CGFloat) -> CGColor
    {
        guard let c = copy(alpha: alpha) else { return CGColor.clear }
        
        return c
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
    
    public static let black = UIColor.black.cgColor
    public static let white = UIColor.white.cgColor
    public static let clear = UIColor.clear.cgColor

    public static let darkGray = UIColor.darkGray.cgColor
    public static let lightGray = UIColor.lightGray.cgColor
    public static let gray = UIColor.gray.cgColor
    public static let red = UIColor.red.cgColor
    public static let green = UIColor.green.cgColor
    public static let blue = UIColor.blue.cgColor
    public static let cyan = UIColor.cyan.cgColor
    public static let yellow = UIColor.yellow.cgColor
    public static let orange = UIColor.orange.cgColor
    public static let purple = UIColor.purple.cgColor
    public static let brown = UIColor.brown.cgColor
}
