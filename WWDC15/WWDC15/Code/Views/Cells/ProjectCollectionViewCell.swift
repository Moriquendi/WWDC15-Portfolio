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

        self.backgroundColor = UIColor.redColor()
        self.layer.shadowColor = UIColor.blackColor().CGColor
        self.layer.shadowOpacity = 0.5
        self.clipsToBounds = false
        self.layer.shadowRadius = 20
    }

}
