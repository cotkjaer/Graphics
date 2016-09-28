//
//  Connection.swift
//  Graphics
//
//  Created by Christian Otkjær on 18/02/16.
//  Copyright © 2016 Christian Otkjær. All rights reserved.
//


public enum ConnectionEndpoint
{
    case none, innerEllipse //, OuterEllipse, Frame, Border
    
    func pathForFrame(_ frame: CGRect?) -> UIBezierPath
    {
        if let f = frame
        {
            switch self
            {
            case .none:
                return UIBezierPath()
            case .innerEllipse:
                return UIBezierPath(ovalIn: f)
            }
        }
        
        return UIBezierPath()
    }
    
    func pointOnRimAtAngle(_ theta: CGFloat?, forFrame frame:CGRect?) -> CGPoint?
    {
        guard let f = frame, let a = theta else { return nil }
        
        switch self
        {
        case .none:
            return f.center
            
        case .innerEllipse:
            return CGPoint(x: cos(a) * f.width / 2, y: sin(a) * f.height / 2) + f.center
        }
    }
}

open class Connection: CAShapeLayer
{
    var location = CGPoint.zero
    
    fileprivate var fromEndpoint = ConnectionEndpoint.none
    fileprivate var toEndpoint = ConnectionEndpoint.none
    
    required public init?(coder aDecoder: NSCoder)
    {
        super.init(coder: aDecoder)
        
        setup()
    }
    
    override public init()
    {
        super.init()
        
        setup()
    }
    
    func setup()
    {
        fillColor = nil
        fillRule = kCAFillRuleNonZero
        
        lineCap = kCALineCapRound
        lineDashPattern = nil
        lineDashPhase = 0.0
        lineJoin = kCALineJoinRound
        lineWidth = 0.66
        
        miterLimit = lineWidth * 2
        
        strokeColor = UIColor.gray.cgColor
        
        fromEndpoint = .innerEllipse
        toEndpoint = .innerEllipse
    }
    
    public enum ConnectionAnchor
    {
        case
        right,
        left,
        up,
        down,
        none
        
        var opposite : ConnectionAnchor
            {
                switch self
                {
                case .up:
                    return .down
                case .down:
                    return .up
                case .left:
                    return .right
                case .right:
                    return .left
                case .none:
                    return .none
                }
        }
        
        var angle : CGFloat?
            {
                switch self
                {
                case .up:
                    return 3 * CGFloat.π_2
                case .down:
                    return CGFloat.π_2
                case .left:
                    return CGFloat.π
                case .right:
                    return 0
                case .none:
                    return nil
                }
        }
    }
    
    open var fromFrame: CGRect?
        { didSet { if oldValue != fromFrame { updateConnection() } } }
    
    open var toFrame: CGRect?
        { didSet { if oldValue != toFrame { updateConnection() } } }
    
    open var fromAnchor : ConnectionAnchor = .none
        { didSet { if oldValue != fromAnchor { updateConnection() } } }
    
    open var toAnchor : ConnectionAnchor = .none
        { didSet { if oldValue != toAnchor { updateConnection() } } }
    
    open func updateConnection()
    {
        let bezierPath = fromEndpoint.pathForFrame(fromFrame)
        
        if let fromFrame = self.fromFrame, let toFrame = self.toFrame
        {
            var controlPoint1 = CGPoint()
            var controlPoint2 = CGPoint()
            
            var fromPoint = CGPoint()
            var toPoint = CGPoint()
            
            if let point = fromEndpoint.pointOnRimAtAngle(fromAnchor.angle, forFrame:fromFrame)
            {
                fromPoint = point
                bezierPath.move(to: fromPoint)
            }
            
            if let point = toEndpoint.pointOnRimAtAngle(toAnchor.angle, forFrame:toFrame)
            {
                toPoint = point
            }
            
            bezierPath.move(to: fromPoint)
            
            switch toAnchor
            {
            case .up:
                toPoint = toFrame.topCenter
                controlPoint2 = toPoint.with(y: (fromPoint.y + toPoint.y) / 2)
            case .down:
                toPoint = toFrame.bottomCenter
                controlPoint2 = toPoint.with(y: (fromPoint.y + toPoint.y) / 2)
            case .left:
                toPoint = toFrame.centerLeft
                controlPoint2 = toPoint.with(x: (fromPoint.x + toPoint.x) / 2)
            case .right:
                toPoint = toFrame.centerRight
                controlPoint2 = toPoint.with(x: (fromPoint.x + toPoint.x) / 2)
            case .none:
                bezierPath.removeAllPoints()
                path = nil
                return
            }
            
            switch fromAnchor
            {
            case .up:
                controlPoint1 = fromPoint.with(y: (fromPoint.y + toPoint.y) / 2)
            case .down:
                controlPoint1 = fromPoint.with(y: (fromPoint.y + toPoint.y) / 2)
            case .left:
                controlPoint1 = fromPoint.with(x: (fromPoint.x + toPoint.x) / 2)
            case .right:
                controlPoint1 = fromPoint.with(x: (fromPoint.x + toPoint.x) / 2)
            case .none:
                bezierPath.removeAllPoints()
                path = nil
                return
            }
            
            bezierPath.addCurve(to: toPoint, controlPoint1: controlPoint1, controlPoint2: controlPoint2)
            
            bezierPath.append(toEndpoint.pathForFrame(toFrame))
        }
        
        path = bezierPath.cgPath
    }
    
    //MARK: - Animation
    
    open var animatePath : Bool = false
    
    override open func action(forKey event: String) -> CAAction?
    {
        if event == "path" && animatePath
        {
            let animation = CABasicAnimation(keyPath: event)
            animation.duration = CATransaction.animationDuration()
            animation.timingFunction = CATransaction.animationTimingFunction()
            
            return animation
        }
        
        return super.action(forKey: event)
    }
}
