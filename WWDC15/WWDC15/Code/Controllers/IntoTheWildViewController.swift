//
//  IntoTheWildViewController.swift
//  WWDC15
//
//  Created by Michal Smialko on 21/04/15.
//  Copyright (c) 2015 Michal Smialko. All rights reserved.
//

import UIKit

class IntoTheWildViewController: UIViewController,
UICollectionViewDataSource,
UICollectionViewDelegate {

    @IBOutlet weak var collectionView: UICollectionView!
    var views: Array<UIView> = []
    let kCellIdentifier = "kCellIdentifier"
    // MARK: UIViewController

    override func viewDidLoad() {
        super.viewDidLoad()
        self.loadPages()
        
        
        self.collectionView.registerClass(UICollectionViewCell.classForCoder(),
            forCellWithReuseIdentifier: kCellIdentifier)
        self.collectionView.pagingEnabled = true
    }
    
    func loadPages()
    {
        self.views = NSBundle.mainBundle().loadNibNamed("IntoTheWildView", owner: self, options:nil) as! [UIView]
    }
 
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.views.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(kCellIdentifier, forIndexPath: indexPath) as! UICollectionViewCell
        
//        let colors = [UIColor.redColor(), UIColor.greenColor(), UIColor.blueColor()]
//        cell.backgroundColor = colors[indexPath.item]
        cell.layer.shadowColor = UIColor.blackColor().CGColor
        cell.layer.shadowOpacity = 0.5
        cell.clipsToBounds = false
        cell.layer.shadowRadius = 20

        let pageView = self.views[indexPath.item]
        cell.contentView.addSubview(pageView)
        pageView.frame = cell.contentView.bounds
        
        return cell
    }
    
}
