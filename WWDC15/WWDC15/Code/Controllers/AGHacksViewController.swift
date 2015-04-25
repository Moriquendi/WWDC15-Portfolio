//
//  AGHacksViewController.swift
//  WWDC15
//
//  Created by Michal Smialko on 25/04/15.
//  Copyright (c) 2015 Michal Smialko. All rights reserved.
//

import UIKit

class AGHacksViewController: UIViewController,
UICollectionViewDataSource,
UICollectionViewDelegate {

    @IBOutlet weak var logoView: UIImageView!
    let kImageCell = "kImageCell"
    @IBOutlet weak var movieContentView: UIView!
    var images = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.logoView.layer.cornerRadius = self.logoView.bounds.size.width/2
        
        let imagesNames = ["aghacksteam", "aghacksteam", "aghacksteam", "aghacksteam"]
        for name in imagesNames {
            self.images = self.images.arrayByAddingObject(UIImage(named: name)!)
        }
    }
    
    // MARK: UICollectionViewDataSource
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.images.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(kImageCell, forIndexPath: indexPath) as! ImageCollectionViewCell
        
        cell.imageView.image = self.images[indexPath.item] as! UIImage
        
        return cell
    }

}
