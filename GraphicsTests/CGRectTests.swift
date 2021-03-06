//
//  CGRectTests.swift
//  Graphics
//
//  Created by Christian Otkjær on 23/11/16.
//  Copyright © 2016 Christian Otkjær. All rights reserved.
//

import XCTest
@testable import Graphics

class CGRectTests: XCTestCase
{
    let p1 = CGPoint(x: 1, y: 1)
    let p2 = CGPoint(x: 6, y: 6)
    
    let s1 = CGSize(10,10)
    let s2 = CGSize(1,100)
    
    func test_center()
    {
        XCTAssertEqual(CGRect.zero.center, CGPoint.zero)
        XCTAssertEqual(CGRect(center: p1, size: .zero).center, p1)
        XCTAssertEqual(CGRect(center: p1, size: s1).center, p1)
        XCTAssertEqual(CGRect(origin: p2, size: s2).center, CGPoint(x: 6.5, y: 56))
    }
    
    func test_corners()
    {
        let r = CGRect(x: 10, y: -2, width: 10, height: 1)
        
        XCTAssertEqual(r.corners.count, 4)
        XCTAssertEqual(r.corners[0], r.origin)
        XCTAssertEqual(r.corners[1], CGPoint(x: 20, y: -2))
        XCTAssertEqual(r.corners[2], CGPoint(x: 20, y: -1))
        XCTAssertEqual(r.corners[3], CGPoint(x: 10, y: -1))
        
        XCTAssertEqual(CGRect.null.corners.count, 4)
    }
    
    func test_innerSquare()
    {
        XCTAssertEqual(CGRect.zero.innerSquare, .zero)
        XCTAssertEqual(CGRect(origin: .zero, size: s1).innerSquare, CGRect(origin: .zero, size: s1))
        XCTAssertEqual(CGRect(center: p2, size: s2).innerSquare, CGRect(center: p2, size: CGSize(side: 1)))
    }
}
