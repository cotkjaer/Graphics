//
//  CGColorTests.swift
//  Graphics
//
//  Created by Christian Otkjær on 28/09/16.
//  Copyright © 2016 Christian Otkjær. All rights reserved.
//

import XCTest

class CGColorTests: XCTestCase
{
    func test_black()
    {
        XCTAssertEqual(CGColor.black, CGColor.black)
        XCTAssertEqual(CGColor.black.alpha, 1)
    }

    func test_white()
    {
        XCTAssertEqual(CGColor.white, CGColor.white)
        XCTAssertEqual(CGColor.white.alpha, 1)
    }

    func test_clear()
    {
        XCTAssertEqual(CGColor.clear, CGColor.clear)
        XCTAssertEqual(CGColor.clear.alpha, 0)
    }
    
    func test_with_alpha()
    {
        let c1 = CGColor.orange
        XCTAssertEqual(c1, c1)
        XCTAssertEqual(c1.alpha, 1)
        
        let c2 = c1.with(alpha: 0.3)
        XCTAssertEqual(c2, c2)
        XCTAssertEqual(c2.alpha, 0.3)

        XCTAssertNotEqual(c1, c2)

        let c3 = c2.with(alpha: 0.99)
        XCTAssertEqual(c3, c3)
        XCTAssertEqual(c3.alpha, 0.99)

        XCTAssertNotEqual(c1, c3)
        XCTAssertNotEqual(c2, c3)
        
        let c4 = c3.with(alpha: 1)
        
        XCTAssertEqual(c4, c4)
        XCTAssertEqual(c4.alpha, 1)
        
        XCTAssertEqual(c1, c4)
    }
    
}
