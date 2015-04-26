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
    var projects = Array<Project>()
    
    func loadModel() {
        let pandaApp = Project()
        pandaApp.title = "Karate Panda"
        pandaApp.appDescription = " meh meh"
        pandaApp.images = [UIImage(named: "pandMacs")!]
        
        let farmApp = Project()
        farmApp.title = "Farm 2"
        farmApp.appDescription = " meh meh"
        farmApp.images = [UIImage(named: "farm1")!,
                            UIImage(named: "farm2")!]
        
        let tapsApp = Project()
        tapsApp.title = "Smart Taps"
        tapsApp.appDescription = "meh meh"
        tapsApp.images = [UIImage(named: "smart1")!]
        
        let tvtApp = Project()
        tvtApp.title = "TVT - Online TV App"
        tvtApp.appDescription = "TVT"
        tvtApp.images = [UIImage(named: "tvt")!]
        
        let ggjApp = Project()
        ggjApp.title = "Global Game Jam app"
        ggjApp.appDescription = "meh meh"
        ggjApp.images = [UIImage(named: "krakjam")!]
        
        let mhacksApp = Project()
        mhacksApp.title = "Sched.me - MHacks hackathon app"
        mhacksApp.appDescription = "meh"
        mhacksApp.images = [UIImage(named: "sched1")!]
        
        self.projects = [pandaApp, farmApp, tapsApp, tvtApp, ggjApp, mhacksApp]
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.loadModel()
        self.collectionView.decelerationRate = UIScrollViewDecelerationRateFast
        
        self.navigationItem.leftBarButtonItem?.target = self
        self.navigationItem.leftBarButtonItem?.action = Selector("dismiss")
    }
    
    func dismiss() {
        self.dismissViewControllerAnimated(true, completion: nil)
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
            
            
            if let selectedCellIndex = self.collectionView.indexPathsForSelectedItems().first as? NSIndexPath,
                let detailsVC = vc as? ProjectDetailsViewController {
                    detailsVC.project = self.projects[selectedCellIndex.item]
            }
        }
    }
    
    // MARK: UICollectionViewDataSource
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.projects.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        let cell: UICollectionViewCell =
        collectionView.dequeueReusableCellWithReuseIdentifier(kProjectCellIdentifier, forIndexPath: indexPath) as! UICollectionViewCell
        
        self.configureCell(cell, atIndexPath: indexPath)
        
        return cell
    }
    
    // MARK:  UICollectionViewDelegate
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {

        let cell = collectionView.cellForItemAtIndexPath(indexPath)
        if (cell!.center.x < collectionView.contentOffset.x ||
            cell!.center.x > collectionView.contentOffset.x + collectionView.bounds.size.width) {
        }
        else {
            self.performSegueWithIdentifier(kProjectDetailsSegue, sender: self)
        }
    }
    
    // MARK: ProjectsViewController
    
    func configureCell(cell: UICollectionViewCell, atIndexPath indexPath: NSIndexPath) {
        if let carouselCell = cell as? ProjectCollectionViewCell {
            let project = self.projects[indexPath.item]
            carouselCell.imageView.image = project.images.first
            carouselCell.titleLabel.text = project.title
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
