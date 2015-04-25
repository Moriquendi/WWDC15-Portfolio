//
//  GradientView.swift
//  WWDC15
//
//  Created by Michal Smialko on 16/04/15.
//  Copyright (c) 2015 Michal Smialko. All rights reserved.
//

import UIKit

@IBDesignable
class GradientView: UIView {
    
    let kLinearGradientType = "kLinearGradientType"
    let kRadialGradientType = "kRadialGradientType"
    
    @IBInspectable var startColor: UIColor? {
        didSet {
            self.updateLayerColors()
        }
    }
    @IBInspectable var endColor: UIColor? {
        didSet {
            self.updateLayerColors()
        }
    }
    @IBInspectable var type: NSString? {
        didSet {
            self.reloadLayers()
        }
    }

    private var gradientLayer: CALayer!
   
    // MARK: UIView
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.initialize()
    }

    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.initialize()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.gradientLayer.frame = self.bounds
        
        if let radialGradient = self.gradientLayer as? CCARadialGradientLayer {
            radialGradient.gradientOrigin = CGPointMake(self.bounds.size.width/2, self.bounds.size.height/2)
            radialGradient.gradientRadius = self.bounds.size.width/3
        }
    }
    
    // MARK: GradientView
    
    func initialize() {
        self.backgroundColor = UIColor.clearColor()
        self.startColor = UIColor.blackColor()
        self.endColor = UIColor.whiteColor()
        self.type = kLinearGradientType
        
        self.reloadLayers()
    }
    
    func reloadLayers() {
        self.gradientLayer?.removeFromSuperlayer()
        
        if (self.type == kLinearGradientType) {
            let linearGradient = CAGradientLayer()
            linearGradient.startPoint = CGPointMake(0.5, 0.5)
            linearGradient.endPoint = CGPointMake(0.5, 1)
            self.gradientLayer = linearGradient
        }
        else if (self.type == kRadialGradientType) {
            let radialGradient = CCARadialGradientLayer()
            radialGradient.locations = [0, 1]
            self.gradientLayer = radialGradient
        }
        self.gradientLayer.opaque = false
        self.layer.insertSublayer(self.gradientLayer, atIndex: 0)
        self.layer.backgroundColor = UIColor.clearColor().CGColor
        
        self.updateLayerColors()
    }
    
    func updateLayerColors() {
        if let start = self.startColor,
            let end = self.endColor {
                let colors = [start.CGColor,
                                end.CGColor]
                
                if let linearGradient = self.gradientLayer as? CAGradientLayer {
                    linearGradient.colors = colors
                }
                else if let radialGradient = self.gradientLayer as? CCARadialGradientLayer {
                    radialGradient.colors = colors
                }
        }
    }
}
