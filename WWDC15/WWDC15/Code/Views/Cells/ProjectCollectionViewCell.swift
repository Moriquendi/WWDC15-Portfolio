//
//  ProjectCollectionViewCell.swift
//  WWDC15
//
//  Created by Michal Smialko on 15/04/15.
//  Copyright (c) 2015 Michal Smialko. All rights reserved.
//

import UIKit

class ProjectCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()

        self.backgroundColor = UIColor.clearColor()
        self.clipsToBounds = true
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.initialize()
    }

    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.initialize()
    }

    
    func initialize() {
       let contentView = NSBundle.mainBundle().loadNibNamed("ProjectCollectionViewCell", owner: self, options:nil).first as! UIView
        contentView.frame = self.bounds
        contentView.autoresizingMask = .FlexibleWidth | .FlexibleHeight
        self.addSubview(contentView)
    }

}
