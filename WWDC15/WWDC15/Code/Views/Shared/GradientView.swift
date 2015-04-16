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

    private var gradientLayer: CAGradientLayer!
   
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
    }
    
    // MARK: GradientView
    
    func initialize() {
        self.backgroundColor = UIColor.clearColor()
        
        self.gradientLayer = CAGradientLayer()
        self.gradientLayer.startPoint = CGPointMake(0.5, 0.5)
        self.gradientLayer.endPoint = CGPointMake(0.5, 1)
        self.gradientLayer.opaque = false
        self.layer.addSublayer(self.gradientLayer)
        self.layer.backgroundColor = UIColor.clearColor().CGColor
        self.updateLayerColors()
    }
    
    func updateLayerColors() {
        if let start = self.startColor,
            let end = self.endColor {
                let colors = [start.CGColor,
                                end.CGColor]
                self.gradientLayer.colors = colors
        }
    }
}
