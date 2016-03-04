//
//  TestCollection.swift
//  Graphics
//
//  Created by Christian Otkjær on 04/03/16.
//  Copyright © 2016 Christian Otkjær. All rights reserved.
//

import XCTest
@testable import Graphics

class TestCollection: XCTestCase
{
    func test_for()
    {
        let s = CGSize(0, 10)
        
        for (i, f) in s.enumerate()
        {
            XCTAssertEqual(Int(f), i * 10)
        }
    }
    
    func test_subscript()
    {
        let v = CGVector(23, -1002)
        
        XCTAssertEqual(v[-1], 0)
        XCTAssertEqual(v[0], 23)
        XCTAssertEqual(v[1], -1002)
        XCTAssertEqual(v[2], 0)
    }
    
    func test_min_max()
    {
        let p = CGPoint(12, -1)
        
        XCTAssertEqual(p.minElement(), -1)
        XCTAssertEqual(p.minimum, -1)
        XCTAssertEqual(p.maxElement(), 12)
        XCTAssertEqual(p.maximum, 12)
    }
}
