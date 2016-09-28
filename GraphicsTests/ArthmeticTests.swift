//
//  ArthmeticTests.swift
//  Graphics
//
//  Created by Christian Otkjær on 02/08/16.
//  Copyright © 2016 Christian Otkjær. All rights reserved.
//

import XCTest
@testable import Graphics

class ArthmeticTests: XCTestCase
{
    func test_CGPoint()
    {
        let p1 = CGPoint(x: 1, y: 2)
        let p2 = CGPoint(x: -1, y: 2)
        let p3 = CGPoint(x: 0, y: 4)
        
        XCTAssertEqual(p1 + p2, p3)
        
    }
}
