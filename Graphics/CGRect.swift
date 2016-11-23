//
// CGRect.swift
// SilverbackFramework
//
// Created by Christian Otkjær on 20/04/15.
// Copyright (c) 2015 Christian Otkjær. All rights reserved.
//

import UIKit

import Arithmetic

// MARK: - convenience initializers

public extension CGRect
{
    public init(size: CGSize)
    {
        self.init(origin: CGPoint.zero, size: size)
    }
    
    public init(origin: CGPoint)
    {
        self.init(origin: origin, size: CGSize.zero)
    }
}

// MARK: - center

public extension CGRect
{
    public init(center: CGPoint, size: CGSize)
    {
        self.init(x : center.x - size.width / 2, y : center.y - size.height / 2, width: size.width, height: size.height)
    }
    
    var center: CGPoint
        {
        get { return CGPoint(x: centerX, y: centerY) }
        set { centerX = newValue.x; centerY = newValue.y }
    }
    
    // MARK: private center - settable midX and midY
  
    fileprivate var centerX: CGFloat
        {
        get { return x + width * 0.5}
        set { x = newValue - width * 0.5 }
    }
    
    fileprivate var centerY: CGFloat
        {
        get { return y + height * 0.5 }
        set { y = newValue - height * 0.5 }
    }
    
    // MARK: - Centered Square
    
    /// A square that has the same center as this rectangle and side-length = min(width, height)
    public var innerSquare : CGRect
    {
        return CGRect(center: center, size: CGSize(side: min(width, height)))
    }
    
    
    /// Returns a square that either fits inside this rectangle (if `inner` is *true*) or that this rectagle fits into (if `inner` is *false*)
    /// - parameter horizontal: Horizontal Alignment (default is `middle`)
    /// - parameter vertical: Vertical Alignment (default is `middle`)
    /// - parameter inner: flag to determine

    public func squared(horizontal: Align = .middle, vertical: Align = .middle, inner: Bool = true) -> CGRect
    {
        let side = inner ? min(width, height) : max(width, height)
        
        let x = minX + (width - side) * horizontal.value
        let y = minX + (height - side) * vertical.value
        
        let rect = CGRect(origin: CGPoint(x: x, y: y), size: CGSize(side: side))
        
        return rect
    }
}

// MARK: - Shortcuts

public extension CGRect
{
    // MARK:
    
    var x: CGFloat
        {
        get { return origin.x }
        set { origin.x = newValue }
    }
    
    var y: CGFloat
        {
        get { return origin.y }
        set { origin.y = newValue }
    }
}


// MARK: edges

public extension CGRect
{
    var top: CGFloat
        {
        get { return y }
        set { y = newValue }
    }
    
    var left: CGFloat
        {
        get { return origin.x }
        set { origin.x = newValue }
    }
    
    var right: CGFloat
        {
        get { return x + width }
        set { x = newValue - width }
    }
    
    var bottom: CGFloat
        {
        get { return y + height }
        set { y = newValue - height }
    }
    
    // MARK: with
    
    func with(origin: CGPoint) -> CGRect
    {
        return CGRect(origin: origin, size: size)
    }
    
    func with(center: CGPoint) -> CGRect
    {
        return CGRect(center: center, size: size)
    }
    
    func with(x: CGFloat, y: CGFloat) -> CGRect
    {
        return with(origin: CGPoint(x: x, y: y))
    }
    
    func with(x: CGFloat) -> CGRect
    {
        return with(x: x, y: y)
    }
    
    func with(y: CGFloat) -> CGRect
    {
        return with(x: x, y: y)
    }
    
    func with(size: CGSize) -> CGRect
    {
        return CGRect(origin: origin, size: size)
    }
    
    func with(width: CGFloat, height: CGFloat) -> CGRect
    {
        return with(size: CGSize(width: width, height: height))
    }
    
    func with(width: CGFloat) -> CGRect
    {
        return with(width: width, height: height)
    }
    
    func with(height: CGFloat) -> CGRect
    {
        return with(width: width, height: height)
    }
    
    func with(x: CGFloat, width: CGFloat) -> CGRect
    {
        return CGRect(origin: CGPoint(x: x, y: y), size: CGSize(width: width, height: height))
    }
    
    func with(y: CGFloat, height: CGFloat) -> CGRect
    {
        return CGRect(origin: CGPoint(x: x, y: y), size: CGSize(width: width, height: height))
    }
}

// MARK: inset

public extension CGRect
{
    mutating func inset(_ edgeInset: UIEdgeInsets)
    {
        inset(top: edgeInset.top, left: edgeInset.left, bottom: edgeInset.bottom, right: edgeInset.right)
    }
    
    mutating func inset(_ by: CGFloat)
    {
        inset(top: by, left: by, bottom: by, right: by)
    }
    
    mutating func inset(dx: CGFloat)
    {
        inset(top: 0, left: dx, bottom: 0, right: dx)
    }
    
    mutating func inset(dy: CGFloat)
    {
        inset(top: dy, left: 0, bottom: dy, right: 0)
    }
    
