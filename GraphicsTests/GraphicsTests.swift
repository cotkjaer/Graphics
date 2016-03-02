//
//  GraphicsTests.swift
//  GraphicsTests
//
//  Created by Christian Otkjær on 18/02/16.
//  Copyright © 2016 Christian Otkjær. All rights reserved.
//

import XCTest
@testable import Graphics

class GraphicsTests: XCTestCase
{
    func test_CGFloat_pow()
    {
        let f = CGFloat(3)
        
        XCTAssertEqual(f.pow(2), 9)
    }
}
