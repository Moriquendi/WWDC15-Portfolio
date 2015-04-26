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
        self.navigationController?.navigationBar.translucent = false
        self.navigationController?.navigationBar.opaque = true
        super.viewDidLoad()
        
        self.loadPages()
        
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Close", style: UIBarButtonItemStyle.Plain, target: self, action: Selector("dismiss"))
    }
    
    func dismiss() {
        self.dismissViewControllerAnimated(true, completion: nil)
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
        
        for view in cell.contentView.subviews {
            view.removeFromSuperview()
        }
        
        let pageView = self.views[indexPath.item]
        cell.contentView.addSubview(pageView)
        pageView.autoresizingMask = .FlexibleWidth | .FlexibleHeight
        pageView.frame = cell.contentView.bounds
        
        return cell
    }
    
}
