//
//  UIBezierPath.swift
//  Silverback
//
//  Created by Christian Otkjær on 12/02/16.
//  Copyright © 2016 Christian Otkjær. All rights reserved.
//

import UIKit

//MARK: - Transform

public extension UIBezierPath
{
    func translate(tx tx: CGFloat, ty: CGFloat)
    {
        applyTransform(CGAffineTransformMakeTranslation(tx, ty))
    }
    
    func translated(tx tx: CGFloat, ty: CGFloat) -> UIBezierPath
    {
        let path = self
        
        path.translate(tx: tx, ty: ty)
        
        return path
    }
    
    func translate(v: CGVector)
    {
        translate(tx: v.dx, ty: v.dy)
    }
    
    func translated(v: CGVector) -> UIBezierPath
    {
        return translated(tx: v.dx, ty: v.dy)
    }
    
    func rotate(angle: CGFloat)
    {
        applyTransform(CGAffineTransformMakeRotation(angle))
    }
    
    func rotated(angle: CGFloat) -> UIBezierPath
    {
        let path = self
        
        path.rotate(angle)
        
        return path
    }
    
    func scale(sx sx: CGFloat, sy: CGFloat)
    {
        applyTransform(CGAffineTransformMakeScale(sx, sy))
    }
    
    func scaled(sx sx: CGFloat, sy: CGFloat) -> UIBezierPath
    {
        let path = self
        
        path.scale(sx: sx, sy: sy)
        
        return path
    }
}

