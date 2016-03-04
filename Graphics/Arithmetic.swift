//
//  Arithmetic.swift
//  Graphics
//
//  Created by Christian Otkjær on 04/03/16.
//  Copyright © 2016 Christian Otkjær. All rights reserved.
//

import Arithmetic

public protocol TwoDimensional: Zeroable, Addable, Subtractable, Multipliable, Dividable, Roundable, FuzzyEquatable, Equatable, CollectionType
{
    init<T: TwoDimensional>(_ other: T)

    init<S1: CGFloatConvertible>(_ : S1)
    
    init<S1: CGFloatConvertible, S2: CGFloatConvertible>(_: S1, _: S2)
    
    subscript(_: Int) -> CGFloat { get set }
    
    var norm : CGFloat { get }
    
    var minimum : CGFloat { get }
    
    var maximum : CGFloat { get }
}

// MARK: - Default

extension TwoDimensional
{
    public static var zero : Self { return Self(0) }

    public init<S : CGFloatConvertible>(_ both: S)
    {
        self.init(both, both)
    }
    
    public init<T: TwoDimensional>(_ other: T)
    {
        self.init(other[0], other[1])
    }
    
    public var norm : CGFloat { return sqrt(pow(self[0], 2) + pow (self[1] , 2))}
    
    public var minimum : CGFloat { return min(self[0], self[2]) }
    
    public var maximum : CGFloat { return max(self[0], self[2]) }
}

// MARK: - Addable

public prefix func + <TwoD: TwoDimensional>(twoD: TwoD) -> TwoD
{
    return twoD
}

public func + <T1: TwoDimensional, T2: TwoDimensional>(lhs: T1, rhs: T2) -> T1
{
    return T1(lhs[0] + rhs[0], lhs[1] + rhs[1])
}

public func += <T1: TwoDimensional, T2: TwoDimensional>(inout lhs: T1, rhs: T2)
{
    lhs = lhs + rhs
}

// MARK: - Subtractable

public prefix func - <TwoD: TwoDimensional>(twoD: TwoD) -> TwoD
{
    return TwoD(-twoD[0], -twoD[1])
}

public func - <T1: TwoDimensional, T2: TwoDimensional>(lhs: T1, rhs: T2) -> T1
{
    return T1(lhs[0] - rhs[0], lhs[1] - rhs[1])
}

public func -= <T1: TwoDimensional, T2: TwoDimensional>(inout lhs: T1, rhs: T2)
{
    lhs = lhs - rhs
}

// MARK: - Multipliable

public func * <T1: TwoDimensional, T2: TwoDimensional>(lhs: T1, rhs: T2) -> T1
{
    return T1(lhs[0] * rhs[0], lhs[1] * rhs[1])
}

public func * <T: TwoDimensional, S: CGFloatConvertible>(lhs: T, rhs: S) -> T
{
    return T(lhs[0] * rhs, lhs[1] * rhs)
}

public func *= <T1: TwoDimensional, T2: TwoDimensional>(inout lhs: T1, rhs: T2)
{
    lhs = lhs * rhs
}

public func *= <T: TwoDimensional, S: CGFloatConvertible>(inout lhs: T, rhs: S)
{
    lhs = lhs * rhs
}

// MARK: - Dividable

public func / <T1: TwoDimensional, T2: TwoDimensional>(lhs: T1, rhs: T2) -> T1
{
    return T1(lhs[0] / rhs[0], lhs[1] / rhs[1])
}

public func / <T: TwoDimensional, S: CGFloatConvertible>(lhs: T, rhs: S) -> T
{
    return T(lhs[0] / rhs, lhs[1] / rhs)
}

public func /= <T1: TwoDimensional, T2: TwoDimensional>(inout lhs: T1, rhs: T2)
{
    lhs = lhs / rhs
}

public func /= <T: TwoDimensional, S: CGFloatConvertible>(inout lhs: T, rhs: S)
{
    lhs = lhs / rhs
}

// MARK: - Roundable

extension TwoDimensional
{
    /**
     Round `self` to arbitrary whole multiplica of `point`
     
     - parameter number: the number to use in rounding
     */
    public func rounded(toNearest toNearest: Self) -> Self
    {
        return Self(self[0].rounded(toNearest: toNearest[0]), self[1].rounded(toNearest: toNearest[1]))
    }
    
    /// Largest integral value not greater than `self`
    public var floor : Self { return Self(self[0].floor, self[1].floor) }
    
    /// Smallest integral value not less than `self`
    public var ceil : Self { return Self(self[0].ceil, self[1].ceil) }
    
    /// Nearest integral value, eaqual to, less than, or greater than `self`
    public var round : Self { return Self(self[0].round, self[0].round) }
}

// MARK: - ceil

public func ceil<T: TwoDimensional>(t: T) -> T
{
    return T(t[0].ceil, t[1].ceil)
}

// MARK: - floor

public func floor<T: TwoDimensional>(t: T) -> T
{
    return T(t[0].floor, t[1].floor)
}

//MARK: - Round

public func round<T: TwoDimensional>(t: T, toDecimals: Int = 0) -> T
{
    return T(round(t[0], toDecimals: toDecimals), round(t[1], toDecimals: toDecimals))
}

// MARK: - LERP

/// Basic linear interpolation of two TwoDimensionals
public func ◊ <T: TwoDimensional, S: CGFloatConvertible> (ab: (T, T), t: S) -> T
{
    return ab.0 * (1 - t) + ab.1 * t
}

// MARK: - Dot

/// this is U+22C5 not U+00B7 (middle dot)
infix operator ⋅ { associativity left precedence 160 }

public func ⋅ <T1: TwoDimensional, T2: TwoDimensional>(lhs: T1, rhs: T2) -> CGFloat
{
    return lhs[0] * rhs[0] + lhs[1] * rhs[1]
}

public func dot <T1: TwoDimensional, T2: TwoDimensional>(lhs: T1, _ rhs: T2) -> CGFloat
{
    return lhs ⋅ rhs
}

// MARK: - Cross

infix operator × { associativity left precedence 160 }

public func × <T1: TwoDimensional, T2: TwoDimensional>(lhs: T1, rhs: T2) -> CGFloat
{
    return lhs[0] * rhs[1] - lhs[1] * rhs[0]
}

public func cross <T1: TwoDimensional, T2: TwoDimensional>(lhs: T1, _ rhs: T2) -> CGFloat
{
    return lhs × rhs
}

// MARK: - Map

extension TwoDimensional
{
    // MARK: map
    
    func map<Scalar: CGFloatConvertible>(transform: CGFloat -> Scalar) -> Self
    {
        return Self(transform(self[0]), transform(self[1]))
    }
}

// MARK: - Fuzzy

extension TwoDimensional
{
    public func equalTo(other: Self, within precision: Self) -> Bool
    {
        return (self - other).norm < precision.norm
    }
}

public func ≈≈ <T: TwoDimensional>(lhs: T, rhs: T) -> Bool { return lhs[0] ≈≈ rhs[0] && lhs[1] ≈≈ rhs[1] }


// MARK: - CollectionType

extension TwoDimensional
{
    public var startIndex: Int { return 0 }
    public var endIndex: Int { return 2 }
}