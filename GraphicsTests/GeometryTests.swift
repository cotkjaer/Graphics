//
//  GeometryTests.swift
//  GeometryTests
//
//  Created by Christian Otkjær on 18/02/16.
//  Copyright © 2016 Christian Otkjær. All rights reserved.
//

import XCTest
//@testable import Geometry
//import Arithmetic

class GeometryTests: XCTestCase
{
    func test_CGFloat_epsilon()
    {
        XCTAssertGreaterThan(CGFloat.epsilon, 0)
        
        let one = CGFloat(1)
        
        XCTAssertGreaterThan(one + CGFloat.epsilon, one)
        XCTAssert(one + CGFloat.epsilon * 0.5 == one)
    }
}
