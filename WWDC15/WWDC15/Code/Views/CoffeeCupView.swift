//
//  CoffeeCupView.swift
//  WWDC15
//
//  Created by Michal Smialko on 25/04/15.
//  Copyright (c) 2015 Michal Smialko. All rights reserved.
//

import UIKit

class CoffeeCupView: UIView {

    var bezierPaths = [UIBezierPath]()
    var layers = [CAShapeLayer]()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.initialize()
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.initialize()
        
        self.startAnimation()
    }
    
    func startAnimation() {
        var last = self.layers.count - 1
        for i in 0...last {
            let delay = CGFloat(i) * 0.5
            NSTimer.scheduledTimerWithTimeInterval(NSTimeInterval(delay),
                target: self,
                selector: Selector("animateLayer:"),
                userInfo: ["index" : i],
                repeats: false)
        }
    }
    
    func animateLayer(timer: NSTimer)
    {
        let index = timer.userInfo!["index"] as! NSInteger
        let layer = self.layers[index]
        
        let drawAnimation = CABasicAnimation(keyPath: "strokeEnd")
        drawAnimation.duration = 0.8
        drawAnimation.fromValue = 0
        drawAnimation.toValue = 1
        layer.strokeEnd = 1
        layer.addAnimation(drawAnimation, forKey: "strokeEnd")
        
        let clear = UIColor.clearColor()
        let white = UIColor.whiteColor()
        let black = UIColor(red: 0.2, green: 0.2, blue: 0.2, alpha: 1)
        let yellow = UIColor(red: 1, green: 165/255, blue: 0, alpha: 1)
        let red = UIColor(red: 1, green: 85/255, blue: 52/255, alpha: 1)
        let pink = UIColor(red: 254/255, green: 74/255, blue: 101/255, alpha: 1)
        let fillColors = [red, pink, yellow, yellow, black, yellow, clear, clear, clear]
        
        let fillAnimation = CABasicAnimation(keyPath: "fillColor")
        fillAnimation.duration = 0.8
        fillAnimation.fromValue = UIColor.clearColor().CGColor
        fillAnimation.toValue = fillColors[index].CGColor
        layer.fillColor = fillColors[index].CGColor
        layer.addAnimation(fillAnimation, forKey: "fillColor")
    }
    
    
    func initialize() {

        
        //// Color Declarations
        let color = UIColor(red: 0.855, green: 0.037, blue: 0.037, alpha: 1.000)
        let color2 = UIColor(red: 0.375, green: 0.718, blue: 0.657, alpha: 1.000)
        let color3 = UIColor(red: 0.645, green: 0.613, blue: 0.613, alpha: 1.000)
        let color4 = UIColor(red: 0.819, green: 0.735, blue: 0.735, alpha: 1.000)
        
        //// Bezier Drawing
        var bezierPath = UIBezierPath()
        bezierPath.moveToPoint(CGPointMake(52.5, 53.5))
        bezierPath.addCurveToPoint(CGPointMake(38.5, 68.5), controlPoint1: CGPointMake(38.5, 62.5), controlPoint2: CGPointMake(38.5, 60.5))
        bezierPath.addCurveToPoint(CGPointMake(75.5, 88.5), controlPoint1: CGPointMake(38.5, 76.5), controlPoint2: CGPointMake(50.5, 87.5))
        bezierPath.addCurveToPoint(CGPointMake(118.5, 72.5), controlPoint1: CGPointMake(100.5, 89.5), controlPoint2: CGPointMake(112, 81.25))
        bezierPath.addCurveToPoint(CGPointMake(101.5, 53.5), controlPoint1: CGPointMake(125, 63.75), controlPoint2: CGPointMake(105.5, 54.5))
        bezierPath.addCurveToPoint(CGPointMake(52.5, 53.5), controlPoint1: CGPointMake(97.5, 52.5), controlPoint2: CGPointMake(66.5, 44.5))
        bezierPath.closePath()
        bezierPath.lineWidth = 1
        
        
        //// Bezier 2 Drawing
        var bezier2Path = UIBezierPath()
        bezier2Path.moveToPoint(CGPointMake(54.5, 57.5))
        bezier2Path.addCurveToPoint(CGPointMake(45.5, 68.5), controlPoint1: CGPointMake(42.5, 64.5), controlPoint2: CGPointMake(45.5, 65.5))
        bezier2Path.addCurveToPoint(CGPointMake(77.5, 84.5), controlPoint1: CGPointMake(45.5, 71.5), controlPoint2: CGPointMake(50.5, 84.5))
        bezier2Path.addCurveToPoint(CGPointMake(110.5, 71.5), controlPoint1: CGPointMake(104.5, 84.5), controlPoint2: CGPointMake(107.5, 78.5))
        bezier2Path.addCurveToPoint(CGPointMake(98.5, 57.5), controlPoint1: CGPointMake(113.5, 64.5), controlPoint2: CGPointMake(110.5, 62.5))
        bezier2Path.addCurveToPoint(CGPointMake(54.5, 57.5), controlPoint1: CGPointMake(86.5, 52.5), controlPoint2: CGPointMake(66.5, 50.5))
        bezier2Path.closePath()
        bezier2Path.lineWidth = 1
        
        
        //// Bezier 3 Drawing
        var bezier3Path = UIBezierPath()
        bezier3Path.moveToPoint(CGPointMake(60.5, 64.5))
        bezier3Path.addLineToPoint(CGPointMake(60.5, 68.5))
        bezier3Path.addCurveToPoint(CGPointMake(75.5, 73.5), controlPoint1: CGPointMake(60.5, 68.5), controlPoint2: CGPointMake(70.5, 73.5))
        bezier3Path.addCurveToPoint(CGPointMake(91.5, 70.5), controlPoint1: CGPointMake(80.5, 73.5), controlPoint2: CGPointMake(91.5, 70.5))
        bezier3Path.addLineToPoint(CGPointMake(91.5, 64.5))
        bezier3Path.addCurveToPoint(CGPointMake(75.5, 70.5), controlPoint1: CGPointMake(91.5, 64.5), controlPoint2: CGPointMake(83.25, 70.5))
        bezier3Path.addCurveToPoint(CGPointMake(60.5, 64.5), controlPoint1: CGPointMake(67.75, 70.5), controlPoint2: CGPointMake(60.5, 64.5))
        bezier3Path.closePath()
        bezier3Path.lineWidth = 1
        
    
        //// Bezier 4 Drawing
        var bezier4Path = UIBezierPath()
        bezier4Path.moveToPoint(CGPointMake(49.5, 35.5))
        bezier4Path.addCurveToPoint(CGPointMake(49.5, 47.5), controlPoint1: CGPointMake(49.5, 35.5), controlPoint2: CGPointMake(48.5, 43.5))
        bezier4Path.addCurveToPoint(CGPointMake(75.5, 70.5), controlPoint1: CGPointMake(50.5, 51.5), controlPoint2: CGPointMake(62.25, 71))
        bezier4Path.addCurveToPoint(CGPointMake(102.5, 45.5), controlPoint1: CGPointMake(88.75, 70), controlPoint2: CGPointMake(101.5, 52.5))
        bezier4Path.addCurveToPoint(CGPointMake(102.5, 35.5), controlPoint1: CGPointMake(103.5, 38.5), controlPoint2: CGPointMake(102.5, 35.5))
        bezier4Path.addCurveToPoint(CGPointMake(75.5, 45.5), controlPoint1: CGPointMake(102.5, 35.5), controlPoint2: CGPointMake(100.5, 46.5))
        bezier4Path.addCurveToPoint(CGPointMake(49.5, 35.5), controlPoint1: CGPointMake(50.5, 44.5), controlPoint2: CGPointMake(49.5, 35.5))
        bezier4Path.closePath()
        bezier4Path.lineWidth = 1
        
        
        //// Bezier 5 Drawing
        var bezier5Path = UIBezierPath()
        bezier5Path.moveToPoint(CGPointMake(103.5, 34.5))
        bezier5Path.addCurveToPoint(CGPointMake(75.5, 23.5), controlPoint1: CGPointMake(103.5, 29.25), controlPoint2: CGPointMake(89, 23.5))
        bezier5Path.addCurveToPoint(CGPointMake(49.5, 34.5), controlPoint1: CGPointMake(62, 23.5), controlPoint2: CGPointMake(49.5, 29.25))
        bezier5Path.addCurveToPoint(CGPointMake(75.5, 44.5), controlPoint1: CGPointMake(49.5, 39.75), controlPoint2: CGPointMake(70.5, 44.5))
        bezier5Path.addCurveToPoint(CGPointMake(103.5, 34.5), controlPoint1: CGPointMake(80.5, 44.5), controlPoint2: CGPointMake(103.5, 39.75))
        bezier5Path.closePath()
        bezier5Path.lineWidth = 1
        
        
        //// Bezier 6 Drawing
        var bezier6Path = UIBezierPath()
        bezier6Path.moveToPoint(CGPointMake(92.5, 63.5))
        bezier6Path.addCurveToPoint(CGPointMake(116.5, 47.5), controlPoint1: CGPointMake(92.5, 63.5), controlPoint2: CGPointMake(115.5, 52.5))
        bezier6Path.addCurveToPoint(CGPointMake(116.5, 35.5), controlPoint1: CGPointMake(117.5, 42.5), controlPoint2: CGPointMake(118.5, 37.5))
        bezier6Path.addCurveToPoint(CGPointMake(103.5, 37.5), controlPoint1: CGPointMake(114.5, 33.5), controlPoint2: CGPointMake(103.5, 37.5))
        bezier6Path.addLineToPoint(CGPointMake(103.5, 33.5))
        bezier6Path.addLineToPoint(CGPointMake(114.5, 31.5))
        bezier6Path.addCurveToPoint(CGPointMake(120.5, 35.5), controlPoint1: CGPointMake(114.5, 31.5), controlPoint2: CGPointMake(119, 31.5))
        bezier6Path.addCurveToPoint(CGPointMake(120.5, 47.5), controlPoint1: CGPointMake(122, 39.5), controlPoint2: CGPointMake(121.5, 42.25))
        bezier6Path.addCurveToPoint(CGPointMake(116.5, 56.5), controlPoint1: CGPointMake(119.5, 52.75), controlPoint2: CGPointMake(118.5, 55.5))
        bezier6Path.addCurveToPoint(CGPointMake(92.5, 68.5), controlPoint1: CGPointMake(114.5, 57.5), controlPoint2: CGPointMake(92.5, 68.5))
        bezier6Path.addLineToPoint(CGPointMake(92.5, 63.5))
        bezier6Path.closePath()
        bezier6Path.lineWidth = 1
        
        
        //// Bezier 7 Drawing
        var bezier7Path = UIBezierPath()
        bezier7Path.moveToPoint(CGPointMake(70.5, 33.5))
        bezier7Path.addCurveToPoint(CGPointMake(66.5, 27.5), controlPoint1: CGPointMake(70.5, 33.5), controlPoint2: CGPointMake(66.5, 30))
        bezier7Path.addCurveToPoint(CGPointMake(70.5, 23.5), controlPoint1: CGPointMake(66.5, 25), controlPoint2: CGPointMake(70.5, 25.75))
        bezier7Path.addCurveToPoint(CGPointMake(66.5, 18.5), controlPoint1: CGPointMake(70.5, 21.25), controlPoint2: CGPointMake(66.5, 22))
        bezier7Path.addCurveToPoint(CGPointMake(70.5, 9.5), controlPoint1: CGPointMake(66.5, 15), controlPoint2: CGPointMake(71, 13.25))
        bezier7Path.addCurveToPoint(CGPointMake(64.5, 3.5), controlPoint1: CGPointMake(70, 5.75), controlPoint2: CGPointMake(65, 5.75))
        bezier7Path.addCurveToPoint(CGPointMake(68.5, 0.5), controlPoint1: CGPointMake(64, 1.25), controlPoint2: CGPointMake(67.5, 1.25))
        bezier7Path.lineWidth = 1
        
        
        //// Bezier 8 Drawing
        var bezier8Path = UIBezierPath()
        bezier8Path.moveToPoint(CGPointMake(72.5, 37.5))
        bezier8Path.addCurveToPoint(CGPointMake(76.5, 31.5), controlPoint1: CGPointMake(72.5, 37.5), controlPoint2: CGPointMake(75.5, 34.5))
        bezier8Path.addCurveToPoint(CGPointMake(72.5, 27.5), controlPoint1: CGPointMake(77.5, 28.5), controlPoint2: CGPointMake(73.5, 30.5))
        bezier8Path.addCurveToPoint(CGPointMake(76.5, 15.5), controlPoint1: CGPointMake(71.5, 24.5), controlPoint2: CGPointMake(76.5, 20.5))
        bezier8Path.addCurveToPoint(CGPointMake(72.5, 7.5), controlPoint1: CGPointMake(76.5, 10.5), controlPoint2: CGPointMake(72.5, 10.25))
        bezier8Path.addCurveToPoint(CGPointMake(76.5, 4.5), controlPoint1: CGPointMake(72.5, 4.75), controlPoint2: CGPointMake(75.5, 5.25))
        bezier8Path.lineWidth = 1
        
        
        //// Bezier 9 Drawing
        var bezier9Path = UIBezierPath()
        bezier9Path.moveToPoint(CGPointMake(83.5, 30.5))
        bezier9Path.addCurveToPoint(CGPointMake(79.5, 26.5), controlPoint1: CGPointMake(83.5, 30.5), controlPoint2: CGPointMake(79.5, 28.75))
        bezier9Path.addCurveToPoint(CGPointMake(83.5, 21.5), controlPoint1: CGPointMake(79.5, 24.25), controlPoint2: CGPointMake(83.5, 24))
        bezier9Path.addCurveToPoint(CGPointMake(79.5, 16.5), controlPoint1: CGPointMake(83.5, 19), controlPoint2: CGPointMake(79.5, 18.75))
        bezier9Path.addCurveToPoint(CGPointMake(83.5, 12.5), controlPoint1: CGPointMake(79.5, 14.25), controlPoint2: CGPointMake(82.5, 13.5))
        bezier9Path.addCurveToPoint(CGPointMake(83.5, 12.5), controlPoint1: CGPointMake(84.5, 11.5), controlPoint2: CGPointMake(83.5, 12.5))
        bezier9Path.lineWidth = 1
        

        self.bezierPaths = [bezierPath, bezier2Path, bezier3Path, bezier4Path, bezier5Path, bezier6Path, bezier7Path, bezier8Path, bezier9Path]
        

        
        var i = 0
        let xScale = self.bounds.size.width / 100.0;
        let yScale = self.bounds.size.height / 100.0;
        var transform = CGAffineTransformMakeScale(xScale, yScale)
        transform = CGAffineTransformTranslate(transform, -30, 0)
        for (i; i < 9; i++) {
            let path = self.bezierPaths[i]
            path.lineCapStyle = kCGLineCapRound;
            path.lineJoinStyle = kCGLineJoinBevel;
            path.applyTransform(transform)
            
            let layer = CAShapeLayer()
            layer.path = path.CGPath
            layer.fillColor = UIColor.clearColor().CGColor
            layer.strokeColor = UIColor.blackColor().CGColor
            layer.lineWidth = 2
            self.layer.addSublayer(layer)
            
            self.layers.append(layer)
            layer.strokeEnd = 0
        }
    }
    
}
