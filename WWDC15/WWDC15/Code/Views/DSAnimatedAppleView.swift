import UIKit

class DSAnimatedAppleView: UIView {

    var circles: Array<CircleView> = []
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.initialize()
    }

    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.initialize()
    }
    
    func initialize() {
        self.circles = []
        self.loadCircles()
        
        let tap = UITapGestureRecognizer(target: self, action: Selector("meh"))
        self.addGestureRecognizer(tap)
    }
    
    func meh() {
        self.startAnimation()
    }
    
    func shuffle<C: MutableCollectionType where C.Index == Int>(var list: C) -> C {
        let c = count(list)
        for i in 0..<(c - 1) {
            let j = Int(arc4random_uniform(UInt32(c - i))) + i
            swap(&list[i], &list[j])
        }
        return list
    }
    
    func startAnimation() {
        for circleView in self.circles {
            circleView.transform = CGAffineTransformTranslate(CGAffineTransformIdentity, 0, self.bounds.size.height)
        }

        var idx = 0
        for circleView in shuffle(self.circles) {
            UIView.animateWithDuration(
                2,
                delay: NSTimeInterval(0.01 * CGFloat(idx)),
                usingSpringWithDamping: 0.8,
                initialSpringVelocity: 0,
                options: UIViewAnimationOptions.CurveEaseOut,
                animations:
                { () -> Void in
                    circleView.transform = CGAffineTransformIdentity
                })
                { (finished) -> Void in
                    self.animateOut()
                }
            
            idx = idx + 1
        }
    }
    
    func animateOut() {
        var idx = 0
        for circleView in shuffle(self.circles) {
            UIView.animateWithDuration(
                1.3,
                delay: NSTimeInterval(1.5 + 0.005 * CGFloat(idx)),
                options: UIViewAnimationOptions.CurveEaseIn,
                animations:
                { () -> Void in
                    circleView.transform = CGAffineTransformTranslate(CGAffineTransformIdentity, 0, -self.bounds.size.height)
                })
                { (finished) -> Void in
                    
            }
            
            idx = idx + 1
        }
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
        newCircle.label.text = text
        circles.append(newCircle)
        
        self.addSubview(newCircle)
        newCircle.center = center
        
        return newCircle
    }

}


class CircleView: UIView {
    
    var label: UILabel!
    var selected: Bool = false {
        didSet {
            self.layer.borderWidth = selected ? 1 : 0
        }
    }
    
    func initialize() {
        self.clipsToBounds = true
        self.layer.borderColor = UIColor.redColor().CGColor
        
        let hue: CGFloat = CGFloat(random() % 255) / 255
        self.backgroundColor = UIColor(hue: hue,
            saturation: hue,
            brightness: hue,
            alpha: 0.4)
        
        self.label = UILabel()
        self.label.backgroundColor = UIColor.clearColor()
        self.label.textColor = UIColor.whiteColor().colorWithAlphaComponent(0.4)
        self.addSubview(label)
    }
    
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
        self.layer.cornerRadius = self.bounds.size.width / 2
        
        self.label.sizeToFit()
        self.label.center = CGPointMake(CGRectGetMidX(self.bounds),
            CGRectGetMidY(self.bounds))
    }
}