    mutating func inset(top: CGFloat = 0, left: CGFloat = 0, bottom: CGFloat = 0, right: CGFloat = 0)
    {
        x = x + left
        y = y + top
        size.width = width - right - left
        size.height = height - top - bottom
    }
    
    mutating func inset<T:CGFloatPair>(topLeft: T)
    {
        inset(top: topLeft[1], left: topLeft[0])
    }
    
    mutating func inset<T:CGFloatPair>(topRight: T)
    {
        inset(top: topRight[1], right: topRight[0])
    }
    
    mutating func inset<T:CGFloatPair>(bottomLeft: T)
    {
        inset(left: bottomLeft[0], bottom: bottomLeft[1])
    }
    
    mutating func inset<T:CGFloatPair>(bottomRight: T)
    {
        inset(bottom: bottomRight[1], right: bottomRight[0])
    }
}

//MARK: - Zero

extension CGRect : Zeroable {}

// MARK: - Edge points

public extension CGRect
{
    var topLeft: CGPoint
        {
        get { return CGPoint(x: left, y: top) }
        set { left = newValue.x; top = newValue.y }
    }
    
    var topCenter: CGPoint
        {
        get { return CGPoint(x: centerX, y: top) }
        set { centerX = newValue.x; top = newValue.y }
    }
    
    var topRight: CGPoint
        {
        get { return CGPoint(x: right, y: top) }
        set { right = newValue.x; top = newValue.y }
    }
    
    var centerLeft: CGPoint
        {
        get { return CGPoint(x: left, y: centerY) }
        set { left = newValue.x; centerY = newValue.y }
    }
    
    var centerRight: CGPoint
        {
        get { return CGPoint(x: right, y: centerY) }
        set { right = newValue.x; centerY = newValue.y }
    }
    
    var bottomLeft: CGPoint
        {
        get { return CGPoint(x: left, y: bottom) }
        set { left = newValue.x; bottom = newValue.y }
    }
    
    var bottomCenter: CGPoint
        {
        get { return CGPoint(x: centerX, y: bottom) }
        set { centerX = newValue.x; bottom = newValue.y }
    }
    
    var bottomRight: CGPoint
        {
        get { return CGPoint(x: right, y: bottom) }
        set { right = newValue.x; bottom = newValue.y }
    }
}

//MARK: - Convert

extension CGRect
{
    public func convert(fromView: UIView? = nil, toView: UIView) -> CGRect
    {
        return toView.convert(self, from: fromView)
    }
}

//MARK: - Width and Height

extension CGRect
{
    public var minWidthHeight : CGFloat { return size.minimum }
    public var maxWidthHeight : CGFloat { return size.maximum }
}

// MARK: - Relative position

public extension CGRect
{
    func isAbove(_ rect:CGRect) -> Bool
    {
        return bottom > rect.top
    }
    
    func isBelow(_ rect:CGRect) -> Bool
    {
        return top > rect.bottom
    }
    
    func isLeftOf(_ rect:CGRect) -> Bool
    {
        return right < rect.left
    }
    
    func isRightOf(_ rect:CGRect) -> Bool
    {
        return left < rect.right
    }
}

// MARK: Operators

public func + (rect: CGRect, point: CGPoint) -> CGRect
{
    return CGRect(origin: rect.origin + point, size: rect.size)
}

public func += (rect: inout CGRect, point: CGPoint)
{
    rect.origin += point
}

public func - (rect: CGRect, point: CGPoint) -> CGRect
{
    return CGRect(origin: rect.origin - point, size: rect.size)
}

public func -= (rect: inout CGRect, point: CGPoint)
{
    rect.origin -= point
}

public func + (rect: CGRect, size: CGSize) -> CGRect
{
    return CGRect(origin: rect.origin, size: rect.size + size)
}

public func += (rect: inout CGRect, size: CGSize)
{
    rect.size += size
}

public func - (rect: CGRect, size: CGSize) -> CGRect
{
    return CGRect(origin: rect.origin, size: rect.size - size)
}

public func -= (rect: inout CGRect, size: CGSize)
{
    rect.size -= size
}

public func * (rect: CGRect, factor: CGFloat) -> CGRect
{
    return CGRect(center: rect.center, size: rect.size * factor)
}

public func * (factor: CGFloat, rect: CGRect) -> CGRect
{
    return rect * factor
}

public func *= (rect: inout CGRect, factor: CGFloat)
{
    rect = rect * factor
}

public func * (rect: CGRect, transform: CGAffineTransform) -> CGRect
{
    return rect.applying(transform)
}

public func *= (rect: inout CGRect, transform: CGAffineTransform)
{
    rect = rect * transform
}

// MARK: - LERP

/// Basic linear interpolation of two points
public func ◊ (ab: (CGRect, CGRect), t: CGFloat) -> CGRect
{
    return CGRect(origin: (ab.0.origin, ab.1.origin) ◊ t, size: (ab.0.size, ab.1.size) ◊ t)
}
