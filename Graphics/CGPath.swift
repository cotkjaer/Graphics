//
//  CGPath.swift
//  Silverback
//
//  Created by Christian Otkjær on 26/11/15.
//  Copyright © 2015 Christian Otkjær. All rights reserved.
//


import UIKit

// MARK: - Contains

extension CGPath
{
    public func contains(point: CGPoint) -> Bool
    {
        return CGPathContainsPoint(self, nil, point, false)
    }
}
