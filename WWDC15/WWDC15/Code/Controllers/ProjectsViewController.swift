//
//  ProjectsViewController.swift
//  WWDC15
//
//  Created by Michal Smialko on 15/04/15.
//  Copyright (c) 2015 Michal Smialko. All rights reserved.
//

import UIKit

class ProjectsViewController: UIViewController {

    let kProjectCellIdentifier = "kProjectCellIdentifier"
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        var nib = UINib(nibName: "ProjectCollectionViewCell", bundle: nil)
        self.collectionView.registerNib(nib, forCellWithReuseIdentifier: kProjectCellIdentifier)
        self.collectionView.decelerationRate = UIScrollViewDecelerationRateFast
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        let CAROUSEL_PAGE_SIZE = CGSizeMake(550, 450)
        if let carouselLayout = self.collectionView.collectionViewLayout as? PBDCarouselCollectionViewLayout
        {
            carouselLayout.itemSize = CAROUSEL_PAGE_SIZE
            carouselLayout.interItemSpace = 150;
            carouselLayout.invalidateLayout()
        }
    }
    
    // MARK: UICollectionViewDataSource
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        let cell: UICollectionViewCell =
        collectionView.dequeueReusableCellWithReuseIdentifier(kProjectCellIdentifier, forIndexPath: indexPath) as! UICollectionViewCell
        
        self.configureCell(cell, atIndexPath: indexPath)
        
        return cell
    }
    
    // MARK: ProjectsViewController
    
    func configureCell(cell: UICollectionViewCell, atIndexPath indexPath: NSIndexPath) {
        if let carouselCell = cell as? ProjectCollectionViewCell {
            carouselCell.backgroundColor = UIColor.redColor()
            carouselCell.layer.shadowColor = UIColor.blackColor().CGColor
            carouselCell.layer.shadowOpacity = 0.5
            carouselCell.clipsToBounds = falser
            carouselCell.layer.shadowRadius = 20
        }
    }
    
}
