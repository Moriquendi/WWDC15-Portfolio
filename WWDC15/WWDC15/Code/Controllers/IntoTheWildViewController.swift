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
    let kCellIdentifier = "kCellIdentifier"
    // MARK: UIViewController

    override func viewDidLoad() {
        super.viewDidLoad()

        self.collectionView.registerClass(UICollectionViewCell.classForCoder(),
            forCellWithReuseIdentifier: kCellIdentifier)
        self.collectionView.pagingEnabled = true
    }
 
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3;
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(kCellIdentifier, forIndexPath: indexPath) as! UICollectionViewCell
        
        let colors = [UIColor.redColor(), UIColor.greenColor(), UIColor.blueColor()]
        
        cell.backgroundColor = colors[indexPath.item]
        cell.layer.shadowColor = UIColor.blackColor().CGColor
        cell.layer.shadowOpacity = 0.5
        cell.clipsToBounds = false
        cell.layer.shadowRadius = 20
        
        return cell
    }
    
}
