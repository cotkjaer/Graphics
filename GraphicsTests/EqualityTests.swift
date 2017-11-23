//
//  GeometryTests.swift
//  GeometryTests
//
//  Created by Christian Otkjær on 18/02/16.
//  Copyright © 2016 Christian Otkjær. All rights reserved.
//

import XCTest
@testable import Graphics
import Fuzzy

class GeometryTests: XCTestCase
{
    func test_CGFloat_epsilon()
    {
        XCTAssertGreaterThan(CGFloat.ulpOfOne, 0)
        
        let one = CGFloat(1)
        
        XCTAssertGreaterThan(one + CGFloat.ulpOfOne, one)
        XCTAssert(one + CGFloat.ulpOfOne * 0.5 == one)
    }
    
    func test_Equal()
    {
        let v = CGVector(1,2)
        
        XCTAssertEqual(v, v)
        
        XCTAssertNotEqual(v, -v)
        
        let p = CGPoint(-1,2)

        XCTAssertEqual(p, p)
        
        XCTAssertNotEqual(p, -p)

        let almostP = CGPoint(-1.001, 1.999)
        
        XCTAssert(p.equals(almostP, within: CGFloat(0.002)))
        
        XCTAssert(p ≈≈ p)
        XCTAssert(p !≈ almostP)
        XCTAssertFalse(p ≈≈ almostP)
    }
}
