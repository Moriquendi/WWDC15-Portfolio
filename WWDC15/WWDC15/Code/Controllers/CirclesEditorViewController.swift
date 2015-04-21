//
//  CirclesEditorViewController.swift
//  WWDC15
//
//  Created by Michal Smialko on 19/04/15.
//  Copyright (c) 2015 Michal Smialko. All rights reserved.
//

import UIKit

class CirclesEditorViewController: UIViewController {

    var selectedIndex = -1 {
        willSet {
            self.deselectCirle()
        }
        didSet {
            self.selectCircle()
        }
    }
    var circles: Array<CircleView>
    @IBOutlet weak var slider: UISlider!
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: NSBundle?) {
        self.circles = []
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }

    required init(coder aDecoder: NSCoder) {
        self.circles = []
        super.init(coder: aDecoder)
    }
    
    // MARK: UIViewController
    
    func selectedCircle() -> CircleView? {
        if (self.selectedIndex >= 0 && self.selectedIndex < self.circles.count) {
            return self.circles[self.selectedIndex]
        }
        return nil
    }
    
    func deselectCirle() {
        self.selectedCircle()?.selected = false
    }
    
    func selectCircle() {
        self.selectedCircle()?.selected = true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.loadCircles()
    }
    
    func loadCircles() {
        let paths = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true);
        let documentsDirectory: NSString = paths[0] as! NSString
        let plistPath = documentsDirectory.stringByAppendingPathComponent("points.plist")
        let data = NSArray(contentsOfFile: plistPath)
        
        data?.enumerateObjectsUsingBlock({ (object: AnyObject!, index: Int, stop: UnsafeMutablePointer<ObjCBool>) -> Void in
            let dict = object as! Dictionary<String, CGFloat>
            
            let center = CGPointMake(dict["x"]!, dict["y"]!)
            let size = dict["size"]!
            let circle = self.addNewCircleWithSize(size, text: String(index), center: center)
            
            let hue = CGFloat(((40 + index*4) % 360 ))/360
            circle.backgroundColor = UIColor(hue: hue,
                saturation: 0.70,
                brightness: 0.84,
                alpha: 0.8)
            circle.label.hidden = true
        })
    }
    
    func addNewCircleWithSize(size: CGFloat, text: String, center: CGPoint) -> CircleView {
        let newCircle = CircleView()
        newCircle.frame = CGRectMake(0, 0, size, size)
        newCircle.label.text = String(circles.count)
        circles.append(newCircle)
        
        self.view.addSubview(newCircle)
        newCircle.center = center
        
        return newCircle
    }
    
    @IBAction func didTapAddNew(sender: AnyObject) {
        self.addNewCircleWithSize(CGFloat(100),
                                text: String(circles.count),
                                center: CGPointMake(CGRectGetMidX(self.view.bounds),
                                                    CGRectGetMidY(self.view.bounds)))
        
        self.selectedIndex = self.circles.count - 1
        self.slider.value = 100
    }
    
    @IBAction func didChangeSize(slider: UISlider) {
        if self.selectedIndex >= 0 && self.selectedIndex < self.circles.count {
            let view = circles[self.selectedIndex]
            let oldCenter = view.center
            view.frame = CGRectMake(0, 0, CGFloat(slider.value), CGFloat(slider.value))
            view.center = oldCenter
        }
    }
    
    @IBAction func didChangeSelectedCircleIndex(sender: UITextField) {
        if let circleIndex = sender.text.toInt() {
           self.selectedIndex = circleIndex
        }
        else {
            self.selectedIndex = -1
        }
    }
    
    @IBAction func tapRecognized(tap: UITapGestureRecognizer) {
        let point = tap.locationInView(self.view)

        for (index, view) in enumerate(self.circles) {
            if (CGRectContainsPoint(view.frame, point)) {
                self.selectedIndex = index
                break
            }
        }
    }
    
    @IBAction func panGestureRecognized(pan: UIPanGestureRecognizer) {
        let circle = self.selectedCircle()
        if (pan.state == UIGestureRecognizerState.Ended) {
            circle?.frame = CGRectApplyAffineTransform(circle!.frame, circle!.transform)
            circle?.transform = CGAffineTransformIdentity
        }
        else {
            let translation = pan.translationInView(self.view)
            circle?.transform = CGAffineTransformTranslate(CGAffineTransformIdentity, translation.x, translation.y)
        }
    }
    
    
    @IBAction func didTapSave(sender: AnyObject) {
        let paths = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true);
        let documentsDirectory: NSString = paths[0] as! NSString
        let plistPath = documentsDirectory.stringByAppendingPathComponent("points.plist")

        let manager = NSFileManager.defaultManager()
        manager.createFileAtPath(plistPath, contents: nil, attributes: nil)
        
        let content = NSMutableArray()
        for (index, view) in enumerate(self.circles) {
            let dict = ["x" : view.center.x,
                        "y" : view.center.y,
                        "size" : view.bounds.size.width]
            content.addObject(dict)
        }
        content.writeToFile(plistPath, atomically: false)
        
        println("Saved to \(plistPath)")
    }
}
