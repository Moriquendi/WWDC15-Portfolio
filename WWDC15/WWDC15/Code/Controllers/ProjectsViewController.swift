//
//  ProjectsViewController.swift
//  WWDC15
//
//  Created by Michal Smialko on 15/04/15.
//  Copyright (c) 2015 Michal Smialko. All rights reserved.
//

import UIKit

class ProjectsViewController: UIViewController,
UICollectionViewDataSource,
UICollectionViewDelegate,
UIViewControllerTransitioningDelegate {

    let kProjectDetailsSegue = "kProjectDetailsSegue"
    let kProjectCellIdentifier = "kProjectCellIdentifier"
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
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
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if let identifier = segue.identifier,
            let vc = segue.destinationViewController as? UIViewController
        {
            switch (identifier) {
                case kProjectDetailsSegue:
                    vc.transitioningDelegate = self
                vc.modalPresentationStyle = UIModalPresentationStyle.Custom
                default:
                    println("Do nothing")
            }
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
    
    // MARK:  UICollectionViewDelegate
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        self.performSegueWithIdentifier(kProjectDetailsSegue, sender: self)
    }
    
    // MARK: ProjectsViewController
    
    func configureCell(cell: UICollectionViewCell, atIndexPath indexPath: NSIndexPath) {
        if let carouselCell = cell as? ProjectCollectionViewCell {
            carouselCell.imageView.image = UIImage(named: "panda3")
        }
    }
 
    // MARK: UIViewControllerTransitioningDelegate

    func animationControllerForDismissedController(dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        
        let indexPath = self.collectionView.indexPathsForSelectedItems().last as! NSIndexPath
        let cell = self.collectionView.cellForItemAtIndexPath(indexPath)
        let transition = SpreadingTransition(referenceView: cell!, dismissing: true)
        return transition
    }
    
    func animationControllerForPresentedController(presented: UIViewController, presentingController presenting: UIViewController, sourceController source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        let indexPath = self.collectionView.indexPathsForSelectedItems().last as! NSIndexPath
        let cell = self.collectionView.cellForItemAtIndexPath(indexPath)
        let transition = SpreadingTransition(referenceView: cell!, dismissing: false)
        return transition
    }
    
}
