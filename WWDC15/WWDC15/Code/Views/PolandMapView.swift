//
//  PolandMapView.swift
//  WWDC15
//
//  Created by Michal Smialko on 22/04/15.
//  Copyright (c) 2015 Michal Smialko. All rights reserved.
//

import UIKit

class PolandMapView: UIView {

    let polandMapPath = UIBezierPath()
    let arrowPath = UIBezierPath()
    
    let mapShapeLayer = CAShapeLayer()
    let arrowLayer = CAShapeLayer()
    
    let countryLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.initialize()
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.initialize()
    }
    
    func startAnimation() {
        self.arrowLayer.hidden = false
        self.mapShapeLayer.hidden = false
        
        let drawAnimation = CABasicAnimation(keyPath: "strokeEnd")
        drawAnimation.duration = 2.5
        drawAnimation.fromValue = 0
        drawAnimation.toValue = 1
        self.mapShapeLayer.addAnimation(drawAnimation, forKey: "strokeEnd")
        
        let widthAnimation = CABasicAnimation(keyPath: "lineWidth")
        widthAnimation.duration = 2.5
        widthAnimation.fromValue = 6
        widthAnimation.toValue = 1
        self.mapShapeLayer.addAnimation(widthAnimation, forKey: "lineWidth")
        
        let drawArrowAnimation = CAKeyframeAnimation(keyPath: "strokeEnd")
        drawArrowAnimation.keyTimes = [0,0.8,1]
        drawArrowAnimation.values = [0, 0.0001, 1]
        drawArrowAnimation.duration = 2.7
        self.arrowLayer.addAnimation(drawArrowAnimation, forKey: "strokeEnd")
        
        self.countryLabel.transform = CGAffineTransformScale(CGAffineTransformIdentity, 0.8, 0.8)
        self.countryLabel.transform = CGAffineTransformTranslate(self.countryLabel.transform, 0, 50)
        UIView.animateWithDuration(2,
            delay: 1,
            options: UIViewAnimationOptions.CurveLinear,
            animations:
            { () -> Void in
            self.countryLabel.alpha = 1
            self.countryLabel.transform = CGAffineTransformIdentity
        }, completion: nil)
    }
    
    // MARK: PolandMapView
    
    func initialize() {
        //// Bezier 2 Drawing
        self.polandMapPath.moveToPoint(CGPointMake(75.5, 49.5))
        self.polandMapPath.addCurveToPoint(CGPointMake(67.5, 61.5), controlPoint1: CGPointMake(82.5, 51.5), controlPoint2: CGPointMake(70, 60.5))
        self.polandMapPath.addCurveToPoint(CGPointMake(60.5, 75.5), controlPoint1: CGPointMake(65, 62.5), controlPoint2: CGPointMake(63.5, 74.75))
        self.polandMapPath.addCurveToPoint(CGPointMake(55, 70), controlPoint1: CGPointMake(57.5, 76.25), controlPoint2: CGPointMake(57.5, 70))
        self.polandMapPath.addCurveToPoint(CGPointMake(51.5, 73.5), controlPoint1: CGPointMake(52.5, 70), controlPoint2: CGPointMake(53.75, 74.5))
        self.polandMapPath.addCurveToPoint(CGPointMake(42.5, 66.5), controlPoint1: CGPointMake(49.25, 72.5), controlPoint2: CGPointMake(45, 67.5))
        self.polandMapPath.addCurveToPoint(CGPointMake(35.5, 69.5), controlPoint1: CGPointMake(40, 65.5), controlPoint2: CGPointMake(38.25, 71.25))
        self.polandMapPath.addCurveToPoint(CGPointMake(29.5, 64.5), controlPoint1: CGPointMake(32.75, 67.75), controlPoint2: CGPointMake(30.5, 67.5))
        self.polandMapPath.addCurveToPoint(CGPointMake(21.5, 61.5), controlPoint1: CGPointMake(28.5, 61.5), controlPoint2: CGPointMake(21.5, 61.5))
        self.polandMapPath.addCurveToPoint(CGPointMake(17.5, 55.5), controlPoint1: CGPointMake(21.5, 61.5), controlPoint2: CGPointMake(19, 57.5))
        self.polandMapPath.addCurveToPoint(CGPointMake(11.5, 55.5), controlPoint1: CGPointMake(16, 53.5), controlPoint2: CGPointMake(13.5, 59.5))
        self.polandMapPath.addCurveToPoint(CGPointMake(5.5, 49.5), controlPoint1: CGPointMake(9.5, 51.5), controlPoint2: CGPointMake(9.5, 49.5))
        self.polandMapPath.addCurveToPoint(CGPointMake(0.5, 30.5), controlPoint1: CGPointMake(1.5, 49.5), controlPoint2: CGPointMake(0.5, 34.5))
        self.polandMapPath.addCurveToPoint(CGPointMake(2.5, 12.5), controlPoint1: CGPointMake(0.5, 26.5), controlPoint2: CGPointMake(2.5, 17.5))
        self.polandMapPath.addCurveToPoint(CGPointMake(14.5, 7.5), controlPoint1: CGPointMake(2.5, 7.5), controlPoint2: CGPointMake(10.25, 9.75))
        self.polandMapPath.addCurveToPoint(CGPointMake(20.5, 3.5), controlPoint1: CGPointMake(18.75, 5.25), controlPoint2: CGPointMake(14.5, 5.75))
        self.polandMapPath.addCurveToPoint(CGPointMake(34.5, 0.5), controlPoint1: CGPointMake(26.5, 1.25), controlPoint2: CGPointMake(27.25, 0))
        self.polandMapPath.addCurveToPoint(CGPointMake(36.5, 3.5), controlPoint1: CGPointMake(41.75, 1), controlPoint2: CGPointMake(36.5, 1.75))
        self.polandMapPath.addCurveToPoint(CGPointMake(30.5, 7.5), controlPoint1: CGPointMake(36.5, 5.25), controlPoint2: CGPointMake(28.5, 3.5))
        self.polandMapPath.addCurveToPoint(CGPointMake(45.5, 7.5), controlPoint1: CGPointMake(32.5, 11.5), controlPoint2: CGPointMake(40.5, 7.5))
        self.polandMapPath.addCurveToPoint(CGPointMake(60.5, 9.5), controlPoint1: CGPointMake(50.5, 7.5), controlPoint2: CGPointMake(55.5, 9.5))
        self.polandMapPath.addCurveToPoint(CGPointMake(70.5, 15.5), controlPoint1: CGPointMake(65.5, 9.5), controlPoint2: CGPointMake(70.5, 8.5))
        self.polandMapPath.addCurveToPoint(CGPointMake(70.5, 25.5), controlPoint1: CGPointMake(70.5, 22.5), controlPoint2: CGPointMake(74.5, 20.5))
        self.polandMapPath.addCurveToPoint(CGPointMake(70.5, 35.5), controlPoint1: CGPointMake(66.5, 30.5), controlPoint2: CGPointMake(70.5, 32.5))
        self.polandMapPath.addCurveToPoint(CGPointMake(75.5, 39.5), controlPoint1: CGPointMake(70.5, 38.5), controlPoint2: CGPointMake(74.75, 37.25))
        self.polandMapPath.addCurveToPoint(CGPointMake(75.5, 49.5), controlPoint1: CGPointMake(76.25, 41.75), controlPoint2: CGPointMake(74.5, 46.25))
        self.polandMapPath.lineCapStyle = kCGLineCapRound;
        
        let xScale = self.bounds.size.width / 95.0;
        let yScale = self.bounds.size.height / 95.0;
        self.polandMapPath.applyTransform(CGAffineTransformMakeScale(xScale, yScale))
        
        
        self.mapShapeLayer.path = self.polandMapPath.CGPath
        self.mapShapeLayer.fillColor = UIColor.clearColor().CGColor
        self.mapShapeLayer.strokeColor = UIColor.blackColor().CGColor
        self.mapShapeLayer.lineWidth = 1
        self.layer.addSublayer(self.mapShapeLayer)
        
        
        //// Arrow Layer
        self.arrowPath.moveToPoint(CGPointMake(42.5, 56.5))
        self.arrowPath.addCurveToPoint(CGPointMake(95.5, 5.5), controlPoint1: CGPointMake(50.25, 17.77), controlPoint2: CGPointMake(85.65, 7.49))
        self.arrowPath.addCurveToPoint(CGPointMake(89.5, 13.5), controlPoint1: CGPointMake(96.45, 5.31), controlPoint2: CGPointMake(92.5, 7.5))
        self.arrowPath.addCurveToPoint(CGPointMake(89.5, 8.5), controlPoint1: CGPointMake(88.64, 15.22), controlPoint2: CGPointMake(88.5, 11.5))
        self.arrowPath.addCurveToPoint(CGPointMake(83.5, 2.5), controlPoint1: CGPointMake(90.2, 6.4), controlPoint2: CGPointMake(84.12, 3.96))
        self.arrowPath.addCurveToPoint(CGPointMake(95.5, 5.5), controlPoint1: CGPointMake(82.91, 1.11), controlPoint2: CGPointMake(95.5, 5.5))
        self.arrowPath.lineWidth = 1
        self.arrowPath.applyTransform(CGAffineTransformMakeScale(xScale, yScale))

        self.arrowLayer.path = self.arrowPath.CGPath
        self.arrowLayer.fillColor = UIColor.clearColor().CGColor
        self.arrowLayer.strokeColor = UIColor.blackColor().CGColor
        self.arrowLayer.lineWidth = 1
        self.arrowLayer.shadowColor = UIColor.lightGrayColor().CGColor
        self.arrowLayer.shadowOpacity = 1
        self.arrowLayer.shadowOffset = CGSizeMake(2, 2)
        self.layer.addSublayer(self.arrowLayer)
        
        self.arrowLayer.hidden = true
        self.mapShapeLayer.hidden = true
        
        self.countryLabel.text = "POLAND"
        self.countryLabel.font = UIFont(name: "HelveticaNeue-UltraLightItalic", size: 25)
        self.countryLabel.sizeToFit()
        self.countryLabel.alpha = 0
        self.countryLabel.textColor = UIColor.grayColor()
//        self.addSubview(self.countryLabel)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        self.countryLabel.center = CGPointMake(CGRectGetMidX(self.bounds) - self.bounds.size.width/6,
                                                CGRectGetMidY(self.bounds) - self.bounds.size.height/5)
    }
    
}
