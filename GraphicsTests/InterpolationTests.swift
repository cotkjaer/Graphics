//
//  InterpolationTests.swift
//  InterpolationTests
//
//  Created by Christian Otkjær on 20/02/16.
//  Copyright © 2016 Christian Otkjær. All rights reserved.
//

import XCTest
import Arithmetic
@testable import Graphics

class InterpolationTests: XCTestCase
{
    func test_CGFloat()
    {
        let f1 = CGFloat(1)
        let f2 = CGFloat(2)
        
        XCTAssertEqual((f1, f2) ◊ 0.5, 1.5)
    }
    
    func test_CGPoint()
    {
        let p1 = CGPointZero
        let p2 = CGPoint(x: 1, y: 10)
        
        XCTAssertEqual((p1, p2) ◊ 0.5, CGPoint(x: 0.5, y: 5))
    }

    func test_CGSize()
    {
        let s1 = CGSize()
        let s2 = CGSize(width: 1, height: 10)
        
        XCTAssertEqual((s1, s2) ◊ 0.6, CGSize(width: 0.6, height: 6))
    }

    func test_CGRect()
    {
        let p1 = CGRectZero
        let p2 = CGRect(origin:CGPoint(x: 1, y: 10), size: CGSize(width: 1, height: 10))
        
        XCTAssertEqual((p1, p2) ◊ 0.9, CGRect(origin: CGPoint(x: 0.9, y: 9), size: CGSize(width: 0.9, height: 9)))
    }

    func test_CGVector()
    {
        let p1 = CGVector.zero
        let p2 = CGVector(dx: 1, dy: 10)
        
        XCTAssertEqual((p1, p2) ◊ 0.1, CGVector(dx: 0.1, dy: 1))
    }
}
