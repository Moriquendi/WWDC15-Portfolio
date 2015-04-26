//
//  AGHacksViewController.swift
//  WWDC15
//
//  Created by Michal Smialko on 25/04/15.
//  Copyright (c) 2015 Michal Smialko. All rights reserved.
//

import UIKit
import MediaPlayer

class AGHacksViewController: UIViewController,
UICollectionViewDataSource,
UICollectionViewDelegate {

    @IBOutlet weak var logoView: UIImageView!
    let kImageCell = "kImageCell"
    @IBOutlet weak var movieContentView: UIView!
    var images = []
    let moviePlayer: MPMoviePlayerController!
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: NSBundle?) {
        let movieURL = NSBundle.mainBundle().URLForResource("aghacksPromo", withExtension: "mp4")
        self.moviePlayer = MPMoviePlayerController(contentURL: movieURL!)
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }

    required init(coder aDecoder: NSCoder) {
        let movieURL = NSBundle.mainBundle().URLForResource("aghacksPromo", withExtension: "mp4")
        self.moviePlayer = MPMoviePlayerController(contentURL: movieURL!)
        super.init(coder: aDecoder)
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        self.moviePlayer.pause()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.translucent = true
        self.navigationController?.navigationBar.opaque = false
        
        self.logoView.layer.cornerRadius = self.logoView.bounds.size.width/2
        
        let imagesNames = ["aghacksteam", "aghacks1", "aghacks2", "aghacks3",
        "aghacks4","aghacks5","aghacks6","aghacks7","aghacks8"]
        for name in imagesNames {
            self.images = self.images.arrayByAddingObject(UIImage(named: name)!)
        }
        
        
        self.navigationItem.leftBarButtonItem?.target = self
        self.navigationItem.leftBarButtonItem?.action = Selector("dismiss")
        
        self.movieContentView.addSubview(self.moviePlayer.view)
        self.moviePlayer.view.frame = self.movieContentView.bounds
        self.moviePlayer.view.autoresizingMask = .FlexibleWidth | .FlexibleHeight
        self.moviePlayer.play()
    }
    
    func dismiss() {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    // MARK: UICollectionViewDataSource
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.images.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(kImageCell, forIndexPath: indexPath) as! ImageCollectionViewCell
        
        cell.imageView.image = self.images[indexPath.item] as? UIImage
        
        return cell
    }

}
